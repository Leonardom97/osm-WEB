-- ============================================================================
-- OSM Web Application - Consolidated Update Script
-- Compatible with PostgreSQL 9.x and Navicat
-- ============================================================================
-- 
-- Purpose: Apply all updates to an existing OSM database
-- Database: osm2
-- Target Version: PostgreSQL 9.x
-- Tool: Navicat or psql
-- Date: 2025-10-28
--
-- Instructions:
-- 1. Backup your database before running this script
-- 2. Execute in Navicat: Open this file and click "Run" or "Execute"
-- 3. Execute in psql: psql -U postgres -d osm2 -f db/update_osm_postgres9.sql
-- 4. Review output for any errors or warnings
-- 5. Test all functionality after applying updates
--
-- Note: This script is separate from osm_postgres.sql (main database schema)
-- ============================================================================

-- Start transaction
BEGIN;

-- ============================================================================
-- SECTION 1: Web Configuration Management
-- ============================================================================
-- Purpose: Add table for managing website configuration
-- Tables: adm_webmain
-- ============================================================================

-- Drop existing objects if present
DROP TRIGGER IF EXISTS trg_adm_webmain_updated_at ON public.adm_webmain;
DROP FUNCTION IF EXISTS public.trigger_set_updated_at() CASCADE;
DROP TABLE IF EXISTS public.adm_webmain CASCADE;

-- Create sequence for adm_webmain (PostgreSQL 9 compatible)
DROP SEQUENCE IF EXISTS public.adm_webmain_id_seq CASCADE;
CREATE SEQUENCE public.adm_webmain_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 2147483647
  START 1
  CACHE 1;

-- Create table adm_webmain
CREATE TABLE public.adm_webmain (
  id integer NOT NULL DEFAULT nextval('adm_webmain_id_seq'::regclass),
  site_title character varying(100) NOT NULL DEFAULT 'OSM',
  footer_text character varying(200) NOT NULL DEFAULT '© OSM 2025',
  favicon_path character varying(255) NOT NULL DEFAULT 'assets/img/Sin título-2.png',
  login_image_path character varying(255) NOT NULL DEFAULT 'assets/img/ico.jpg',
  primary_color character varying(7) NOT NULL DEFAULT '#772e22',
  is_active boolean NOT NULL DEFAULT true,
  theme_name character varying(50),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT adm_webmain_pkey PRIMARY KEY (id)
);

-- Set sequence ownership
ALTER SEQUENCE public.adm_webmain_id_seq OWNED BY public.adm_webmain.id;

-- Insert default configuration row
INSERT INTO public.adm_webmain (site_title, footer_text, favicon_path, login_image_path, primary_color, is_active, theme_name)
VALUES ('OSM', '© OSM 2025', 'assets/img/Sin título-2.png', 'assets/img/ico.jpg', '#772e22', true, 'Default');

-- Add comment to table
COMMENT ON TABLE public.adm_webmain IS 'Web configuration management table for site-wide settings';

-- Create index for active configuration
CREATE INDEX idx_adm_webmain_active ON public.adm_webmain USING btree (is_active);

-- Trigger function to update updated_at automatically
CREATE OR REPLACE FUNCTION public.trigger_set_updated_at()
RETURNS trigger AS
$$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to fire before update
CREATE TRIGGER trg_adm_webmain_updated_at
BEFORE UPDATE ON public.adm_webmain
FOR EACH ROW
EXECUTE PROCEDURE public.trigger_set_updated_at();

-- ============================================================================
-- SECTION 2: Training Module - Add Collaborator ID References
-- ============================================================================
-- Purpose: Add id_colaborador columns to training tables with cedula mapping
-- Tables: cap_formulario_asistente, cap_notificaciones
-- ============================================================================

-- Add id_colaborador column to cap_formulario_asistente if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'cap_formulario_asistente' 
    AND column_name = 'id_colaborador'
  ) THEN
    ALTER TABLE public.cap_formulario_asistente 
    ADD COLUMN id_colaborador INTEGER;
    
    COMMENT ON COLUMN public.cap_formulario_asistente.id_colaborador 
    IS 'Reference to adm_colaboradores.ac_id - populated from cedula match';
  END IF;
END $$;

-- Populate id_colaborador in cap_formulario_asistente by matching cedula
UPDATE public.cap_formulario_asistente a
SET id_colaborador = c.ac_id
FROM public.adm_colaboradores c
WHERE regexp_replace(a.cedula, '\D', '', 'g') = regexp_replace(c.ac_cedula, '\D', '', 'g')
  AND a.id_colaborador IS NULL;

-- Report mapping results
DO $$
DECLARE
    mapped_count INTEGER;
    unmapped_count INTEGER;
    total_count INTEGER;
    mapping_percentage NUMERIC(5,2);
BEGIN
    SELECT COUNT(*) INTO total_count FROM public.cap_formulario_asistente;
    
    SELECT COUNT(*) INTO mapped_count 
    FROM public.cap_formulario_asistente 
    WHERE id_colaborador IS NOT NULL;
    
    SELECT COUNT(*) INTO unmapped_count 
    FROM public.cap_formulario_asistente 
    WHERE id_colaborador IS NULL;
    
    IF total_count > 0 THEN
        mapping_percentage := (mapped_count::NUMERIC / total_count::NUMERIC) * 100;
    ELSE
        mapping_percentage := 0;
    END IF;
    
    RAISE NOTICE '=============================================================';
    RAISE NOTICE 'cap_formulario_asistente mapping results:';
    RAISE NOTICE 'Total records: %', total_count;
    RAISE NOTICE 'Successfully mapped: % records (%.2f%%)', mapped_count, mapping_percentage;
    RAISE NOTICE 'Unmapped (need manual review): % records', unmapped_count;
    RAISE NOTICE '=============================================================';
