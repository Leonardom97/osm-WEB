-- Migration script to add new columns to cap_programacion table
-- This script adds date tracking columns for training scheduling

-- Add new columns to cap_programacion if they don't exist
ALTER TABLE cap_programacion 
ADD COLUMN IF NOT EXISTS fecha_ultima_capacitacion DATE,
ADD COLUMN IF NOT EXISTS fecha_proxima_capacitacion DATE,
ADD COLUMN IF NOT EXISTS fecha_notificacion_previa DATE;

COMMENT ON COLUMN cap_programacion.fecha_ultima_capacitacion IS 'Date of the most recent training for this programming';
COMMENT ON COLUMN cap_programacion.fecha_proxima_capacitacion IS 'Date of the next scheduled training';
COMMENT ON COLUMN cap_programacion.fecha_notificacion_previa IS 'Date when notification should be sent (1 month before next training)';

-- Add id_colaborador column to cap_formulario_asistente if it doesn't exist
ALTER TABLE cap_formulario_asistente
ADD COLUMN IF NOT EXISTS id_colaborador INT;

COMMENT ON COLUMN cap_formulario_asistente.id_colaborador IS 'Reference to adm_colaboradores.ac_id for tracking purposes';

-- Function to update programacion dates when a new training is completed
CREATE OR REPLACE FUNCTION actualizar_fechas_programacion()
RETURNS TRIGGER AS $$
DECLARE
    v_id_tema INT;
    v_fecha_capacitacion DATE;
    v_id_cargo VARCHAR(255);
    v_sub_area VARCHAR(255);
BEGIN
    -- Get the tema and fecha from the formulario
    SELECT f.id_tema, f.fecha 
    INTO v_id_tema, v_fecha_capacitacion
    FROM cap_formulario f
    WHERE f.id = NEW.id_formulario;
    
    -- Get cargo ID from the asistente's cargo name
    SELECT c.id_cargo
    INTO v_id_cargo
    FROM adm_cargos c
    WHERE c.cargo = NEW.cargo
    LIMIT 1;
    
    -- Get sub_area from asistente
    v_sub_area := NEW.sub_área;
    
    -- Skip if training was not approved
    IF NEW.estado_aprovacion != 'aprobo' THEN
        RETURN NEW;
    END IF;
    
    -- Update programacion records that match this training
    -- Match by: tema, cargo, and sub_area
    UPDATE cap_programacion p
    SET 
        fecha_ultima_capacitacion = GREATEST(
            COALESCE(p.fecha_ultima_capacitacion, v_fecha_capacitacion), 
            v_fecha_capacitacion
        ),
        fecha_proxima_capacitacion = v_fecha_capacitacion + (p.frecuencia_meses * INTERVAL '1 month'),
        fecha_notificacion_previa = (v_fecha_capacitacion + (p.frecuencia_meses * INTERVAL '1 month')) - INTERVAL '1 month'
    WHERE p.id_tema = v_id_tema
    AND p.id_cargo = v_id_cargo
    AND (p.sub_area = v_sub_area OR (p.sub_area IS NULL AND v_sub_area IS NULL))
    AND p.activo = true;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update programacion when formulario_asistente is inserted
DROP TRIGGER IF EXISTS trigger_actualizar_programacion ON cap_formulario_asistente;
CREATE TRIGGER trigger_actualizar_programacion
AFTER INSERT ON cap_formulario_asistente
FOR EACH ROW
EXECUTE FUNCTION actualizar_fechas_programacion();

-- Function to initialize programacion dates for existing records
CREATE OR REPLACE FUNCTION inicializar_fechas_programacion()
RETURNS void AS $$
BEGIN
    -- Set initial dates for programacion records that don't have them
    -- Use current date as base for records without any training history
    UPDATE cap_programacion
    SET 
        fecha_proxima_capacitacion = CURRENT_DATE + (frecuencia_meses || ' months')::INTERVAL,
        fecha_notificacion_previa = CURRENT_DATE + (frecuencia_meses || ' months')::INTERVAL - INTERVAL '1 month'
    WHERE fecha_proxima_capacitacion IS NULL
    AND activo = true;
END;
$$ LANGUAGE plpgsql;

-- Initialize dates for existing programacion records
SELECT inicializar_fechas_programacion();
