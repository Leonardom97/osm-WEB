-- Verification script to check if estado columns exist in capacity tables
-- Run this script to verify the migration was successful

\echo '========================================'
\echo 'Checking estado column in capacity tables'
\echo '========================================'
\echo ''

-- Check cap_tema
\echo 'Checking cap_tema...'
SELECT 
    column_name, 
    data_type, 
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'cap_tema' 
AND column_name = 'estado';

-- Count active and inactive temas
\echo 'cap_tema statistics:'
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS inactivos
FROM cap_tema;

\echo ''

-- Check cap_proceso
\echo 'Checking cap_proceso...'
SELECT 
    column_name, 
    data_type, 
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'cap_proceso' 
AND column_name = 'estado';

-- Count active and inactive procesos
\echo 'cap_proceso statistics:'
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS inactivos
FROM cap_proceso;

\echo ''

-- Check cap_lugar
\echo 'Checking cap_lugar...'
SELECT 
    column_name, 
    data_type, 
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'cap_lugar' 
AND column_name = 'estado';

-- Count active and inactive lugares
\echo 'cap_lugar statistics:'
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS inactivos
FROM cap_lugar;

\echo ''

-- Check cap_tipo_actividad
\echo 'Checking cap_tipo_actividad...'
SELECT 
    column_name, 
    data_type, 
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'cap_tipo_actividad' 
AND column_name = 'estado';

-- Count active and inactive tipo_actividad
\echo 'cap_tipo_actividad statistics:'
SELECT 
    COUNT(*) AS total,
    SUM(CASE WHEN estado = 0 THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN estado = 1 THEN 1 ELSE 0 END) AS inactivos
FROM cap_tipo_actividad;

\echo ''
\echo '========================================'
\echo 'Verification complete!'
\echo '========================================'
\echo ''
\echo 'Expected results:'
\echo '- All tables should show estado column with smallint type'
\echo '- Default value should be 0'
\echo '- All existing records should have estado = 0 (active)'
\echo ''
\echo 'If any table is missing the estado column, run:'
\echo 'psql -U postgres -d osm2 -f db/03_r_update\ formulario.sql'
\echo ''
