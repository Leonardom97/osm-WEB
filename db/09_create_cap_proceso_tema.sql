-- Migration: Create cap_proceso_tema relationship table
-- Description: This table stores the relationship between processes (cap_proceso) and themes (cap_tema)
-- When a proceso is selected in the training form, only the associated themes will be available

-- Create the table
CREATE TABLE IF NOT EXISTS "public"."cap_proceso_tema" (
  "id" SERIAL PRIMARY KEY,
  "id_proceso" int4 NOT NULL,
  "id_tema" int4 NOT NULL,
  "activo" bool DEFAULT true,
  "fecha_creacion" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "fk_proceso" FOREIGN KEY ("id_proceso") REFERENCES "public"."cap_proceso"("id") ON DELETE CASCADE,
  CONSTRAINT "fk_tema" FOREIGN KEY ("id_tema") REFERENCES "public"."cap_tema"("id") ON DELETE CASCADE,
  CONSTRAINT "unique_proceso_tema" UNIQUE ("id_proceso", "id_tema")
);

-- Add index for better query performance
CREATE INDEX IF NOT EXISTS "idx_cap_proceso_tema_proceso" ON "public"."cap_proceso_tema" ("id_proceso");
CREATE INDEX IF NOT EXISTS "idx_cap_proceso_tema_tema" ON "public"."cap_proceso_tema" ("id_tema");

-- Add comment to table
COMMENT ON TABLE "public"."cap_proceso_tema" IS 'Relationship table between processes and themes for training forms';
COMMENT ON COLUMN "public"."cap_proceso_tema"."id_proceso" IS 'Foreign key to cap_proceso table';
COMMENT ON COLUMN "public"."cap_proceso_tema"."id_tema" IS 'Foreign key to cap_tema table';
COMMENT ON COLUMN "public"."cap_proceso_tema"."activo" IS 'Active status of the relationship';

-- Insert initial data based on requirements
-- Proceso: Administrativo (id=5)
INSERT INTO "public"."cap_proceso_tema" ("id_proceso", "id_tema") VALUES
(5, 30), -- Socialización de procedimiento PQRS
(5, 58), -- Excel
(5, 59), -- Análisis e datos
(5, 63), -- Diseño Web
(5, 66), -- Herramientas de Google
(5, 67), -- Herramientas ofimáticas
(5, 71), -- Mantenimiento de cámaras
(5, 75), -- Power Bi
(5, 77)  -- SAP
ON CONFLICT (id_proceso, id_tema) DO NOTHING;

-- Proceso: Compras y almacén (id=6)
INSERT INTO "public"."cap_proceso_tema" ("id_proceso", "id_tema") VALUES
(6, 76)  -- Rotación de inventario
ON CONFLICT (id_proceso, id_tema) DO NOTHING;
