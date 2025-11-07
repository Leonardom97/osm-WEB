# Before/After Comparison - Consultas por Persona Fix

## Overview
This document shows the specific changes made to fix the Error 500 in `consultas_por_persona_api.php`.

## Column Name Fixes

### ❌ BEFORE (Incorrect)
```sql
SELECT
  ac.id,                    -- WRONG: column doesn't exist
  ac.cedula,                -- WRONG: column doesn't exist
  ac.nombre1,               -- WRONG: column doesn't exist
  ac.nombre2,               -- WRONG: column doesn't exist
  ac.apellido1,             -- WRONG: column doesn't exist
  ac.apellido2,             -- WRONG: column doesn't exist
  ac.situacion,             -- WRONG: column doesn't exist
  c.cargo,
  ar.sub_area
FROM adm_colaboradores ac
```

### ✅ AFTER (Correct)
```sql
SELECT
  ac.ac_id as id,           -- CORRECT: uses ac_ prefix
  ac.ac_cedula as cedula,   -- CORRECT: uses ac_ prefix
  TRIM(ac.ac_nombre1 || ' ' || COALESCE(ac.ac_nombre2 || ' ','') || 
       ac.ac_apellido1 || ' ' || COALESCE(ac.ac_apellido2,'')) AS nombres_apellidos,
  c.cargo,
  ar.sub_area
FROM adm_colaboradores ac
```

## Table Name Fixes

### ❌ BEFORE (Incorrect)
```sql
LEFT JOIN adm_cargo c ON ac.id_cargo = c.id          -- WRONG: table doesn't exist
LEFT JOIN adm_area ar ON ac.sub_area = ar.id_area    -- WRONG: table doesn't exist
```

### ✅ AFTER (Correct)
```sql
LEFT JOIN adm_cargos c ON ac.ac_id_cargo = c.id_cargo     -- CORRECT: adm_cargos
LEFT JOIN adm_área ar ON ac.ac_sub_area = ar.id_area      -- CORRECT: adm_área
```

## Join Condition Fixes

### ❌ BEFORE (Incorrect)
```sql
FROM adm_colaboradores ac
LEFT JOIN cap_programacion cp ON ac.id_cargo = cp.id_cargo      -- WRONG: column name
    AND (cp.id_sub_area = ac.sub_area OR cp.id_sub_area IS NULL)  -- WRONG: both columns
```

### ✅ AFTER (Correct)
```sql
FROM adm_colaboradores ac
LEFT JOIN cap_programacion cp ON ac.ac_id_cargo = cp.id_cargo   -- CORRECT: ac_id_cargo
    AND (cp.sub_area = ac.ac_sub_area OR cp.sub_area IS NULL)    -- CORRECT: both fixed
```

## Status Filter Fixes

### ❌ BEFORE (Incorrect)
```sql
WHERE ac.situacion = 'A'     -- WRONG: column doesn't exist, only checks Active
```

### ✅ AFTER (Correct)
```sql
WHERE ac.ac_id_situación IN ('A', 'V', 'P')   -- CORRECT: checks Active, Vacation, Permission
```

## Capacitaciones Programadas CTE

### ❌ BEFORE (Incorrect)
```sql
capacitaciones_programadas AS (
  SELECT 
    ac.cedula,                              -- WRONG: column name
    COUNT(DISTINCT cp.id) as total_programadas
  FROM adm_colaboradores ac
  LEFT JOIN cap_programacion cp ON ac.id_cargo = cp.id_cargo    -- WRONG
    AND (cp.id_sub_area = ac.sub_area OR cp.id_sub_area IS NULL) -- WRONG
  WHERE ac.situacion = 'A'                  -- WRONG: column name
  GROUP BY ac.cedula                        -- WRONG: column name
)
```

### ✅ AFTER (Correct)
```sql
capacitaciones_programadas AS (
  SELECT 
    ac.ac_cedula as cedula,                 -- CORRECT
    COUNT(DISTINCT cp.id) as total_programadas
  FROM adm_colaboradores ac
  LEFT JOIN cap_programacion cp ON ac.ac_id_cargo = cp.id_cargo -- CORRECT
    AND (cp.sub_area = ac.ac_sub_area OR cp.sub_area IS NULL)   -- CORRECT
  WHERE ac.ac_id_situación IN ('A', 'V', 'P')  -- CORRECT
    AND cp.activo = true                       -- NEW: filter active only
  GROUP BY ac.ac_cedula                        -- CORRECT
)
```

## Capacitaciones Pendientes - New Logic

