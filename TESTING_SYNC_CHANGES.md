# Testing Guide for EMPLE_COD Sync Changes

## ⚠️ Important Limitation

**Existing Data**: Records already in PostgreSQL with `ac_id` values that don't match their corresponding `EMPLE_COD` will NOT be automatically migrated. The sync will only update records where `ac_id` matches the `EMPLE_COD` from SQL Server. New employees will be inserted correctly with `ac_id = EMPLE_COD`.

If you need to migrate existing data, plan for manual data cleanup or a separate migration script.

## Prerequisites

Before testing the sync changes, ensure:

1. ✅ PostgreSQL database is accessible
2. ✅ SQL Server database is accessible with the TEMPLEADOS table
3. ✅ Database migration script has been applied (`db/migration_emple_cod.sql`)
4. ✅ Backup of the `adm_colaboradores` table exists (recommended)

## Test Plan

### 1. Syntax Validation (Completed ✅)

```bash
cd /home/runner/work/osm-WEB/osm-WEB/php
php test_sync_syntax.php
```

**Expected Results:**
- All functions exist
- No syntax errors
- getInsertSQL function is removed

**Status:** ✅ PASSED

### 2. Database Migration Test

Before running sync, apply the migration:

```bash
psql -U postgres -d osm2 -f /path/to/db/migration_emple_cod.sql
```

**Verify Migration:**

```sql
-- Should show NULL (no default)
SELECT column_default 
FROM information_schema.columns 
WHERE table_name = 'adm_colaboradores' AND column_name = 'ac_id';

-- Should return no rows (constraint removed)
SELECT constraint_name 
FROM information_schema.table_constraints 
WHERE table_name = 'adm_colaboradores' AND constraint_name = 'unique_colaborador';
```

### 3. First Sync Test (INSERT)

**Test Case:** Insert a new employee that doesn't exist in PostgreSQL

**Steps:**
1. Identify an EMPLE_COD from SQL Server that doesn't exist in PostgreSQL
2. Run sync: `php php/sync_colaboradores.php`
3. Verify the record was inserted with `ac_id = EMPLE_COD`

**Verification Query:**
```sql
-- Replace 12345 with actual EMPLE_COD
SELECT ac_id, ac_cedula, ac_nombre1, ac_apellido1, ac_id_situación 
FROM adm_colaboradores 
WHERE ac_id = 12345;
```

**Expected Results:**
- Record exists with ac_id matching EMPLE_COD
- All fields populated correctly
- Log entry created in `php/sync_colaboradores.log`

### 4. Update Test (UPDATE)

**Test Case:** Update an existing employee's information

**Steps:**
1. Note current values for an existing employee
2. Modify data in SQL Server TEMPLEADOS table (e.g., change SITUACION)
3. Run sync: `php php/sync_colaboradores.php`
4. Verify changes were applied

**Verification Query:**
```sql
-- Replace 12345 with actual EMPLE_COD
SELECT ac_id, ac_cedula, ac_nombre1, ac_apellido1, ac_id_situación, ac_id_cargo, ac_empresa
FROM adm_colaboradores 
WHERE ac_id = 12345;
```

**Expected Results:**
- Record updated with new values
- ac_id remains the same
- ac_cedula and name fields updated if changed
- Situación, cargo, empresa updated if changed

### 5. Multiple Records Test

**Test Case:** Sync multiple employees with different situations

**Steps:**
1. Run full sync: `php php/sync_colaboradores.php`
2. Count records before and after sync
3. Check log file for processing messages

**Verification Queries:**
```sql
-- Count total records
SELECT COUNT(*) FROM adm_colaboradores;

-- Check for duplicates by EMPLE_COD (should be 0)
SELECT ac_id, COUNT(*) 
FROM adm_colaboradores 
GROUP BY ac_id 
HAVING COUNT(*) > 1;

-- Verify different situations are handled
SELECT ac_id_situación, COUNT(*) 
FROM adm_colaboradores 
GROUP BY ac_id_situación 
ORDER BY ac_id_situación;
```

**Expected Results:**
- All employees from TEMPLEADOS exist in PostgreSQL
- No duplicate ac_id values
- Log shows all employees processed

