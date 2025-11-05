# Testing Guide for items_formularios.html

## Prerequisites

Before testing, ensure the database migration has been applied:

```bash
psql -U postgres -d osm2 -f db/03_r_update\ formulario.sql
```

This adds the `estado` column to all capacity tables.

## Test Environment Setup

1. **Database Connection**
   - Verify PostgreSQL is running: `sudo service postgresql start`
   - Check database exists: `psql -U postgres -d osm2 -c "\dt"`
   - Verify tables exist: `psql -U postgres -d osm2 -c "SELECT * FROM cap_tema LIMIT 1"`

2. **Web Server**
   - Start a web server in the project root
   - Example: `php -S localhost:8000` or use your existing web server

3. **Database Credentials**
   - File: `/php/db_postgres.php`
   - Default: host=localhost, db=osm2, user=postgres, pass=12345, port=5432

## Manual Testing Checklist

### 1. Page Load Test
- [ ] Navigate to `http://localhost:8000/m_capacitaciones/items_formularios.html`
- [ ] Verify page loads without JavaScript errors (check browser console)
- [ ] Verify all four tabs are visible: Tema, Proceso, Lugar, Tipo Actividad
- [ ] Verify CSS styling loads correctly (toggle switches, buttons, etc.)

### 2. Data Loading Tests

#### Tab: Tema
- [ ] Click on "Tema" tab
- [ ] Verify table loads with existing temas from database
- [ ] Check that ID, Nombre, and Opciones columns are displayed
- [ ] Verify count shows correct number: "Lista Temas (X)"
- [ ] Check that toggle switches display correctly
- [ ] Verify active items show green toggle, inactive show red toggle

#### Tab: Proceso
- [ ] Click on "Proceso" tab
- [ ] Verify table loads with existing procesos from database
- [ ] Check that data from 'proceso' column is displayed as 'Nombre'
- [ ] Verify count is accurate: "Lista Proceso (X)"
- [ ] Check toggle switches work visually

#### Tab: Lugar
- [ ] Click on "Lugar" tab
- [ ] Verify table loads with existing lugares from database
- [ ] Check that data from 'lugar' column is displayed as 'Nombre'
- [ ] Verify count is accurate: "Lista Lugar (X)"

#### Tab: Tipo Actividad
- [ ] Click on "Tipo Actividad" tab
- [ ] Verify table loads with existing tipos de actividad from database
- [ ] Check that data from 'nombre' column is displayed
- [ ] Verify count is accurate: "Lista Tipo Actividad (X)"

### 3. Add New Item Tests

#### Add Tema
- [ ] Go to Tema tab
- [ ] Enter text in "Nuevo tema" input field
- [ ] Click "Agregar tema" button
- [ ] Verify success toast message appears
- [ ] Verify new item appears in table with ID assigned
- [ ] Verify new item has active status (green toggle)
- [ ] Verify count increments by 1

#### Add Proceso
- [ ] Go to Proceso tab
- [ ] Enter text in "Nuevo proceso" input field
- [ ] Click "Agregar Proceso" button
- [ ] Verify success message and table updates

#### Add Lugar
- [ ] Go to Lugar tab
- [ ] Enter text in "Nuevo lugar" input field
- [ ] Click "Agregar Lugar" button
- [ ] Verify success message and table updates

#### Add Tipo Actividad
- [ ] Go to Tipo Actividad tab
- [ ] Enter text in "Nuevo tipo actividad" input field
- [ ] Click "Agregar Tipo actividad" button
- [ ] Verify success message and table updates

### 4. Edit Item Tests

- [ ] Select any item in any tab
- [ ] Click the edit button (pencil icon)
- [ ] Verify modal opens with current name pre-filled
- [ ] Modify the name
- [ ] Click "Guardar"
- [ ] Verify success message appears
- [ ] Verify table updates with new name
- [ ] Verify modal closes automatically

### 5. Toggle State Tests (Activate/Deactivate)

#### Deactivate Active Item
- [ ] Find an active item (green toggle)
- [ ] Click the toggle switch
- [ ] Confirm the action in the confirmation dialog
- [ ] Verify success message appears
- [ ] Verify toggle switches to red (inactive state)
- [ ] Verify row becomes semi-transparent (opacity 0.5)
- [ ] Verify item is still visible in table

#### Activate Inactive Item
- [ ] Find an inactive item (red toggle)
- [ ] Click the toggle switch
- [ ] Confirm the action
- [ ] Verify success message appears
- [ ] Verify toggle switches to green (active state)
- [ ] Verify row returns to normal opacity

