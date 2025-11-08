-- Migration script to fix spelling error: estado_aprovacion -> estado_aprobacion
-- This script renames the column in the cap_formulario_asistente table

-- Rename the column from estado_aprovacion to estado_aprobacion
ALTER TABLE cap_formulario_asistente 
RENAME COLUMN estado_aprovacion TO estado_aprobacion;

-- Add a comment to document this change
COMMENT ON COLUMN cap_formulario_asistente.estado_aprobacion IS 'Estado de aprobación del asistente (corrected spelling from estado_aprovacion)';
