# Manual Testing Guide for User Tracking Feature

## Prerequisites
1. Apply the database migration (see `db/README_MIGRATION.md`)
2. Have at least two user accounts for testing (e.g., "administrador" and "Lina")
3. Access to the OSM web application

## Test Scenarios

### Test 1: Creating a New Training Form
**Objective**: Verify that the system records who created the form

**Steps**:
1. Log in as user "administrador"
2. Navigate to `/m_capacitaciones/formulario.html`
3. Fill in all required fields:
   - Select a process
   - Select a location
   - Enter responsible person's cedula and search
   - Select activity type and theme
   - Enter start time, end time, and date
   - Add at least one attendee
   - Add observations (optional)
4. Click "Guardar y Registrar"
5. Note the ID of the created form (e.g., "Capacitación creada con éxito en el ID asignado: 1")

**Expected Results**:
- Form should be created successfully
- The creator should be recorded in the database as "administrador"

### Test 2: Viewing Creator Information in Edit Form
**Objective**: Verify that the edit form shows who created the training

**Steps**:
1. Stay logged in as "administrador"
2. Navigate to `/m_capacitaciones/ed_formulario.html`
3. Find the form created in Test 1
4. Click the edit button (pencil icon)
5. Look for the blue info box at the top of the modal

**Expected Results**:
- The info box should show: "Registro creado por: administrador"
- The "Última edición por:" field should show "No editado"

### Test 3: Editing a Training Form
**Objective**: Verify that the system records who edited the form

**Steps**:
1. Log out from "administrador" account
2. Log in as user "Lina"
3. Navigate to `/m_capacitaciones/ed_formulario.html`
4. Find the same form from Test 1
5. Click the edit button
6. Make a change (e.g., change the observations)
7. Click "Guardar"
8. Close and reopen the edit modal for the same form

**Expected Results**:
- The info box should now show:
  - "Registro creado por: administrador"
  - "Última edición por: Lina"

### Test 4: Viewing in Consultation Table
**Objective**: Verify that creator/editor info appears in the consultation table

**Steps**:
1. Stay logged in as any user
2. Navigate to `/m_capacitaciones/Consultas_capacitacion.html`
3. Find the form from Test 1 in the table
4. Look at the "Registrado por" column (last column)

**Expected Results**:
- For a newly created form: "Creado por: administrador"
- For an edited form: 
  ```
  Creado por: administrador
  Editado por: Lina
  ```

### Test 5: Filtering by Creator/Editor
**Objective**: Verify that the filter works for the "Registrado por" column

**Steps**:
1. In the consultation table
2. Type "administrador" in the filter input of the "Registrado por" column
3. Press Enter or wait for auto-filter

**Expected Results**:
- Only forms created by "administrador" should be shown
- The filter should work for both creator and editor names

### Test 6: Sorting by Creator
**Objective**: Verify that sorting works for the "Registrado por" column

**Steps**:
1. In the consultation table
2. Click the sort icon in the "Registrado por" column header
3. Click again to reverse the sort order

**Expected Results**:
- Forms should be sorted alphabetically by creator name
- Clicking again should reverse the sort order

### Test 7: Excel Export with Creator/Editor Info
**Objective**: Verify that Excel export includes creator and editor information

**Steps**:
1. In the consultation table
2. Click the download button (green button with export icon)
3. Select any of the export options:
   - "Todo (.xlsx)" - exports all data
   - "Filtrado (.xlsx)" - exports filtered data
   - "Selección (.xlsx)" - exports selected rows
4. Open the downloaded Excel file
5. Look for the last two columns

**Expected Results**:
- Excel file should have two new columns:
  - "creado por" - showing creator's name
  - "editado por" - showing editor's name or "No editado"
- Data should match what's shown in the web interface

### Test 8: Multiple Edits
**Objective**: Verify that only the last editor is recorded

**Steps**:
1. Log in as "administrador"
2. Edit a form created by "Lina"
3. Save the changes
4. Check the "Registrado por" column

**Expected Results**:
- "Creado por: Lina"
- "Editado por: administrador"
- Only the most recent editor should be shown

## Troubleshooting

### Issue: "No hay sesión activa" error
**Solution**: Make sure you're logged in before creating or editing forms

### Issue: Creator/editor showing as "No disponible"
**Solution**: 
1. Check if the database migration was applied correctly
2. Verify that the session is working properly
3. Check that the user exists in the `adm_usuarios` table

### Issue: Changes not visible in consultation table
**Solution**: Refresh the page or clear browser cache

## Database Verification Queries

To verify the data in the database:

```sql
-- Check a specific form's tracking info
SELECT 
  f.id,
  f.fecha,
  creador.nombre1 || ' ' || creador.apellido1 AS creado_por,
  f.fecha_creacion,
  editor.nombre1 || ' ' || editor.apellido1 AS editado_por,
  f.fecha_edicion
FROM cap_formulario f
LEFT JOIN adm_usuarios creador ON f.creado_por = creador.id
LEFT JOIN adm_usuarios editor ON f.editado_por = editor.id
WHERE f.id = 1; -- Change to your form ID
```

```sql
-- List all forms with their creators and editors
SELECT 
  f.id,
  t.nombre AS tema,
  creador.nombre1 || ' ' || creador.apellido1 AS creado_por,
  TO_CHAR(f.fecha_creacion, 'DD/MM/YYYY HH24:MI') AS fecha_creacion,
  editor.nombre1 || ' ' || editor.apellido1 AS editado_por,
  TO_CHAR(f.fecha_edicion, 'DD/MM/YYYY HH24:MI') AS fecha_edicion
FROM cap_formulario f
LEFT JOIN cap_tema t ON f.id_tema = t.id
LEFT JOIN adm_usuarios creador ON f.creado_por = creador.id
LEFT JOIN adm_usuarios editor ON f.editado_por = editor.id
ORDER BY f.id DESC
LIMIT 20;
```
