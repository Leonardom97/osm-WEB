-- Migration script to change ac_id to use EMPLE_COD from SQL Server
-- This script removes the auto-increment behavior from ac_id column
-- and prepares the table to receive manual ID assignments

-- Step 1: Remove the default nextval from ac_id column
ALTER TABLE adm_colaboradores ALTER COLUMN ac_id DROP DEFAULT;

-- Step 2: Remove the unique constraint on the combination of fields
-- since we now use ac_id as the primary identifier
ALTER TABLE adm_colaboradores DROP CONSTRAINT IF EXISTS unique_colaborador;

-- Step 3: Add a comment to document the change
COMMENT ON COLUMN adm_colaboradores.ac_id IS 'Employee ID from SQL Server TEMPLEADOS.EMPLE_COD - manually assigned, not auto-incremented';

-- Note: Existing records will keep their current ac_id values
-- The sync script will use EMPLE_COD for all future inserts and updates
-- If you need to migrate existing data to match EMPLE_COD values, 
-- you would need to run a data migration separately based on your SQL Server data
