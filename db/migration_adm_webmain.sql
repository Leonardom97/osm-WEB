-- Migration for Web Configuration Management
-- Date: 2025-10-26
-- Purpose: Create table for managing website configuration (title, footer, icons, theme colors)

-- Create sequence for adm_webmain
DROP SEQUENCE IF EXISTS "public"."adm_webmain_id_seq";
CREATE SEQUENCE "public"."adm_webmain_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- Create table adm_webmain
DROP TABLE IF EXISTS "public"."adm_webmain";
CREATE TABLE "public"."adm_webmain" (
  "id" int4 NOT NULL DEFAULT nextval('adm_webmain_id_seq'::regclass),
  "site_title" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'OSM',
  "footer_text" varchar(200) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '© OSM 2025',
  "favicon_path" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'assets/img/Sin título-2.png',
  "login_image_path" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'assets/img/ico.jpg',
  "primary_color" varchar(7) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '#772e22',
  "is_active" boolean NOT NULL DEFAULT true,
  "theme_name" varchar(50) COLLATE "pg_catalog"."default",
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert default configuration
INSERT INTO "public"."adm_webmain" ("site_title", "footer_text", "favicon_path", "login_image_path", "primary_color", "is_active", "theme_name") 
VALUES ('OSM', '© OSM 2025', 'assets/img/Sin título-2.png', 'assets/img/ico.jpg', '#772e22', true, 'Default');

-- Add primary key
ALTER TABLE "public"."adm_webmain" ADD CONSTRAINT "adm_webmain_pkey" PRIMARY KEY ("id");

-- Add comment to table
COMMENT ON TABLE "public"."adm_webmain" IS 'Web configuration management table for site-wide settings';

-- Create index for active configuration
CREATE INDEX idx_adm_webmain_active ON "public"."adm_webmain" ("is_active");
