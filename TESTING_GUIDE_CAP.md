# Manual Testing Guide - Training Module Implementation

This guide provides step-by-step manual testing procedures to verify the implementation of the training programming module with id_colaborador mapping.

## Prerequisites

- Access to staging database
- PostgreSQL client (psql)
- Web browser with developer tools
- Test user account with appropriate permissions

## Pre-Testing Setup

### 1. Database Backup
```bash
pg_dump -U postgres -d osm_staging > backup_before_testing_$(date +%Y%m%d_%H%M%S).sql
```

### 2. Apply Migration
```bash
psql -U postgres -d osm_staging -f db/migration_cap_id_colaborador.sql
```

**Expected Output:**
- Notice messages showing mapping statistics
- List of unmapped cedulas (if any)
- Migration summary with percentages

### 3. Verify Migration Success
```bash
psql -U postgres -d osm_staging -f db/report_unmapped_cedulas.sql
```

**Review:**
- Percentage of mapped records should be >95%
- Note any unmapped cedulas for manual correction

## Test Suite

### Test 1: Database Schema Verification

**Objective**: Verify that all database changes were applied correctly.

**Steps**:
```sql
-- Check that id_colaborador column exists in cap_formulario_asistente
\d cap_formulario_asistente

-- Expected: Should see id_colaborador column of type integer

-- Check that cedula column exists in cap_notificaciones
\d cap_notificaciones

-- Expected: Should see cedula column of type varchar(255)

-- Verify indexes were created
\di idx_cfa_id_colaborador
\di idx_notif_id_colaborador
\di idx_notif_fecha_proxima
\di idx_notif_estado
\di idx_cfa_cedula

-- Expected: All indexes should exist
```

**Acceptance Criteria**:
- ✅ id_colaborador column exists in cap_formulario_asistente
- ✅ cedula column exists in cap_notificaciones
- ✅ All 5 indexes are created

### Test 2: Data Mapping Verification

**Objective**: Verify that existing records were correctly mapped.

**Steps**:
```sql
-- Check mapping statistics
SELECT 
    COUNT(*) as total,
    COUNT(id_colaborador) as mapped,
    COUNT(*) - COUNT(id_colaborador) as unmapped,
    ROUND(COUNT(id_colaborador)::NUMERIC / COUNT(*) * 100, 2) as pct_mapped
FROM cap_formulario_asistente;

-- Verify sample mappings are correct
SELECT 
    a.cedula,
    a.id_colaborador,
    c.ac_cedula,
    c.ac_nombre1 || ' ' || c.ac_apellido1 as colaborador_nombre,
    a.nombre as asistente_nombre
FROM cap_formulario_asistente a
LEFT JOIN adm_colaboradores c ON a.id_colaborador = c.ac_id
LIMIT 10;
```

**Acceptance Criteria**:
- ✅ Mapping percentage > 99% (AC2)
- ✅ Mapped records have matching cedulas
- ✅ colaborador_nombre matches asistente_nombre

### Test 3: Programacion Save - Create New

**Objective**: Test AC1 - programacion_save creates and triggers recalculation.

**Steps**:

1. Open browser and navigate to: `/m_capacitaciones/programacion.html`

2. Click "Nueva Programación"

3. Fill form:
   - **Cargo**: Select any cargo (e.g., "POLINIZADOR")
   - **Sub Área**: Select "POLINIZACION"
   - **Tema**: Select any tema (e.g., "Seguridad Industrial")
   - **Frecuencia**: 12
   - **Rol Capacitador**: "Capacitador SIE"

4. Click "Guardar"

5. Verify in database:
```sql
-- Check that record was created
SELECT * FROM cap_programacion 
ORDER BY id DESC LIMIT 1;

-- Check that notifications were updated
SELECT COUNT(*) FROM cap_notificaciones
WHERE id_programacion = (SELECT MAX(id) FROM cap_programacion);
```

**Acceptance Criteria**:
- ✅ New record appears in cap_programacion
- ✅ Success message displayed
- ✅ Notifications were created/updated for affected collaborators
- ✅ Table refreshes with new programming

