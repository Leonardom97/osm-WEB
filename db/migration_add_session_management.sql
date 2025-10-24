-- Migration: Add session management table and file attachments to cap_formulario
-- This migration adds support for:
-- 1. Session tracking to prevent concurrent logins
-- 2. File attachments for training forms (capacitaciones)

-- ============================================
-- 1. Session Management Table
-- ============================================

-- Create sessions table if it doesn't exist
CREATE TABLE IF NOT EXISTS "public"."adm_sesiones" (
  "id" SERIAL PRIMARY KEY,
  "usuario_id" INT4 NOT NULL,
  "tipo_usuario" VARCHAR(20) NOT NULL, -- 'admin' or 'colaborador'
  "session_id" VARCHAR(255) NOT NULL UNIQUE,
  "ip_address" VARCHAR(45),
  "user_agent" TEXT,
  "host_name" VARCHAR(255),
  "fecha_inicio" TIMESTAMP DEFAULT NOW(),
  "fecha_actividad" TIMESTAMP DEFAULT NOW(),
  "activa" BOOLEAN DEFAULT TRUE,
  "cerrada_por" INT4, -- NULL if logged out by themselves, otherwise admin who closed it
  "razon_cierre" VARCHAR(100), -- 'logout', 'admin_disconnect', 'concurrent_login', 'timeout'
  "fecha_cierre" TIMESTAMP
);

COMMENT ON TABLE "public"."adm_sesiones" IS 'Tracks all user login sessions for security and concurrent login prevention';
COMMENT ON COLUMN "public"."adm_sesiones"."usuario_id" IS 'Foreign key to adm_usuarios.id or adm_colaboradores.ac_id depending on tipo_usuario';
COMMENT ON COLUMN "public"."adm_sesiones"."tipo_usuario" IS 'Type of user: admin or colaborador';
COMMENT ON COLUMN "public"."adm_sesiones"."session_id" IS 'PHP session ID';
COMMENT ON COLUMN "public"."adm_sesiones"."ip_address" IS 'IP address of the user';
COMMENT ON COLUMN "public"."adm_sesiones"."user_agent" IS 'Browser user agent string';
COMMENT ON COLUMN "public"."adm_sesiones"."host_name" IS 'Computer/host name if available';
COMMENT ON COLUMN "public"."adm_sesiones"."fecha_actividad" IS 'Last activity timestamp - updated on each request';
COMMENT ON COLUMN "public"."adm_sesiones"."activa" IS 'TRUE if session is currently active';
COMMENT ON COLUMN "public"."adm_sesiones"."cerrada_por" IS 'User ID of admin who closed the session, NULL if self logout';
COMMENT ON COLUMN "public"."adm_sesiones"."razon_cierre" IS 'Reason for session closure';

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_sesiones_usuario_id ON "public"."adm_sesiones" (usuario_id);
CREATE INDEX IF NOT EXISTS idx_sesiones_activa ON "public"."adm_sesiones" (activa);
CREATE INDEX IF NOT EXISTS idx_sesiones_session_id ON "public"."adm_sesiones" (session_id);
CREATE INDEX IF NOT EXISTS idx_sesiones_tipo_usuario ON "public"."adm_sesiones" (tipo_usuario);

-- ============================================
-- 2. Login Attempts Table (for security audit)
-- ============================================

CREATE TABLE IF NOT EXISTS "public"."adm_intentos_login" (
  "id" SERIAL PRIMARY KEY,
  "usuario_identificador" VARCHAR(100) NOT NULL, -- cedula or username attempted
  "tipo_usuario" VARCHAR(20), -- 'admin' or 'colaborador'
  "exitoso" BOOLEAN NOT NULL,
  "ip_address" VARCHAR(45),
  "user_agent" TEXT,
  "host_name" VARCHAR(255),
  "mensaje_error" VARCHAR(255),
  "fecha" TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE "public"."adm_intentos_login" IS 'Audit log of all login attempts (successful and failed)';

CREATE INDEX IF NOT EXISTS idx_intentos_fecha ON "public"."adm_intentos_login" (fecha);
CREATE INDEX IF NOT EXISTS idx_intentos_exitoso ON "public"."adm_intentos_login" (exitoso);
CREATE INDEX IF NOT EXISTS idx_intentos_identificador ON "public"."adm_intentos_login" (usuario_identificador);

-- ============================================
-- 3. File Attachments for Training Forms
-- ============================================

-- Add file attachment column to cap_formulario if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'cap_formulario' 
        AND column_name = 'archivo_adjunto'
    ) THEN
        ALTER TABLE "public"."cap_formulario" 
        ADD COLUMN "archivo_adjunto" VARCHAR(255);
        
        COMMENT ON COLUMN "public"."cap_formulario"."archivo_adjunto" 
        IS 'Filename of attached PDF or image file (stored in m_capacitaciones/formulario/[id]/)';
    END IF;
END $$;

-- ============================================
-- Verification Queries
-- ============================================

-- To verify the migration was successful, run:
-- SELECT * FROM information_schema.tables WHERE table_name IN ('adm_sesiones', 'adm_intentos_login');
-- SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'cap_formulario' AND column_name = 'archivo_adjunto';
-- SELECT * FROM adm_sesiones LIMIT 5;