END $$;

-- Add cedula column to cap_notificaciones if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'cap_notificaciones' 
    AND column_name = 'cedula'
  ) THEN
    ALTER TABLE public.cap_notificaciones 
    ADD COLUMN cedula character varying(255);
    
    COMMENT ON COLUMN public.cap_notificaciones.cedula 
    IS 'Cedula for audit purposes - never deleted';
  END IF;
END $$;

-- Populate cedula from adm_colaboradores if empty
UPDATE public.cap_notificaciones n
SET cedula = c.ac_cedula
FROM public.adm_colaboradores c
WHERE n.id_colaborador = c.ac_id
  AND (n.cedula IS NULL OR n.cedula = '');

-- ============================================================================
-- SECTION 3: Performance Indexes
-- ============================================================================
-- Purpose: Create indexes for improved query performance
-- ============================================================================

-- Index on id_colaborador in cap_formulario_asistente
CREATE INDEX IF NOT EXISTS idx_cfa_id_colaborador 
ON public.cap_formulario_asistente USING btree (id_colaborador);

-- Index on id_colaborador in cap_notificaciones
CREATE INDEX IF NOT EXISTS idx_notif_id_colaborador 
ON public.cap_notificaciones USING btree (id_colaborador);

-- Index on fecha_proxima in cap_notificaciones for efficient date queries
CREATE INDEX IF NOT EXISTS idx_notif_fecha_proxima 
ON public.cap_notificaciones USING btree (fecha_proxima);

-- Index on estado in cap_notificaciones for filtering
CREATE INDEX IF NOT EXISTS idx_notif_estado 
ON public.cap_notificaciones USING btree (estado);

-- Index on cedula in cap_formulario_asistente for lookups
CREATE INDEX IF NOT EXISTS idx_cfa_cedula 
ON public.cap_formulario_asistente USING btree (cedula);

-- Add comments to indexes
COMMENT ON INDEX idx_cfa_id_colaborador IS 'Fast lookup by collaborator ID';
COMMENT ON INDEX idx_notif_id_colaborador IS 'Fast lookup by collaborator ID';
COMMENT ON INDEX idx_notif_fecha_proxima IS 'Fast filtering by next training date';
COMMENT ON INDEX idx_notif_estado IS 'Fast filtering by notification state';
COMMENT ON INDEX idx_cfa_cedula IS 'Fast lookup by cedula for form saves';

-- ============================================================================
-- SECTION 4: Verification Queries
-- ============================================================================
-- Purpose: Verify that all updates were applied successfully
-- ============================================================================

-- Verify adm_webmain table exists and has data
DO $$
DECLARE
    table_exists BOOLEAN;
    row_count INTEGER;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'adm_webmain'
    ) INTO table_exists;
    
    IF table_exists THEN
        SELECT COUNT(*) INTO row_count FROM public.adm_webmain;
        RAISE NOTICE 'Table adm_webmain exists with % rows', row_count;
    ELSE
        RAISE WARNING 'Table adm_webmain does NOT exist!';
    END IF;
END $$;

-- Verify cap_formulario_asistente has id_colaborador column
DO $$
DECLARE
    column_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'cap_formulario_asistente' 
        AND column_name = 'id_colaborador'
    ) INTO column_exists;
    
    IF column_exists THEN
        RAISE NOTICE 'Column cap_formulario_asistente.id_colaborador exists';
    ELSE
        RAISE WARNING 'Column cap_formulario_asistente.id_colaborador does NOT exist!';
    END IF;
END $$;

-- Verify cap_notificaciones has cedula column
DO $$
DECLARE
    column_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'cap_notificaciones' 
        AND column_name = 'cedula'
    ) INTO column_exists;
    
    IF column_exists THEN
        RAISE NOTICE 'Column cap_notificaciones.cedula exists';
    ELSE
        RAISE WARNING 'Column cap_notificaciones.cedula does NOT exist!';
    END IF;
END $$;

-- Verify indexes were created
DO $$
DECLARE
    index_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO index_count
    FROM pg_indexes
    WHERE schemaname = 'public'
    AND indexname IN (
        'idx_cfa_id_colaborador',
        'idx_notif_id_colaborador',
        'idx_notif_fecha_proxima',
        'idx_notif_estado',
        'idx_cfa_cedula',
        'idx_adm_webmain_active'
    );
    
    RAISE NOTICE 'Created indexes: % of 6 expected', index_count;
    
    IF index_count < 6 THEN
        RAISE WARNING 'Some indexes may not have been created!';
    END IF;
END $$;

-- ============================================================================
-- COMPLETION NOTICE
-- ============================================================================

DO $$
BEGIN
    RAISE NOTICE '=============================================================';
    RAISE NOTICE 'OSM Database Update Completed Successfully!';
    RAISE NOTICE '=============================================================';
    RAISE NOTICE 'Next Steps:';
    RAISE NOTICE '1. Review any warnings or unmapped records above';
    RAISE NOTICE '2. Test web configuration module (admin menu)';
    RAISE NOTICE '3. Test training module functionality';
    RAISE NOTICE '4. Verify all pages load correctly';
    RAISE NOTICE '5. Check application logs for any errors';
    RAISE NOTICE '=============================================================';
END $$;

-- Commit transaction
COMMIT;

-- ============================================================================
-- END OF UPDATE SCRIPT
-- ============================================================================
