-- Test script for programacion trigger functionality
-- This script tests the automatic date update when training is completed

-- Test 1: Create a test programacion entry
DO $$
DECLARE
    v_test_prog_id INT;
    v_test_cargo_id VARCHAR(255);
    v_test_tema_id INT;
    v_test_rol_id INT;
BEGIN
    -- Get a test cargo (ANALISTA DE INFORMACION)
    SELECT id_cargo INTO v_test_cargo_id FROM adm_cargos WHERE cargo = 'ANALISTA DE INFORMACION' LIMIT 1;
    
    -- Get a test tema (any active tema)
    SELECT id INTO v_test_tema_id FROM cap_tema ORDER BY id LIMIT 1;
    
    -- Get Capacitador TI role
    SELECT id INTO v_test_rol_id FROM adm_roles WHERE nombre LIKE '%Capacitador%TI%' LIMIT 1;
    IF v_test_rol_id IS NULL THEN
        SELECT id INTO v_test_rol_id FROM adm_roles WHERE nombre = 'Capacitador' LIMIT 1;
    END IF;
    
    IF v_test_cargo_id IS NOT NULL AND v_test_tema_id IS NOT NULL AND v_test_rol_id IS NOT NULL THEN
        -- Delete existing test programacion if exists
        DELETE FROM cap_programacion 
        WHERE sub_area = 'TEST_TRIGGER' 
        AND id_cargo = v_test_cargo_id 
        AND id_tema = v_test_tema_id;
        
        -- Create test programacion
        INSERT INTO cap_programacion (
            id_tema, 
            id_cargo, 
            sub_area, 
            frecuencia_meses, 
            id_rol_capacitador,
            fecha_proxima_capacitacion,
            fecha_notificacion_previa,
            activo
        ) VALUES (
            v_test_tema_id,
            v_test_cargo_id,
            'TEST_TRIGGER',
            12,
            v_test_rol_id,
            CURRENT_DATE + INTERVAL '12 months',
            CURRENT_DATE + INTERVAL '11 months',
            true
        ) RETURNING id INTO v_test_prog_id;
        
        RAISE NOTICE 'Created test programacion with ID: %, cargo: %, tema: %, rol: %', 
            v_test_prog_id, v_test_cargo_id, v_test_tema_id, v_test_rol_id;
    ELSE
        RAISE NOTICE 'Could not find required test data: cargo=%, tema=%, rol=%', 
            v_test_cargo_id, v_test_tema_id, v_test_rol_id;
    END IF;
END $$;

-- Test 2: Show current state of test programacion
SELECT 
    p.id,
    p.id_tema,
    t.nombre as tema_nombre,
    p.id_cargo,
    c.cargo as cargo_nombre,
    p.sub_area,
    p.frecuencia_meses,
    p.fecha_ultima_capacitacion,
    p.fecha_proxima_capacitacion,
    p.fecha_notificacion_previa,
    r.nombre as rol_capacitador
FROM cap_programacion p
INNER JOIN cap_tema t ON p.id_tema = t.id
INNER JOIN adm_cargos c ON p.id_cargo = c.id_cargo
INNER JOIN adm_roles r ON p.id_rol_capacitador = r.id
WHERE p.sub_area = 'TEST_TRIGGER'
AND p.activo = true;

-- Test 3: Simulate creating a formulario and asistente
-- Note: This is a simulation - in real use, this happens through the PHP API
DO $$
DECLARE
    v_test_formulario_id INT;
    v_test_tema_id INT;
    v_test_cargo VARCHAR(255);
    v_test_colaborador_cedula VARCHAR(255);
    v_fecha_capacitacion DATE := '2024-12-15';