**Log Check**:
```bash
# Check PHP error log for recalculation call
tail -f /var/log/php/error.log | grep "actualizar_notificaciones"
```

### Test 4: Programacion Save - Update Existing

**Objective**: Test AC1 - programacion update triggers recalculation.

**Steps**:

1. In programacion.html, click "Edit" on an existing programming

2. Change **Frecuencia** from 12 to 6 months

3. Click "Guardar"

4. Verify recalculation occurred:
```sql
-- Check that notifications were updated
SELECT 
    c.ac_cedula,
    c.ac_nombre1 || ' ' || c.ac_apellido1 as nombre,
    n.fecha_proxima,
    n.dias_para_vencimiento,
    n.estado
FROM cap_notificaciones n
JOIN adm_colaboradores c ON n.id_colaborador = c.ac_id
WHERE n.id_programacion = [ID_OF_EDITED_PROGRAMMING]
ORDER BY n.fecha_proxima
LIMIT 10;
```

**Acceptance Criteria**:
- ✅ Programming updated in database
- ✅ fecha_proxima recalculated with new frequency
- ✅ dias_para_vencimiento updated
- ✅ estados updated according to new dates

### Test 5: Formulario Save - New Attendees

**Objective**: Test AC2 - formulario_save populates id_colaborador.

**Steps**:

1. Navigate to `/m_capacitaciones/formulario.html`

2. Fill form with basic info:
   - **Proceso**: Select any
   - **Lugar**: Select any
   - **Responsable**: Use valid cedula
   - **Tipo**: Select any
   - **Tema**: Select any
   - **Fecha**: Today's date
   - **Hora inicio/final**: Valid times

3. Add attendees with **valid cedulas** from adm_colaboradores:
   ```sql
   -- Get some test cedulas
   SELECT ac_cedula, ac_nombre1 || ' ' || ac_apellido1 as nombre
   FROM adm_colaboradores 
   WHERE ac_id_situación = 'A'
   LIMIT 5;
   ```

4. Add 1 attendee with **invalid cedula** (e.g., "99999999")

5. Click "Guardar"

6. Verify in database:
```sql
-- Check last form
SELECT id FROM cap_formulario ORDER BY id DESC LIMIT 1;

-- Check attendees were saved with id_colaborador
SELECT 
    a.cedula,
    a.id_colaborador,
    a.nombre,
    c.ac_cedula,
    c.ac_nombre1 || ' ' || c.ac_apellido1 as colaborador_nombre
FROM cap_formulario_asistente a
LEFT JOIN adm_colaboradores c ON a.id_colaborador = c.ac_id
WHERE a.id_formulario = [LAST_FORM_ID]
ORDER BY a.id;
```

**Acceptance Criteria**:
- ✅ Form saved successfully
- ✅ Valid cedulas mapped to id_colaborador (AC2)
- ✅ Invalid cedula saved with id_colaborador = NULL
- ✅ Response includes audit information:
  - `asistentes_mapeados`: 5
  - `asistentes_total`: 6
  - `asistentes_sin_mapear`: [{"cedula": "99999999", "nombre": "..."}]
  - `warning`: Present

**Log Check**:
```bash
# Check for warning about unmapped cedula
tail -n 50 /var/log/php/error.log | grep "Cedula not found"
# Expected: Warning: Cedula not found in adm_colaboradores: 99999999
```

### Test 6: Notification Update After Form Save

**Objective**: Test AC3 - cap_notificaciones updates correctly.

**Steps**:

