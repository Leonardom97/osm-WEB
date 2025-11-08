-- Migration script to fix sub_area storage in cap_programacion
-- Issue: sub_area is currently stored as text (name) instead of ID reference
-- Solution: Change to store id_area from adm_área table

-- Step 1: Add new column for sub_area ID reference
ALTER TABLE cap_programacion 
ADD COLUMN IF NOT EXISTS id_sub_area VARCHAR(255);

COMMENT ON COLUMN cap_programacion.id_sub_area IS 'Reference to adm_área.id_area for sub-area';

-- Step 2: Migrate existing data from sub_area text to id_sub_area
-- Match the sub_area text value with adm_área.sub_area to get the id_area
UPDATE cap_programacion p
SET id_sub_area = (
    SELECT a.id_area
    FROM adm_área a
    WHERE a.sub_area = p.sub_area
    LIMIT 1
)
WHERE p.sub_area IS NOT NULL 
AND p.sub_area != ''
AND p.id_sub_area IS NULL;

-- Step 3: Keep the old sub_area column for now (will be renamed to sub_area_old)
-- This allows rollback if needed
ALTER TABLE cap_programacion 
RENAME COLUMN sub_area TO sub_area_old;

-- Step 4: Rename id_sub_area to sub_area to match existing code expectations
ALTER TABLE cap_programacion 
RENAME COLUMN id_sub_area TO sub_area;

-- Step 5: Update the comment
COMMENT ON COLUMN cap_programacion.sub_area IS 'Reference to adm_área.id_area (ID, not name)';

-- Step 6: Create function to get sub_area name from ID for display purposes
CREATE OR REPLACE FUNCTION get_sub_area_nombre(p_id_area VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    v_sub_area VARCHAR;
BEGIN
    SELECT sub_area INTO v_sub_area
    FROM adm_área
    WHERE id_area = p_id_area;
    
    RETURN COALESCE(v_sub_area, '');
END;
$$ LANGUAGE plpgsql;

-- Step 7: Update the trigger function to work with ID-based sub_area
CREATE OR REPLACE FUNCTION actualizar_fechas_programacion()
RETURNS TRIGGER AS $$
DECLARE
    v_id_tema INT;
    v_fecha_capacitacion DATE;
    v_id_cargo VARCHAR(255);
    v_id_sub_area VARCHAR(255);
BEGIN
    -- Get the tema and fecha from the formulario
    SELECT f.id_tema, f.fecha 
    INTO v_id_tema, v_fecha_capacitacion
    FROM cap_formulario f
    WHERE f.id = NEW.id_formulario;
    
    -- Get cargo ID from the asistente's cargo name or use ac_id_cargo if available
    IF NEW.id_colaborador IS NOT NULL THEN
        SELECT ac_id_cargo, ac_sub_area
        INTO v_id_cargo, v_id_sub_area
        FROM adm_colaboradores
        WHERE ac_id = NEW.id_colaborador;
    ELSE
        -- Fallback: try to match cargo by name
        SELECT c.id_cargo
        INTO v_id_cargo
        FROM adm_cargos c
        WHERE c.cargo = NEW.cargo
        LIMIT 1;
        
        -- Try to match sub_area by name to get ID
        SELECT a.id_area
        INTO v_id_sub_area
        FROM adm_área a
        WHERE a.sub_area = NEW.sub_área
        LIMIT 1;
    END IF;
    
    -- Skip if training was not approved
    IF NEW.estado_aprobacion != 'aprobo' THEN
        RETURN NEW;
    END IF;
    
    -- Update programacion records that match this training
    -- Match by: tema, cargo, and sub_area (now using IDs)
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
    AND (p.sub_area = v_id_sub_area OR (p.sub_area IS NULL AND v_id_sub_area IS NULL))
    AND p.activo = true;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Verification queries (commented out - uncomment to test)
-- SELECT id, id_cargo, sub_area, sub_area_old FROM cap_programacion;
-- SELECT id_area, area, sub_area FROM adm_área ORDER BY sub_area;