### 6. Edge Cases

#### 6.1 Employee with Multiple Situation Changes

**Test Case:** Employee that changes from Active (A) to Egresado (E)

**Expected Behavior:**
- Same ac_id is updated
- ac_id_situación changes from 'A' to 'E'
- No new record is created

#### 6.2 Employee with Cargo Change

**Test Case:** Employee that changes position (CARGO)

**Expected Behavior:**
- Same ac_id is updated
- ac_id_cargo updates to new cargo
- ac_rango updates based on new cargo

#### 6.3 Employee with Empresa Change

**Test Case:** Employee that moves to different company

**Expected Behavior:**
- Same ac_id is updated
- ac_empresa changes to new company
- No duplicate records

### 7. Performance Test

**Test Case:** Measure sync performance with full dataset

**Steps:**
1. Clear sync log: `> php/sync_colaboradores.log`
2. Run sync with time measurement:
   ```bash
   time php php/sync_colaboradores.php
   ```
3. Review log file for any errors

**Success Criteria:**
- Sync completes without errors
- All records processed
- Reasonable execution time (depends on dataset size)

### 8. Log Verification

**Check sync log file:**
```bash
cat php/sync_colaboradores.log | tail -20
```

**Expected Log Format:**
```
[2025-01-15 10:30:45] Procesado: EMPLE_COD=12345, Cedula=1234567890 - JUAN PEREZ (A)
```

**Verify:**
- ✅ EMPLE_COD is logged for each record
- ✅ Cedula and name information is present
- ✅ Situación code is shown
- ✅ No error messages

## Rollback Procedure

If tests fail and you need to rollback:

### 1. Revert Database Changes

```sql
-- Restore auto-increment
ALTER TABLE adm_colaboradores 
ALTER COLUMN ac_id SET DEFAULT nextval('asistente_id_seq'::regclass);

-- Restore unique constraint
ALTER TABLE adm_colaboradores 
ADD CONSTRAINT unique_colaborador 
UNIQUE (ac_cedula, ac_id_situación, ac_sub_area, ac_id_cargo, ac_empresa);
```

### 2. Revert Code Changes

```bash
cd /home/runner/work/osm-WEB/osm-WEB
git checkout HEAD~1 -- php/funciones_sync.php
```

### 3. Restore Data (if needed)

```bash
# Restore from backup
psql -U postgres -d osm2 < backup_adm_colaboradores.sql
```

## Test Results Checklist

- [ ] Syntax validation passed
- [ ] Database migration applied successfully
- [ ] New employee INSERT works correctly
- [ ] Existing employee UPDATE works correctly
- [ ] Multiple records sync successfully
- [ ] No duplicate ac_id values created
- [ ] Edge cases handled properly (situation/cargo/empresa changes)
- [ ] Log file shows correct format with EMPLE_COD
- [ ] Performance is acceptable
- [ ] Foreign key references still work
- [ ] Login system still works for colaboradores

## Known Limitations

1. **Existing Data**: Records already in PostgreSQL with different ac_id values will not be automatically migrated. They will only be updated if their ac_id happens to match an EMPLE_COD.

2. **Historical Records**: If you need to preserve historical records with different situations, you may need a different approach (e.g., a history table).

3. **Data Cleanup**: Old duplicate records created by the previous correlation logic won't be automatically removed.

## Troubleshooting

### Issue: "Duplicate key value violates unique constraint"

**Cause:** Primary key conflict on ac_id

**Solution:** Check if EMPLE_COD already exists in PostgreSQL with different data

### Issue: "null value in column ac_id violates not-null constraint"

**Cause:** EMPLE_COD is NULL in SQL Server

**Solution:** Check SQL Server data quality, ensure all TEMPLEADOS records have EMPLE_COD

### Issue: "Column EMPLE_COD does not exist"

**Cause:** SQL Server column name mismatch

**Solution:** Verify the exact column name in TEMPLEADOS table (case-sensitive)

## Support

For issues or questions:
1. Check the log file: `php/sync_colaboradores.log`
2. Verify database connectivity
3. Review the migration documentation: `MIGRATION_EMPLE_COD.md`
