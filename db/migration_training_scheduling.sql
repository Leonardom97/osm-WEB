-- Migration for Training Scheduling and Notification System
-- Date: 2025-10-23
-- Description: Adds tables and roles for training programming, scheduling, and notifications

-- ===================================================
-- 1. Add new training coordinator roles
-- ===================================================
INSERT INTO "public"."adm_roles" (nombre) VALUES ('Capacitador SIE') ON CONFLICT DO NOTHING;
INSERT INTO "public"."adm_roles" (nombre) VALUES ('Capacitador GH') ON CONFLICT DO NOTHING;
INSERT INTO "public"."adm_roles" (nombre) VALUES ('Capacitador TI') ON CONFLICT DO NOTHING;
INSERT INTO "public"."adm_roles" (nombre) VALUES ('Capacitador MT') ON CONFLICT DO NOTHING;

-- ===================================================
-- 2. Create training programming table
-- ===================================================
DROP TABLE IF EXISTS "public"."cap_programacion" CASCADE;
CREATE TABLE "public"."cap_programacion" (
  "id" SERIAL PRIMARY KEY,
  "id_tema" int4 NOT NULL,
  "id_cargo" varchar(255) NOT NULL,
  "sub_area" varchar(255),
  "frecuencia_meses" int4 NOT NULL DEFAULT 12,
  "id_rol_capacitador" int4 NOT NULL,
  "fecha_creacion" timestamp DEFAULT CURRENT_TIMESTAMP,
  "activo" boolean DEFAULT true,
  CONSTRAINT fk_tema FOREIGN KEY (id_tema) REFERENCES cap_tema(id) ON DELETE CASCADE,
  CONSTRAINT fk_cargo FOREIGN KEY (id_cargo) REFERENCES adm_cargos(id_cargo) ON DELETE CASCADE,
  CONSTRAINT fk_rol FOREIGN KEY (id_rol_capacitador) REFERENCES adm_roles(id) ON DELETE CASCADE
);

CREATE INDEX idx_cap_programacion_cargo ON cap_programacion(id_cargo);
CREATE INDEX idx_cap_programacion_sub_area ON cap_programacion(sub_area);
CREATE INDEX idx_cap_programacion_tema ON cap_programacion(id_tema);

COMMENT ON TABLE cap_programacion IS 'Stores scheduled training programs by position and sub-area';
COMMENT ON COLUMN cap_programacion.frecuencia_meses IS 'Training frequency in months';
COMMENT ON COLUMN cap_programacion.id_rol_capacitador IS 'Role ID of the trainer responsible';

-- ===================================================
-- 3. Create training notifications table
-- ===================================================
DROP TABLE IF EXISTS "public"."cap_notificaciones" CASCADE;
CREATE TABLE "public"."cap_notificaciones" (
  "id" SERIAL PRIMARY KEY,
  "id_colaborador" int4 NOT NULL,
  "id_programacion" int4 NOT NULL,
  "fecha_ultima_capacitacion" date,
  "fecha_proxima" date NOT NULL,
  "dias_para_vencimiento" int4,
  "estado" varchar(50) DEFAULT 'pendiente',
  "leida" boolean DEFAULT false,
  "fecha_creacion" timestamp DEFAULT CURRENT_TIMESTAMP,
  "fecha_actualizacion" timestamp DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_colaborador FOREIGN KEY (id_colaborador) REFERENCES adm_colaboradores(ac_id) ON DELETE CASCADE,
  CONSTRAINT fk_programacion FOREIGN KEY (id_programacion) REFERENCES cap_programacion(id) ON DELETE CASCADE
);

CREATE INDEX idx_notif_colaborador ON cap_notificaciones(id_colaborador);
CREATE INDEX idx_notif_estado ON cap_notificaciones(estado);
CREATE INDEX idx_notif_leida ON cap_notificaciones(leida);
CREATE INDEX idx_notif_fecha_proxima ON cap_notificaciones(fecha_proxima);

COMMENT ON TABLE cap_notificaciones IS 'Stores training notifications for collaborators';
COMMENT ON COLUMN cap_notificaciones.estado IS 'Status: pendiente, completada, vencida';
COMMENT ON COLUMN cap_notificaciones.dias_para_vencimiento IS 'Days until training expires';

-- ===================================================
-- 4. Create view for training progress tracking
-- ===================================================
DROP VIEW IF EXISTS "public"."v_progreso_capacitaciones";
CREATE VIEW "public"."v_progreso_capacitaciones" AS
SELECT 
  c.ac_id,
  c.ac_cedula,
  c.ac_nombre1 || ' ' || COALESCE(c.ac_nombre2, '') || ' ' || c.ac_apellido1 || ' ' || COALESCE(c.ac_apellido2, '') AS nombre_completo,
  c.ac_id_cargo,
  c.ac_sub_area,
  COUNT(DISTINCT p.id) AS capacitaciones_programadas,
  COUNT(DISTINCT CASE WHEN fa.id IS NOT NULL THEN fa.id_formulario END) AS capacitaciones_realizadas,
  ROUND(
    (COUNT(DISTINCT CASE WHEN fa.id IS NOT NULL THEN fa.id_formulario END)::numeric / 
    NULLIF(COUNT(DISTINCT p.id), 0)) * 100, 2
  ) AS porcentaje_completado
