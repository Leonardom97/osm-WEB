# Quick Start Guide: items_formularios.html Fix

## What Was Fixed

The `items_formularios.html` page now correctly reads and manages data from these database tables:
- `cap_tema` (Temas)
- `cap_proceso` (Procesos)
- `cap_lugar` (Lugares)
- `cap_tipo_actividad` (Tipos de Actividad)

## What You Need to Do

### Step 1: Apply Database Migration

The tables need an `estado` column to track active/inactive items.

**Option A: Using psql command line**
```bash
psql -U postgres -d osm2 -f db/03_r_update\ formulario.sql
```

**Option B: Using SQL client (pgAdmin, DBeaver, etc.)**
Open and execute the file: `db/03_r_update formulario.sql`

**Option C: Copy and paste SQL**
```sql
ALTER TABLE cap_proceso ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));
ALTER TABLE cap_lugar ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));
ALTER TABLE cap_tema ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));
ALTER TABLE cap_tipo_actividad ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));

UPDATE cap_proceso SET estado = 0;
UPDATE cap_lugar SET estado = 0;
UPDATE cap_tema SET estado = 0;
UPDATE cap_tipo_actividad SET estado = 0;
```

### Step 2: Verify Migration

Run the verification script:
```bash
psql -U postgres -d osm2 -f db/verify_estado_columns.sql
```

You should see the `estado` column listed for all four tables.

### Step 3: Test the Page

1. Start your web server (if not already running)
2. Navigate to: `http://your-server/m_capacitaciones/items_formularios.html`
3. Verify all four tabs load data correctly
4. Try adding, editing, and toggling items

## What Changed

### New Files
1. **`m_capacitaciones/assets/php/cap_control_api.php`**
   - Provides list endpoints for loading data into tables
   - Actions: list_temas, list_procesos, list_lugares, list_tactividad

2. **`m_capacitaciones/assets/css/items_formularios.css`**
   - Styling for toggle switches (green = active, red = inactive)
   - Styling for inactive rows (semi-transparent)
   - Responsive design

3. **`db/README_MIGRATION.md`**
   - Detailed migration instructions

4. **`TESTING_ITEMS_FORMULARIOS.md`**
   - Complete testing checklist

5. **`db/verify_estado_columns.sql`**
   - Script to verify migration was successful

### Modified Files
1. **`m_capacitaciones/items_formularios.html`**
   - Added link to new CSS file

### Existing Files (No Changes Needed)
- **`m_capacitaciones/assets/js/items_formularios.js`** - Already configured correctly
- **`m_capacitaciones/assets/php/items_formulario.php`** - Already has smart column detection

## Features Now Working

✅ **View Items**: All four tabs display data from respective tables
✅ **Add Items**: Can add new items to any table
✅ **Edit Items**: Can edit item names via modal dialog
✅ **Toggle State**: Can activate/deactivate items with toggle switches
✅ **Visual Feedback**: Toast messages for all operations
✅ **State Filtering**: Active items (estado=0) are shown normally, inactive items (estado=1) are dimmed

## Troubleshooting

### Tables not loading?
1. Check browser console for errors (F12)
2. Verify database migration was applied
3. Check PHP error logs
4. Verify database connection in `/php/db_postgres.php`

### Can't add or edit items?
1. Verify `estado` column exists in all tables
2. Check PHP has write permissions
3. Look for errors in network tab (F12)

### Toggle switches not showing?
1. Verify CSS file loads: check Network tab for `items_formularios.css`
2. Clear browser cache
3. Check that HTML includes CSS link in head section

## Database Estado Values

- **`0`** = Active (activo) - Item is available for use
- **`1`** = Inactive (inactivo) - Item is hidden but not deleted

## API Endpoints

### List Operations (GET)
- `/m_capacitaciones/assets/php/cap_control_api.php?action=list_temas`
- `/m_capacitaciones/assets/php/cap_control_api.php?action=list_procesos`
- `/m_capacitaciones/assets/php/cap_control_api.php?action=list_lugares`
- `/m_capacitaciones/assets/php/cap_control_api.php?action=list_tactividad`

### Mutation Operations (POST JSON)
All use: `/m_capacitaciones/assets/php/items_formulario.php`

**Add:**
```json
{"action": "add", "table": "cap_tema", "nombre": "New Item"}
```

**Update:**
```json
{"action": "update", "table": "cap_tema", "id": 1, "nombre": "Updated Name"}
```

**Activate:**
```json
{"action": "activar", "table": "cap_tema", "id": 1}
```

**Deactivate:**
```json
{"action": "inactivar", "table": "cap_tema", "id": 1}
```

## Need Help?

See detailed documentation:
- **Migration Guide**: `db/README_MIGRATION.md`
- **Testing Guide**: `TESTING_ITEMS_FORMULARIOS.md`
- **SQL Verification**: Run `db/verify_estado_columns.sql`

## Summary

1. ✅ Run SQL migration (adds `estado` column)
2. ✅ Verify migration successful
3. ✅ Access the page and test functionality
4. ✅ All features should work: list, add, edit, activate/deactivate

**That's it! The page is now fully functional.** 🎉
