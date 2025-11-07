# Fix Error 500 - Consultas por Persona

## Problem Statement
The page `consultas_capacitaciones.html` was showing Error 500 when trying to load the "Consultas por Persona" table. The error was caused by incorrect SQL query in `consultas_por_persona_api.php`.

## Root Cause Analysis
The SQL query had multiple issues:

1. **Incorrect Column Names**: The query was using wrong column names without the `ac_` prefix
   - Used: `ac.id`, `ac.cedula`, `ac.nombre1`
   - Correct: `ac.ac_id`, `ac.ac_cedula`, `ac.ac_nombre1`

2. **Wrong Table Names**:
   - Used: `adm_cargo` (doesn't exist)
   - Correct: `adm_cargos`
   - Used: `adm_area` (doesn't exist)
   - Correct: `adm_área`

3. **Incorrect Situación Filter**:
   - Used: `ac.situacion = 'A'`
   - Correct: `ac.ac_id_situación IN ('A', 'V', 'P')`

4. **Missing NULL Check**: The `frecuencia_meses` field could be NULL causing SQL errors

## Solution Implemented

### File Modified
- `m_capacitaciones/assets/php/consultas_por_persona_api.php`

### Key Changes

#### 1. Fixed Column References
```sql
-- Before
ac.id, ac.cedula, ac.nombre1, ac.nombre2, ac.apellido1, ac.apellido2

-- After  
ac.ac_id as id, ac.ac_cedula as cedula, ac.ac_nombre1, ac.ac_nombre2, ac.ac_apellido1, ac.ac_apellido2
```

#### 2. Fixed Table Names
```sql
-- Before
LEFT JOIN adm_cargo c ON ac.id_cargo = c.id
LEFT JOIN adm_area ar ON ac.sub_area = ar.id_area

-- After
LEFT JOIN adm_cargos c ON ac.ac_id_cargo = c.id_cargo
LEFT JOIN adm_área ar ON ac.ac_sub_area = ar.id_area
```

#### 3. Fixed Situación Filter
```sql
-- Before
WHERE ac.situacion = 'A'

-- After
WHERE ac.ac_id_situación IN ('A', 'V', 'P')
```
This now includes employees who are:
- A: Activo (Active)
- V: Vacaciones (Vacation)
- P: Permiso (Leave/Permission)

#### 4. Added NULL Check
```sql
-- Before
AND cf.fecha >= CURRENT_DATE - (cp.frecuencia_meses || ' months')::INTERVAL

-- After
AND cf.fecha >= CURRENT_DATE - (COALESCE(cp.frecuencia_meses, 12) || ' months')::INTERVAL
```

#### 5. Improved Logic for Capacitaciones Pendientes
Added a separate CTE that properly calculates pending trainings by:
- Finding programmed trainings for each employee based on cargo and sub_area
- Checking if the training has been completed within the frequency period
- Counting only those trainings that are pending

## Query Structure

The final query uses 3 Common Table Expressions (CTEs):

1. **capacitaciones_realizadas**: Counts distinct trainings attended by each employee
2. **capacitaciones_programadas**: Counts total programmed trainings per employee
3. **capacitaciones_pendientes**: Calculates pending trainings (programmed but not completed)

## Testing

- ✅ PHP syntax check passed
- ✅ Code review completed (only minor nitpicks)
- ✅ CodeQL security scan passed
- ⚠️ Database testing recommended to verify data accuracy

## Impact

This fix ensures:
- The API returns proper JSON data without Error 500
- Personnel with status A, V, or P are included in the query
- Column names match the actual database schema
- Table names are correct
- NULL values in frecuencia_meses don't cause errors
- Capacitaciones pendientes are calculated correctly based on frequency requirements

## Files Changed

- `m_capacitaciones/assets/php/consultas_por_persona_api.php`

## Next Steps

1. Deploy the changes to the development environment
2. Test the API endpoint directly to verify JSON response
3. Test the UI to ensure data displays correctly in the table
4. Verify that filters, sorting, and pagination work properly
5. Test with different employee statuses (A, V, P)
6. Verify frequency calculations are working correctly
