# Testing Guide for Proceso-Tema Relationship Feature

## Prerequisites
1. PostgreSQL database must be running with `osm2` database
2. Run the migration file: `db/09_create_cap_proceso_tema.sql`
3. Ensure web server (Apache/Nginx with PHP) is configured

## Testing Steps

### 1. Database Migration
```sql
-- Connect to the database and run:
psql -U postgres -d osm2 -f db/09_create_cap_proceso_tema.sql
```

Verify the table was created:
```sql
SELECT * FROM cap_proceso_tema;
```

Expected: Should see 10 records (9 for Administrativo, 1 for Compras y almacén)

### 2. Test Backend API
Use a tool like Postman or curl to test the API endpoints:

#### List all relationships
```bash
curl "http://localhost/m_capacitaciones/assets/php/proceso_tema_api.php?action=list"
```
Expected: JSON response with success=true and array of relations

#### Get temas by proceso
```bash
curl "http://localhost/m_capacitaciones/assets/php/proceso_tema_api.php?action=get_temas_by_proceso&id_proceso=5"
```
Expected: JSON response with temas for Administrativo process

#### Add new relationship
```bash
curl -X POST "http://localhost/m_capacitaciones/assets/php/proceso_tema_api.php" \
  -H "Content-Type: application/json" \
  -d '{"action":"add","id_proceso":1,"id_tema":1}'
```
Expected: JSON response with success=true

### 3. Test Frontend UI

#### Test items_formularios.html
1. Navigate to: `http://localhost/m_capacitaciones/items_formularios.html`
2. Click on "Relación Proceso Tema" tab
3. Verify dropdowns are populated with procesos and temas
4. Select a proceso and tema, click "Agregar Relación"
5. Verify the relationship appears in the table below
6. Test toggle active/inactive button
7. Test delete button

#### Test formulario.html - Theme Filtering
1. Navigate to: `http://localhost/m_capacitaciones/formulario.html`
2. In the "Proceso" dropdown, select "Administrativo"
3. Verify that the "Tema" dropdown only shows the following themes:
   - Socialización de procedimiento PQRS
   - Excel
   - Análisis e datos
   - Diseño Web
   - Herramientas de Google
   - Herramientas ofimáticas
   - Mantenimiento de cámaras
   - Power Bi
   - SAP

4. Change proceso to "Compras y almacén"
5. Verify that the "Tema" dropdown only shows:
   - Rotación de inventario

6. Clear the proceso selection (select empty option)
7. Verify that the "Tema" dropdown shows all available themes

## Expected Behavior Summary

### items_formularios.html - Relación Proceso Tema Tab
- Displays a table with all proceso-tema relationships
- Shows proceso name and tema name for each relationship
- Shows active/inactive status
- Allows adding new relationships via dropdowns
- Prevents duplicate relationships
- Allows toggling active status
- Allows deleting relationships

### formulario.html - Filtered Theme Selection
- When no proceso is selected: all themes are available
- When a proceso is selected: only themes associated with that proceso are available
- If a proceso has no associated themes: displays "No hay temas para este proceso"
- Dropdown updates dynamically when proceso changes

## Troubleshooting

### Issue: "Database not available" error
- Check database connection settings in `/php/config.php`
- Verify PostgreSQL is running and accessible

### Issue: Themes not filtering in formulario.html
- Check browser console for JavaScript errors
- Verify proceso_tema_api.php is accessible
- Check that relationships exist in cap_proceso_tema table

### Issue: Empty dropdowns in items_formularios.html
- Verify cap_proceso and cap_tema tables have data
- Check browser console for API errors
- Verify proceso_tema_api.php is returning proper JSON

## Security Checks
- ✓ All SQL queries use prepared statements (no SQL injection)
- ✓ All user input is validated (numeric checks for IDs)
- ✓ HTML output is escaped using escapeHtml function (no XSS)
- ✓ Security headers are applied via security_headers.php
- ✓ Foreign key constraints prevent orphaned records

## Files Modified/Created
- `db/09_create_cap_proceso_tema.sql` - Database migration
- `m_capacitaciones/assets/php/proceso_tema_api.php` - Backend API
- `m_capacitaciones/items_formularios.html` - Added new tab
- `m_capacitaciones/assets/js/items_formularios.js` - Added relationship management logic
- `m_capacitaciones/assets/js/formulario.js` - Added theme filtering logic
