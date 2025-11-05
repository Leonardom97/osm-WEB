# Database Migration Instructions

## Overview
This document describes the database migrations needed for the items_formularios functionality.

## Required Migration

### Adding Estado Column to Capacity Tables

The `items_formularios.html` page requires an `estado` column in the following tables to manage active/inactive states:
- `cap_tema`
- `cap_proceso`
- `cap_lugar`
- `cap_tipo_actividad`

### Migration File
The migration is located at: `/db/03_r_update formulario.sql`

### To Apply the Migration

Connect to your PostgreSQL database and run:

```bash
psql -U postgres -d osm2 -f db/03_r_update\ formulario.sql
```

Or connect to the database and execute the SQL directly:

```sql
-- Agregar columna estado
ALTER TABLE cap_proceso
ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));

ALTER TABLE cap_lugar
ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));

ALTER TABLE cap_tema
ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));

ALTER TABLE cap_tipo_actividad
ADD COLUMN estado SMALLINT NOT NULL DEFAULT 0 CHECK (estado IN (0,1));

-- Actualizar registros existentes a 0 (activos)
UPDATE cap_proceso SET estado = 0;
UPDATE cap_lugar SET estado = 0;
UPDATE cap_tema SET estado = 0;
UPDATE cap_tipo_actividad SET estado = 0;
```

### Estado Column Values
- `0` = Active (activo) - Record is available for use
- `1` = Inactive (inactivo) - Record is hidden from use but not deleted

### Verification

After applying the migration, verify the columns exist:

```sql
-- Check cap_tema
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'cap_tema' AND column_name = 'estado';

-- Check cap_proceso
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'cap_proceso' AND column_name = 'estado';

-- Check cap_lugar
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'cap_lugar' AND column_name = 'estado';

-- Check cap_tipo_actividad
SELECT column_name, data_type, column_default 
FROM information_schema.columns 
WHERE table_name = 'cap_tipo_actividad' AND column_name = 'estado';
```

### Testing

After migration, test the items_formularios page functionality:
1. Navigate to `/m_capacitaciones/items_formularios.html`
2. Verify all four tabs load data:
   - Tema
   - Proceso
   - Lugar
   - Tipo Actividad
3. Test adding new items
4. Test editing existing items
5. Test activating/deactivating items (toggle switch)

## Related Files

- **Frontend**: `/m_capacitaciones/items_formularios.html`
- **JavaScript**: `/m_capacitaciones/assets/js/items_formularios.js`
- **API Endpoints**:
  - `/m_capacitaciones/assets/php/cap_control_api.php` (list operations)
  - `/m_capacitaciones/assets/php/items_formulario.php` (add/update/activate/deactivate)
- **CSS**: `/m_capacitaciones/assets/css/items_formularios.css`

## API Usage

### List Endpoints (cap_control_api.php)
- `GET /m_capacitaciones/assets/php/cap_control_api.php?action=list_temas`
- `GET /m_capacitaciones/assets/php/cap_control_api.php?action=list_procesos`
- `GET /m_capacitaciones/assets/php/cap_control_api.php?action=list_lugares`
- `GET /m_capacitaciones/assets/php/cap_control_api.php?action=list_tactividad`

### Mutation Endpoints (items_formulario.php)
All use POST with JSON body:
- Add: `{action: 'add', table: 'cap_tema', nombre: 'New Name'}`
- Update: `{action: 'update', table: 'cap_tema', id: 1, nombre: 'Updated Name'}`
- Activate: `{action: 'activar', table: 'cap_tema', id: 1}`
- Deactivate: `{action: 'inactivar', table: 'cap_tema', id: 1}`
