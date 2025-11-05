# Implementation Checklist - EMPLE_COD Sync Changes

This checklist should be followed when deploying these changes to production.

## Pre-Deployment

- [ ] **Backup Database**
  ```bash
  pg_dump -U postgres -d osm2 -t adm_colaboradores > backup_adm_colaboradores_$(date +%Y%m%d_%H%M%S).sql
  ```

- [ ] **Review All Changes**
  - [ ] Read `SUMMARY_EMPLE_COD_CHANGES.md`
  - [ ] Read `MIGRATION_EMPLE_COD.md`
  - [ ] Read `TESTING_SYNC_CHANGES.md`

- [ ] **Verify Prerequisites**
  - [ ] PostgreSQL database is accessible
  - [ ] SQL Server database is accessible
  - [ ] `TEMPLEADOS` table has `EMPLE_COD` column
  - [ ] Database user has necessary permissions (ALTER TABLE, INSERT, UPDATE, DELETE)

## Deployment Steps

### Step 1: Code Deployment
- [ ] **Pull Latest Code**
  ```bash
  cd /path/to/osm-WEB
  git checkout copilot/update-data-fetching-filter
  git pull origin copilot/update-data-fetching-filter
  ```

- [ ] **Verify Files**
  ```bash
  ls -la php/funciones_sync.php
  ls -la db/migration_emple_cod.sql
  ```

### Step 2: Database Migration
- [ ] **Apply Migration Script**
  ```bash
  psql -U postgres -d osm2 -f db/migration_emple_cod.sql
  ```

- [ ] **Verify Migration**
  ```sql
  -- Should return NULL
  SELECT column_default FROM information_schema.columns 
  WHERE table_name = 'adm_colaboradores' AND column_name = 'ac_id';
  
  -- Should return 0 rows
  SELECT COUNT(*) FROM information_schema.table_constraints 
  WHERE table_name = 'adm_colaboradores' AND constraint_name = 'unique_colaborador';
  ```

### Step 3: Testing
- [ ] **Syntax Test**
  ```bash
  cd php
  php test_sync_syntax.php
  ```
  Expected: All ✅ checks pass

- [ ] **Dry Run (Optional)**
  - Review what would be synced without actually running
  - Check SQL Server `TEMPLEADOS` data
  - Verify `EMPLE_COD` values are unique and not NULL

- [ ] **First Sync**
  ```bash
  cd php
  php sync_colaboradores.php
  ```

- [ ] **Verify Sync Results**
  ```sql
  -- Check for new records with EMPLE_COD as ac_id
  SELECT ac_id, ac_cedula, ac_nombre1, ac_apellido1, ac_id_situación 
  FROM adm_colaboradores 
  ORDER BY ac_id DESC 
  LIMIT 10;
  
  -- Verify no duplicate ac_id values
  SELECT ac_id, COUNT(*) as count
  FROM adm_colaboradores 
  GROUP BY ac_id 
  HAVING COUNT(*) > 1;
  -- Should return 0 rows
  
  -- Check log file
  tail -50 sync_colaboradores.log
  ```

### Step 4: Validation
- [ ] **Test Employee Lookup**
  ```sql
  -- Pick a known EMPLE_COD from SQL Server
  SELECT * FROM adm_colaboradores WHERE ac_id = <EMPLE_COD>;
  ```

- [ ] **Test Login System**
  - [ ] Test colaborador login with cedula
  - [ ] Verify session is created correctly
  - [ ] Check that foreign key relationships work

- [ ] **Test Update Scenario**
  - [ ] Change an employee's situation in SQL Server
  - [ ] Run sync again
  - [ ] Verify the record was updated (not duplicated)

## Post-Deployment

### Monitoring (First 24 Hours)
- [ ] **Monitor Sync Logs**
  ```bash
  tail -f php/sync_colaboradores.log
  ```

- [ ] **Watch for Errors**
  - [ ] Check PostgreSQL logs
  - [ ] Check application logs
  - [ ] Monitor for user-reported issues

- [ ] **Verify Data Consistency**
  ```sql
  -- Count records in both systems
  -- SQL Server
  SELECT COUNT(*) FROM TEMPLEADOS;
  
  -- PostgreSQL
  SELECT COUNT(*) FROM adm_colaboradores;
  ```

### Data Cleanup (Optional)
- [ ] **Identify Old Duplicate Records**
  ```sql
  -- Find records that might be duplicates from old system
  SELECT ac_cedula, COUNT(*) as count, array_agg(ac_id) as ids
  FROM adm_colaboradores
  GROUP BY ac_cedula
  HAVING COUNT(*) > 1
  ORDER BY count DESC;
  ```

- [ ] **Plan Cleanup Strategy**
  - Keep records with ac_id = EMPLE_COD
  - Archive or delete old records after verifying no data loss

## Rollback Procedure (If Needed)

If critical issues are found:

### 1. Stop Sync Process
```bash
# If running as cron job
crontab -e
# Comment out sync job
```

### 2. Restore Database
```bash
# Restore from backup
psql -U postgres -d osm2 < backup_adm_colaboradores_<timestamp>.sql
```

### 3. Revert Database Changes
```sql
ALTER TABLE adm_colaboradores 
ALTER COLUMN ac_id SET DEFAULT nextval('asistente_id_seq'::regclass);

ALTER TABLE adm_colaboradores 
ADD CONSTRAINT unique_colaborador 
UNIQUE (ac_cedula, ac_id_situación, ac_sub_area, ac_id_cargo, ac_empresa);
```

### 4. Revert Code
```bash
git checkout main
# or
git checkout <previous-commit-hash> -- php/funciones_sync.php
```

## Success Criteria

✅ **Deployment is successful if:**
- [ ] Sync completes without errors
- [ ] No duplicate ac_id values exist
- [ ] New employees are inserted with ac_id = EMPLE_COD
- [ ] Existing employees (where ac_id matches EMPLE_COD) are updated correctly
- [ ] Login system works for colaboradores
- [ ] No foreign key constraint violations
- [ ] Log file shows EMPLE_COD for each processed record

## Communication

### Before Deployment
- [ ] Notify team about deployment window
- [ ] Inform users about potential brief sync downtime

### After Deployment
- [ ] Confirm successful deployment to team
- [ ] Document any issues encountered and resolutions
- [ ] Update team on data cleanup plans (if applicable)

## Notes

**Important Reminders:**
1. Existing records with ac_id ≠ EMPLE_COD will NOT be automatically migrated
2. First sync after migration may take longer as it processes all records
3. Keep backups for at least 30 days
4. Monitor sync performance and adjust if needed

## Support Contacts

**Technical Issues:**
- Database Admin: [Contact Info]
- Backend Developer: [Contact Info]
- DevOps: [Contact Info]

**Questions:**
- Review documentation in repository
- Check `TESTING_SYNC_CHANGES.md` for troubleshooting

---

**Deployment Date:** __________
**Deployed By:** __________
**Sign-off:** __________