### 6. Validation Tests

#### Empty Name Validation
- [ ] Try to add item with empty name
- [ ] Verify error toast appears: "Nombre vacío"
- [ ] Verify item is not added to database

#### Edit with Empty Name
- [ ] Open edit modal
- [ ] Clear the name field
- [ ] Click "Guardar"
- [ ] Verify error message: "Ingrese un nombre"

### 7. API Response Tests

Open browser DevTools > Network tab and verify:

#### List Endpoints
- [ ] `cap_control_api.php?action=list_temas` returns JSON with structure:
  ```json
  {
    "success": true,
    "temas": [
      {"id": "1", "nombre": "...", "activo": true}
    ]
  }
  ```

#### Add Endpoint
- [ ] POST to `items_formulario.php` with `{action: 'add', table: 'cap_tema', nombre: 'Test'}`
- [ ] Verify response: `{"success": true, "id": X, "nombre": "Test", "estado": 0}`

#### Update Endpoint
- [ ] POST to `items_formulario.php` with `{action: 'update', table: 'cap_tema', id: X, nombre: 'Updated'}`
- [ ] Verify response: `{"success": true, "updated": {...}}`

#### Toggle Endpoint
- [ ] POST to `items_formulario.php` with `{action: 'inactivar', table: 'cap_tema', id: X}`
- [ ] Verify response: `{"success": true, "id": X, "new_value": 1}`

### 8. Error Handling Tests

#### Database Connection Error
- [ ] Stop PostgreSQL service
- [ ] Try to load any tab
- [ ] Verify error toast appears: "Error al cargar..."
- [ ] Check browser console for error details

#### Invalid Action
- [ ] Manually call API with invalid action
- [ ] Verify error response: `{"success": false, "error": "..."}`

### 9. UI/UX Tests

- [ ] Verify all buttons have hover effects
- [ ] Verify toast messages auto-dismiss after a few seconds
- [ ] Verify modal can be closed with X button
- [ ] Verify modal can be closed with "Cancelar" button
- [ ] Verify confirmation dialog appears before changing state
- [ ] Check responsive behavior on mobile (resize browser)

### 10. Database Verification

After performing CRUD operations, verify in database:

```sql
-- Check estado values
SELECT id, nombre, estado FROM cap_tema ORDER BY id;
SELECT id, proceso, estado FROM cap_proceso ORDER BY id;
SELECT id, lugar, estado FROM cap_lugar ORDER BY id;
SELECT id, nombre, estado FROM cap_tipo_actividad ORDER BY id;

-- Verify estado constraint (should only allow 0 or 1)
UPDATE cap_tema SET estado = 2 WHERE id = 1; -- Should fail
```

## Common Issues and Solutions

### Issue: Tables not loading
**Solution**: 
- Check browser console for JavaScript errors
- Verify `cap_control_api.php` exists and is accessible
- Check database connection in `php/db_postgres.php`
- Verify estado column exists: `\d cap_tema` in psql

### Issue: Toggle not working
**Solution**:
- Verify estado column has CHECK constraint
- Check that API returns correct estado values (0 or 1)
- Verify JavaScript normalizeNewValue function works correctly

### Issue: CSS not loading
**Solution**:
- Check that `/m_capacitaciones/assets/css/items_formularios.css` exists
- Verify HTML includes CSS link in `<head>` section
- Check browser Network tab for 404 errors

### Issue: Cannot add items
**Solution**:
- Verify `items_formulario.php` has write permissions
- Check database user has INSERT privileges
- Look for PHP errors in web server logs

## Performance Tests

- [ ] Load page with 100+ items in each table
- [ ] Verify pagination or scrolling works smoothly
- [ ] Check that toggle operations complete within 1 second
- [ ] Verify no memory leaks after multiple operations

## Security Tests

- [ ] Verify SQL injection protection (try SQL in nombre field)
- [ ] Check XSS protection (try `<script>` tags in nombre)
- [ ] Verify authentication/authorization checks
- [ ] Test CSRF protection if implemented

## Browser Compatibility

Test on:
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)
- [ ] Mobile browsers (iOS Safari, Chrome Mobile)

## Success Criteria

All tests pass when:
1. All four tabs load data correctly from database
2. Items can be added successfully to all tables
3. Items can be edited successfully
4. Items can be activated/deactivated with toggle switches
5. UI provides clear feedback for all operations
6. No JavaScript errors in console
7. API responses are properly formatted
8. Database estado column works as expected (0=active, 1=inactive)
