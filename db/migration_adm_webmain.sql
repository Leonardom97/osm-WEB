-- Migration for Web Configuration Management (PostgreSQL 9+ compatible)
-- Date: 2025-10-28
-- Purpose: Create table for managing website configuration (title, footer, icons, theme colors)
-- Notes: Uses traditional sequences for PostgreSQL 9 compatibility
-- Compatible with: Navicat, pgAdmin, psql
-- Target: PostgreSQL 9.x and higher

BEGIN;

-- Drop existing objects if present
DROP TRIGGER IF EXISTS trg_adm_webmain_updated_at ON public.adm_webmain;
DROP FUNCTION IF EXISTS public.trigger_set_updated_at() CASCADE;
DROP TABLE IF EXISTS public.adm_webmain CASCADE;

-- Create sequence for id column (PostgreSQL 9 compatible)
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

-- Insert default configuration row (if desired)
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

COMMIT;
