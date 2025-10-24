-- Migration to add user tracking fields to cap_formulario table
-- This tracks who created and who last edited each training form

-- Add columns to track creator and editor
ALTER TABLE cap_formulario 
ADD COLUMN IF NOT EXISTS creado_por INT4,
ADD COLUMN IF NOT EXISTS editado_por INT4,
ADD COLUMN IF NOT EXISTS fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN IF NOT EXISTS fecha_edicion TIMESTAMP;

-- Add foreign keys to reference adm_usuarios
ALTER TABLE cap_formulario
ADD CONSTRAINT fk_creado_por 
FOREIGN KEY (creado_por) REFERENCES adm_usuarios(id) ON DELETE SET NULL;

ALTER TABLE cap_formulario
ADD CONSTRAINT fk_editado_por 
FOREIGN KEY (editado_por) REFERENCES adm_usuarios(id) ON DELETE SET NULL;

-- Add comments to document the columns
COMMENT ON COLUMN cap_formulario.creado_por IS 'ID del usuario que creó el formulario';
COMMENT ON COLUMN cap_formulario.editado_por IS 'ID del usuario que editó por última vez el formulario';
COMMENT ON COLUMN cap_formulario.fecha_creacion IS 'Fecha y hora de creación del formulario';
COMMENT ON COLUMN cap_formulario.fecha_edicion IS 'Fecha y hora de la última edición del formulario';