1. After Test 5, check notifications for affected collaborators:
```sql
-- Get colaborador IDs from the form
SELECT DISTINCT id_colaborador 
FROM cap_formulario_asistente 
WHERE id_formulario = [LAST_FORM_ID]
  AND id_colaborador IS NOT NULL;

-- Check their notifications
SELECT 
    c.ac_cedula,
    c.ac_nombre1 || ' ' || c.ac_apellido1 as nombre,
    t.nombre as tema,
    n.fecha_ultima_capacitacion,
    n.fecha_proxima,
    n.dias_para_vencimiento,
    n.estado
FROM cap_notificaciones n
JOIN adm_colaboradores c ON n.id_colaborador = c.ac_id
JOIN cap_programacion p ON n.id_programacion = p.id
JOIN cap_tema t ON p.id_tema = t.id
WHERE n.id_colaborador IN (
    SELECT DISTINCT id_colaborador 
    FROM cap_formulario_asistente 
    WHERE id_formulario = [LAST_FORM_ID]
      AND id_colaborador IS NOT NULL
)
ORDER BY n.fecha_proxima;
```

**Acceptance Criteria**:
- ✅ fecha_ultima_capacitacion updated to form date
- ✅ fecha_proxima = fecha_ultima + frecuencia_meses
- ✅ dias_para_vencimiento calculated correctly
- ✅ estado reflects correct state:
  - 'pendiente' if fecha_ultima is NULL
  - 'vencida' if fecha_proxima < current_date
  - 'proximo_vencer' if fecha_proxima <= current_date + 30 days
  - 'vigente' otherwise

### Test 7: Recalculation Function Manual Test

**Objective**: Test function can be called manually and updates states.

**Steps**:

1. Execute function:
```sql
SELECT actualizar_notificaciones_capacitacion();
```

2. Verify notifications updated:
```sql
-- Check that states are correct
SELECT 
    estado,
    COUNT(*) as count
FROM cap_notificaciones
GROUP BY estado
ORDER BY estado;

-- Check sample records
SELECT 
    c.ac_cedula,
    n.fecha_proxima,
    n.dias_para_vencimiento,
    n.estado,
    CASE 
        WHEN n.fecha_ultima_capacitacion IS NULL THEN 'pendiente'
        WHEN n.fecha_proxima < CURRENT_DATE THEN 'vencida'
        WHEN n.fecha_proxima <= CURRENT_DATE + INTERVAL '30 days' THEN 'proximo_vencer'
        ELSE 'vigente'
    END as expected_estado
FROM cap_notificaciones n
JOIN adm_colaboradores c ON n.id_colaborador = c.ac_id
LIMIT 20;
```

**Acceptance Criteria**:
- ✅ Function executes without errors
- ✅ estado matches expected_estado for all records
- ✅ 30-day threshold correctly applied

### Test 8: Excel Import

**Objective**: Test AC5 - Excel import works without duplicates.

**Steps**:

1. Create test Excel file with:
   - Column A: Valid cargo ID (e.g., 116)
   - Column B: Sub area (e.g., "CLIPA - SISTEMAS")
   - Column C: Valid tema ID (e.g., 75)
   - Column D: Frequency (e.g., 12)
   - Column E: Role name (e.g., "Capacitador SIE")

2. In programacion.html, click "Importar Excel"

3. Select the file

4. Review preview

5. Click "Importar"

6. Verify no duplicates:
```sql
-- Check for duplicates
SELECT id_cargo, sub_area, id_tema, COUNT(*) as count
FROM cap_programacion
WHERE activo = true
GROUP BY id_cargo, sub_area, id_tema
HAVING COUNT(*) > 1;
```

**Acceptance Criteria**:
- ✅ Records imported successfully
- ✅ No duplicates created (AC5)
- ✅ Recalculation triggered
- ✅ Success message with count

### Test 9: Cedula Column Persistence

**Objective**: Test AC6 - cedula column never deleted.

**Steps**:

1. Verify cedula column exists and has data:
```sql
-- Check column exists
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'cap_formulario_asistente' 
  AND column_name = 'cedula';

-- Check it has data
SELECT COUNT(*) 
FROM cap_formulario_asistente 
WHERE cedula IS NOT NULL AND cedula != '';

-- Check cap_notificaciones also has cedula
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'cap_notificaciones' 
  AND column_name = 'cedula';

SELECT COUNT(*) 
FROM cap_notificaciones 
WHERE cedula IS NOT NULL AND cedula != '';
```

