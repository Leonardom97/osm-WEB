-- Migration script to disable automatic date updates from formulario
-- Issue 2: Remove the logic where formulario.html automatically updates programacion dates
-- Solution: Drop the trigger and allow manual date entry in programacion modal

-- Step 1: Drop the trigger that automatically updates dates
DROP TRIGGER IF EXISTS trigger_actualizar_programacion ON cap_formulario_asistente;

-- Step 2: Keep the function for potential future use but don't auto-execute it
-- (Commenting out the function removal in case it's needed elsewhere)
-- The function actualizar_fechas_programacion() will remain but won't be triggered

-- Step 3: Create a new function to manually update programacion dates
-- This will be called from the API when user manually updates the last training date
CREATE OR REPLACE FUNCTION actualizar_fechas_programacion_manual(
    p_id_programacion INT,
    p_fecha_ultima DATE
)
RETURNS void AS $$
BEGIN
    UPDATE cap_programacion
    SET 
        fecha_ultima_capacitacion = p_fecha_ultima,
        fecha_proxima_capacitacion = p_fecha_ultima + (frecuencia_meses * INTERVAL '1 month'),
        fecha_notificacion_previa = (p_fecha_ultima + (frecuencia_meses * INTERVAL '1 month')) - INTERVAL '1 month'
    WHERE id = p_id_programacion
    AND activo = true;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION actualizar_fechas_programacion_manual IS 'Manually update programacion dates based on last training date';

-- Verification query (commented - uncomment to test)
-- SELECT * FROM cap_programacion WHERE fecha_ultima_capacitacion IS NOT NULL;