FROM 
  adm_colaboradores c
  LEFT JOIN cap_programacion p ON c.ac_id_cargo = p.id_cargo 
    AND (p.sub_area IS NULL OR p.sub_area = c.ac_sub_area)
    AND p.activo = true
  LEFT JOIN cap_formulario_asistente fa ON fa.cedula = c.ac_cedula
WHERE 
  c.ac_id_situación IN ('A', 'V', 'P')
GROUP BY 
  c.ac_id, c.ac_cedula, c.ac_nombre1, c.ac_nombre2, c.ac_apellido1, c.ac_apellido2, c.ac_id_cargo, c.ac_sub_area;

COMMENT ON VIEW v_progreso_capacitaciones IS 'View showing training progress for each active collaborator';

-- ===================================================
-- 5. Create function to update notifications
-- ===================================================
CREATE OR REPLACE FUNCTION actualizar_notificaciones_capacitacion()
RETURNS void AS $$
BEGIN
  -- Delete old notifications for inactive schedules
  DELETE FROM cap_notificaciones 
  WHERE id_programacion IN (
    SELECT id FROM cap_programacion WHERE activo = false
  );

  -- Create or update notifications for active schedules
  WITH ultima_capacitacion AS (
    SELECT 
      c.ac_id,
      p.id as programacion_id,
      MAX(CASE WHEN fa.id IS NOT NULL THEN f.fecha ELSE NULL END) AS fecha_ultima,
      p.frecuencia_meses
    FROM 
      adm_colaboradores c
      INNER JOIN cap_programacion p ON c.ac_id_cargo = p.id_cargo 
        AND (p.sub_area IS NULL OR p.sub_area = c.ac_sub_area)
        AND p.activo = true
      LEFT JOIN cap_formulario f ON f.id_tema = p.id_tema
      LEFT JOIN cap_formulario_asistente fa ON fa.id_formulario = f.id AND fa.cedula = c.ac_cedula
    WHERE 
      c.ac_id_situación IN ('A', 'V', 'P')
    GROUP BY 
      c.ac_id, p.id, p.frecuencia_meses
  )
  INSERT INTO cap_notificaciones (
    id_colaborador,
    id_programacion,
    fecha_ultima_capacitacion,
    fecha_proxima,
    dias_para_vencimiento,
    estado
  )
  SELECT 
    uc.ac_id,
    uc.programacion_id,
    uc.fecha_ultima,
    CASE 
      WHEN uc.fecha_ultima IS NULL THEN CURRENT_DATE
      ELSE uc.fecha_ultima + (uc.frecuencia_meses * INTERVAL '1 month')
    END AS fecha_proxima,
    CASE 
      WHEN uc.fecha_ultima IS NULL THEN 0
      ELSE EXTRACT(DAY FROM (uc.fecha_ultima + (uc.frecuencia_meses * INTERVAL '1 month') - CURRENT_DATE))::int
    END AS dias_para_vencimiento,
    CASE 
      WHEN uc.fecha_ultima IS NULL THEN 'pendiente'
      WHEN (uc.fecha_ultima + (uc.frecuencia_meses * INTERVAL '1 month')) < CURRENT_DATE THEN 'vencida'
      WHEN (uc.fecha_ultima + (uc.frecuencia_meses * INTERVAL '1 month')) <= (CURRENT_DATE + INTERVAL '30 days') THEN 'proximo_vencer'
      ELSE 'vigente'
    END AS estado
  FROM ultima_capacitacion uc
  ON CONFLICT (id_colaborador, id_programacion) 
  DO UPDATE SET
    fecha_ultima_capacitacion = EXCLUDED.fecha_ultima_capacitacion,
    fecha_proxima = EXCLUDED.fecha_proxima,
    dias_para_vencimiento = EXCLUDED.dias_para_vencimiento,
    estado = EXCLUDED.estado,
    fecha_actualizacion = CURRENT_TIMESTAMP;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION actualizar_notificaciones_capacitacion IS 'Updates training notifications based on completed trainings and schedules';

-- ===================================================
-- 6. Add unique constraint to prevent duplicate notifications
-- ===================================================
ALTER TABLE cap_notificaciones 
ADD CONSTRAINT uk_notif_colaborador_programacion 
UNIQUE (id_colaborador, id_programacion);

-- ===================================================
-- 7. Sample data for testing (optional)
-- ===================================================
-- Uncomment to add sample training schedules
/*
INSERT INTO cap_programacion (id_tema, id_cargo, sub_area, frecuencia_meses, id_rol_capacitador)
VALUES 
  (1, '117', 'Mantenimiento Industrial', 12, (SELECT id FROM adm_roles WHERE nombre = 'Capacitador GH')),
  (3, '117', 'Mantenimiento Industrial', 12, (SELECT id FROM adm_roles WHERE nombre = 'Capacitador SIE'));
*/

-- ===================================================
-- 8. Grant permissions (adjust as needed)
-- ===================================================
-- GRANT SELECT, INSERT, UPDATE, DELETE ON cap_programacion TO your_app_user;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON cap_notificaciones TO your_app_user;
-- GRANT SELECT ON v_progreso_capacitaciones TO your_app_user;
-- GRANT EXECUTE ON FUNCTION actualizar_notificaciones_capacitacion() TO your_app_user;