**Acceptance Criteria**:
- ✅ cedula column exists in cap_formulario_asistente (AC6)
- ✅ cedula column has data
- ✅ cedula column exists in cap_notificaciones
- ✅ No drop column statements in migration
- ✅ Comments in code emphasize cedula is for audit

### Test 10: Cron Job Simulation

**Objective**: Test AC4 - Daily cron updates work.

**Steps**:

1. Manually run the cron command:
```bash
psql -U postgres -d osm_staging -c "SELECT actualizar_notificaciones_capacitacion();" >> /tmp/test_cron.log 2>&1
```

2. Check log:
```bash
cat /tmp/test_cron.log
```

3. Verify notifications updated:
```sql
-- Check that fecha_actualizacion was updated
SELECT 
    COUNT(*),
    MAX(fecha_actualizacion) as last_update
FROM cap_notificaciones;
```

**Acceptance Criteria**:
- ✅ Command executes without errors
- ✅ Log file created
- ✅ fecha_actualizacion updated
- ✅ States recalculated correctly

## Performance Testing

### Test 11: Query Performance

**Objective**: Verify indexes improve performance.

**Steps**:

```sql
-- Test 1: Lookup by id_colaborador (should use index)
EXPLAIN ANALYZE
SELECT * FROM cap_formulario_asistente 
WHERE id_colaborador = 123;

-- Expected: Index Scan using idx_cfa_id_colaborador

-- Test 2: Filter notifications by estado (should use index)
EXPLAIN ANALYZE
SELECT * FROM cap_notificaciones 
WHERE estado = 'proximo_vencer';

-- Expected: Index Scan using idx_notif_estado

-- Test 3: Filter by fecha_proxima (should use index)
EXPLAIN ANALYZE
SELECT * FROM cap_notificaciones 
WHERE fecha_proxima <= CURRENT_DATE + INTERVAL '7 days';

-- Expected: Index Scan using idx_notif_fecha_proxima
```

**Acceptance Criteria**:
- ✅ Queries use indexes (not Seq Scan)
- ✅ Execution time < 50ms for typical queries
- ✅ actualizar_notificaciones_capacitacion() completes in < 10 seconds

## Regression Testing

### Test 12: Existing Functionality

**Objective**: Verify that existing features still work.

**Steps**:

1. **View training list**: Navigate to consultas and verify list loads
2. **View progress**: Check user profile shows progress correctly
3. **View notifications**: Check notification bell shows alerts
4. **Edit form**: Edit existing training form
5. **Delete programming**: Soft delete a programming (activo = false)

**Acceptance Criteria**:
- ✅ All existing features work as before
- ✅ No errors in browser console
- ✅ No PHP errors in log

## Test Results Summary

| Test # | Test Name | Status | Notes |
|--------|-----------|--------|-------|
| 1 | Schema Verification | ⏳ | |
| 2 | Data Mapping | ⏳ | |
| 3 | Create Programming | ⏳ | |
| 4 | Update Programming | ⏳ | |
| 5 | Save Form with Attendees | ⏳ | |
| 6 | Notification Update | ⏳ | |
| 7 | Manual Recalculation | ⏳ | |
| 8 | Excel Import | ⏳ | |
| 9 | Cedula Persistence | ⏳ | |
| 10 | Cron Simulation | ⏳ | |
| 11 | Performance | ⏳ | |
| 12 | Regression | ⏳ | |

Legend: ⏳ Pending | ✅ Pass | ❌ Fail

## Issue Reporting

If any test fails, report with:
- Test number and name
- Exact steps to reproduce
- Expected vs actual result
- Error messages from:
  - Browser console
  - PHP error log
  - PostgreSQL log
  - SQL query output

## Rollback Procedure

If critical issues found:

```sql
-- Restore from backup
psql -U postgres -d osm_staging < backup_before_testing_[timestamp].sql
```

Or use the rollback script in `migration_cap_id_colaborador.sql` (at the end of file).