BEGIN
    -- Get test data from programacion
    SELECT p.id_tema, c.cargo 
    INTO v_test_tema_id, v_test_cargo
    FROM cap_programacion p
    INNER JOIN adm_cargos c ON p.id_cargo = c.id_cargo
    WHERE p.sub_area = 'TEST_TRIGGER' 
    AND p.activo = true
    LIMIT 1;
    
    -- Get a test colaborador with same cargo
    SELECT ac_cedula 
    INTO v_test_colaborador_cedula
    FROM adm_colaboradores col
    INNER JOIN adm_cargos c ON col.ac_id_cargo = c.id_cargo
    WHERE c.cargo = v_test_cargo
    AND col.ac_id_situación IN ('A', 'V', 'P')
    LIMIT 1;
    
    IF v_test_tema_id IS NOT NULL AND v_test_cargo IS NOT NULL AND v_test_colaborador_cedula IS NOT NULL THEN
        -- Create test formulario
        INSERT INTO cap_formulario (
            id_proceso, 
            id_lugar, 
            id_usuario, 
            id_tipo_actividad, 
            id_tema, 
            fecha,
            observaciones,
            creado_por
        ) VALUES (
            1, -- test proceso
            1, -- test lugar
            (SELECT id FROM adm_usuarios LIMIT 1), -- any user
            1, -- test tipo actividad
            v_test_tema_id,
            v_fecha_capacitacion,
            'TEST: Trigger test formulario',
            (SELECT id FROM adm_usuarios LIMIT 1)
        ) RETURNING id INTO v_test_formulario_id;
        
        -- Create test asistente (this should trigger the update)
        INSERT INTO cap_formulario_asistente (
            id_formulario,
            cedula,
            estado_aprobacion,
            nombre,
            empresa,
            cargo,
            área,
            sub_área,
            rango,
            situacion
        ) VALUES (
            v_test_formulario_id,
            v_test_colaborador_cedula,
            'aprobo',
            'TEST COLABORADOR',
            'TEST EMPRESA',
            v_test_cargo,
            'TEST',
            'TEST_TRIGGER',
            'TEST RANGO',
            'Activo'
        );
        
        RAISE NOTICE 'Created test formulario with ID: % and asistente with cedula: %', 
            v_test_formulario_id, v_test_colaborador_cedula;
        RAISE NOTICE 'Trigger should have updated programacion dates now...';
    ELSE
        RAISE NOTICE 'Could not find test data: tema=%, cargo=%, cedula=%',
            v_test_tema_id, v_test_cargo, v_test_colaborador_cedula;
    END IF;
END $$;

-- Test 4: Show updated state of test programacion (should show updated dates)
SELECT 
    p.id,
    p.id_tema,
    t.nombre as tema_nombre,
    p.id_cargo,
    c.cargo as cargo_nombre,
    p.sub_area,
    p.frecuencia_meses,
    p.fecha_ultima_capacitacion,
    p.fecha_proxima_capacitacion,
    p.fecha_notificacion_previa,
    CASE 
        WHEN p.fecha_ultima_capacitacion = '2024-12-15' THEN '✓ PASS'
        ELSE '✗ FAIL'
    END as test_fecha_ultima,
    CASE 
        WHEN p.fecha_proxima_capacitacion = '2024-12-15'::date + (p.frecuencia_meses * INTERVAL '1 month') THEN '✓ PASS'
        ELSE '✗ FAIL'
    END as test_fecha_proxima,
    CASE 
        WHEN p.fecha_notificacion_previa = '2024-12-15'::date + (p.frecuencia_meses * INTERVAL '1 month') - INTERVAL '1 month' THEN '✓ PASS'
        ELSE '✗ FAIL'
    END as test_fecha_notificacion,
    r.nombre as rol_capacitador
FROM cap_programacion p
INNER JOIN cap_tema t ON p.id_tema = t.id
INNER JOIN adm_cargos c ON p.id_cargo = c.id_cargo
INNER JOIN adm_roles r ON p.id_rol_capacitador = r.id
WHERE p.sub_area = 'TEST_TRIGGER'
AND p.activo = true;

-- Test 5: Cleanup - remove test data
-- Uncomment the following lines to cleanup test data after verification
/*
DELETE FROM cap_formulario_asistente 
WHERE sub_área = 'TEST_TRIGGER';

DELETE FROM cap_formulario 
WHERE observaciones = 'TEST: Trigger test formulario';

DELETE FROM cap_programacion 
WHERE sub_area = 'TEST_TRIGGER';

RAISE NOTICE 'Test data cleaned up';
*/