### ❌ BEFORE
```sql
-- No separate logic for pending trainings
-- Used total_programadas as capacitaciones_pendientes
```

### ✅ AFTER (New CTE Added)
```sql
capacitaciones_pendientes AS (
  -- Calculate pending trainings: programmed but not yet completed or not meeting frequency
  SELECT 
    ac.ac_cedula as cedula,
    COUNT(DISTINCT cp.id) as total_pendientes
  FROM adm_colaboradores ac
  INNER JOIN cap_programacion cp ON ac.ac_id_cargo = cp.id_cargo 
    AND (cp.sub_area = ac.ac_sub_area OR cp.sub_area IS NULL)
  LEFT JOIN cap_formulario_asistente fa ON fa.cedula = ac.ac_cedula
    AND EXISTS (
      SELECT 1 FROM cap_formulario cf
      WHERE cf.id = fa.id_formulario
        AND cf.id_tema = cp.id_tema
        AND cf.fecha >= CURRENT_DATE - (COALESCE(cp.frecuencia_meses, 12) || ' months')::INTERVAL
    )
  WHERE ac.ac_id_situación IN ('A', 'V', 'P')
    AND cp.activo = true
    AND fa.id IS NULL  -- Only count trainings NOT yet completed
  GROUP BY ac.ac_cedula
)
```

## Final SELECT Logic

### ❌ BEFORE (Incorrect)
```sql
SELECT
  ...
  COALESCE(cr.total_realizadas, 0) as capacitaciones_realizadas,
  COALESCE(cp.total_programadas, 0) as capacitaciones_pendientes,  -- WRONG logic
  COALESCE(cr.total_realizadas, 0) + COALESCE(cp.total_programadas, 0) as total_esperadas
FROM adm_colaboradores ac
LEFT JOIN capacitaciones_realizadas cr ON ac.cedula = cr.cedula    -- WRONG column
LEFT JOIN capacitaciones_programadas cp ON ac.cedula = cp.cedula   -- WRONG column
WHERE ac.situacion = 'A'                                           -- WRONG
```

### ✅ AFTER (Correct)
```sql
SELECT
  ...
  COALESCE(cr.total_realizadas, 0) as capacitaciones_realizadas,
  COALESCE(cpe.total_pendientes, 0) as capacitaciones_pendientes,  -- NEW CTE
  COALESCE(cp.total_programadas, 0) as total_esperadas
FROM adm_colaboradores ac
LEFT JOIN capacitaciones_realizadas cr ON ac.ac_cedula = cr.cedula    -- CORRECT
LEFT JOIN capacitaciones_programadas cp ON ac.ac_cedula = cp.cedula   -- CORRECT
LEFT JOIN capacitaciones_pendientes cpe ON ac.ac_cedula = cpe.cedula  -- NEW JOIN
WHERE ac.ac_id_situación IN ('A', 'V', 'P')                          -- CORRECT
```

## Frequency Check Fix

### ❌ BEFORE (Potential NULL Error)
```sql
AND cf.fecha >= CURRENT_DATE - (cp.frecuencia_meses || ' months')::INTERVAL
-- Would fail if frecuencia_meses is NULL
```

### ✅ AFTER (NULL-Safe)
```sql
AND cf.fecha >= CURRENT_DATE - (COALESCE(cp.frecuencia_meses, 12) || ' months')::INTERVAL
-- Defaults to 12 months if NULL
```

## Summary of Changes

| Issue | Before | After | Status |
|-------|--------|-------|--------|
| Column names | Missing `ac_` prefix | All columns use `ac_` prefix | ✅ Fixed |
| Table names | `adm_cargo`, `adm_area` | `adm_cargos`, `adm_área` | ✅ Fixed |
| Status filter | Only 'A' | 'A', 'V', 'P' | ✅ Fixed |
| Active filter | Not checked | `cp.activo = true` | ✅ Added |
| NULL safety | No COALESCE | COALESCE with default | ✅ Fixed |
| Pendientes logic | Used programadas count | Separate CTE with frequency check | ✅ Improved |

## Expected Behavior Changes

### Before Fix
- ❌ Returns Error 500
- ❌ No data displayed
- ❌ JavaScript console shows API error

### After Fix
- ✅ Returns valid JSON data
- ✅ Table displays correctly
- ✅ Shows employees with status A, V, or P
- ✅ Capacitaciones realizadas shows actual completed trainings
- ✅ Capacitaciones pendientes shows trainings due but not completed
- ✅ Total esperadas shows all programmed trainings for each employee
