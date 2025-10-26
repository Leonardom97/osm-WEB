# Deployment Checklist - Training Module Implementation

This checklist ensures all steps are completed before and after deployment to production.

## Pre-Deployment Checklist

### 1. Staging Environment Testing
- [ ] All tests in TESTING_GUIDE_CAP.md executed
- [ ] All 12 tests passed successfully
- [ ] Performance acceptable (recalculation < 10s)
- [ ] No unmapped cedulas or < 1% unmapped
- [ ] Regression tests passed

### 2. Database Preparation
- [ ] Staging database backup created
- [ ] Production database backup created
- [ ] Backup verified (can be restored)
- [ ] Database connection credentials confirmed
- [ ] Database user has necessary permissions

### 3. Code Review
- [ ] formulario_api.php changes reviewed
- [ ] Migration script reviewed
- [ ] Cron job script reviewed
- [ ] No hardcoded credentials in code
- [ ] Error handling adequate
- [ ] Logging statements appropriate

### 4. Documentation
- [ ] IMPLEMENTATION_GUIDE.md reviewed
- [ ] TESTING_GUIDE_CAP.md completed
- [ ] Unmapped cedulas documented
- [ ] Known issues documented
- [ ] Rollback procedure understood

### 5. Stakeholder Communication
- [ ] Deployment window scheduled
- [ ] Stakeholders notified of maintenance window
- [ ] Expected downtime communicated (if any)
- [ ] Rollback criteria defined
- [ ] Support team briefed

## Deployment Steps

### Phase 1: Pre-Deployment (0:00 - 0:10)

**Timing: 10 minutes**

1. **Create backup** (5 min)
   ```bash
   pg_dump -U postgres -d production_db > backup_prod_$(date +%Y%m%d_%H%M%S).sql
   ```
   - [ ] Backup completed
   - [ ] Backup file size verified (> 0 bytes)
   - [ ] Backup file stored in safe location

2. **Verify database connectivity** (2 min)
   ```bash
   psql -U postgres -d production_db -c "SELECT version();"
   ```
   - [ ] Connection successful
   - [ ] PostgreSQL version confirmed

3. **Check current state** (3 min)
   ```bash
   psql -U postgres -d production_db -c "\d cap_formulario_asistente"
   psql -U postgres -d production_db -c "\d cap_notificaciones"
   ```
   - [ ] Current schema documented
   - [ ] Row counts documented

### Phase 2: Database Migration (0:10 - 0:25)

**Timing: 15 minutes**

4. **Apply migration script** (10 min)
   ```bash
   psql -U postgres -d production_db -f db/migration_cap_id_colaborador.sql > migration_output.log 2>&1
   ```
   - [ ] Migration completed without errors
   - [ ] Output log reviewed
   - [ ] Mapping statistics acceptable (>99%)
   - [ ] Indexes created successfully

5. **Verify schema changes** (3 min)
   ```sql
   \d cap_formulario_asistente
   \d cap_notificaciones
   \di idx_cfa_*
   \di idx_notif_*
   ```
   - [ ] id_colaborador column exists
   - [ ] cedula column exists in cap_notificaciones
   - [ ] All 5 indexes created

6. **Generate unmapped report** (2 min)
   ```bash
   psql -U postgres -d production_db -f db/report_unmapped_cedulas.sql > unmapped_report.log 2>&1
   ```
   - [ ] Report generated
   - [ ] Unmapped cedulas reviewed
   - [ ] Action plan for unmapped cedulas created

### Phase 3: Code Deployment (0:25 - 0:35)

**Timing: 10 minutes**

7. **Deploy PHP changes** (5 min)
   ```bash
   git pull origin main
   # Or copy files manually:
   cp m_capacitaciones/assets/php/formulario_api.php /path/to/production/
   ```
   - [ ] formulario_api.php updated
   - [ ] File permissions correct
   - [ ] PHP syntax check passed: `php -l formulario_api.php`

8. **Clear PHP cache** (if applicable) (1 min)
   ```bash
   # Example for OPcache
   systemctl reload php-fpm
   # Or Apache
   systemctl reload apache2
   ```
   - [ ] Cache cleared

9. **Verify web server** (2 min)
   - [ ] Web server running
   - [ ] No errors in error_log
   - [ ] Application accessible

10. **Test endpoint** (2 min)
    ```bash
    # Test that API is responding
    curl -I https://your-domain.com/m_capacitaciones/assets/php/formulario_api.php
    ```
    - [ ] HTTP 200 or expected response
    - [ ] No 500 errors

### Phase 4: Cron Job Setup (0:35 - 0:40)

**Timing: 5 minutes**

11. **Configure cron job** (3 min)
    ```bash
    # Edit crontab
    crontab -e
    # Add line:
    # 5 0 * * * PGPASSWORD=$DB_PASSWORD psql -h localhost -U postgres -d production_db -c "SELECT actualizar_notificaciones_capacitacion();" >> /var/log/cap_notif_recalc.log 2>&1
    ```
    - [ ] Cron job added
    - [ ] Log file path exists and writable
    - [ ] Environment variables set (if needed)

12. **Test cron job** (2 min)
    ```bash
    # Run manually
    /usr/bin/psql -U postgres -d production_db -c "SELECT actualizar_notificaciones_capacitacion();" >> /tmp/test_cron.log 2>&1
    cat /tmp/test_cron.log
    ```
    - [ ] Job executes successfully
    - [ ] Log shows success
    - [ ] No errors

### Phase 5: Smoke Testing (0:40 - 0:55)

**Timing: 15 minutes**

13. **Test programacion module** (5 min)
    - [ ] Navigate to programacion.html
    - [ ] Page loads without errors
    - [ ] Can view existing programmings
    - [ ] Can create new programming
    - [ ] Success message displayed

14. **Test formulario module** (5 min)
    - [ ] Navigate to formulario.html
    - [ ] Page loads without errors
    - [ ] Can add attendees
    - [ ] Form saves successfully
    - [ ] Check response includes mapping info

15. **Verify database updates** (5 min)
    ```sql
    -- Check last form saved
    SELECT * FROM cap_formulario ORDER BY id DESC LIMIT 1;
    
    -- Check attendees have id_colaborador
    SELECT COUNT(*), COUNT(id_colaborador) 
    FROM cap_formulario_asistente 
    WHERE id_formulario = (SELECT MAX(id) FROM cap_formulario);
    
    -- Check notifications updated
    SELECT COUNT(*) FROM cap_notificaciones 
    WHERE fecha_actualizacion > NOW() - INTERVAL '10 minutes';
    ```
    - [ ] Form saved correctly
    - [ ] id_colaborador populated
    - [ ] Notifications updated

### Phase 6: Post-Deployment Verification (0:55 - 1:10)

**Timing: 15 minutes**

16. **Run full test suite** (10 min)
    - [ ] Test 1-5 from TESTING_GUIDE_CAP.md passed
    - [ ] No errors in logs
    - [ ] Performance acceptable

17. **Monitor logs** (5 min)
    ```bash
    # Watch for errors
    tail -f /var/log/php/error.log
    tail -f /var/log/postgresql/postgresql.log
    tail -f /var/log/apache2/error.log  # or nginx
    ```
    - [ ] No new errors
    - [ ] Normal operation confirmed

## Post-Deployment Checklist

### Immediate (Day 0)

18. **Stakeholder notification**
    - [ ] Success notification sent
    - [ ] Known issues communicated
    - [ ] Support contacts shared

19. **Documentation update**
    - [ ] Deployment date/time recorded
    - [ ] Final statistics documented
    - [ ] Issues log started

20. **Monitoring setup**
    - [ ] Error monitoring enabled
    - [ ] Performance monitoring enabled
    - [ ] Alert thresholds configured

### Short-term (Day 1-7)

21. **Daily monitoring**
    - [ ] Day 1: Check logs for errors
    - [ ] Day 2: Review unmapped cedulas
    - [ ] Day 3: Monitor cron job execution
    - [ ] Day 4: Check notification states
    - [ ] Day 5: Review user feedback
    - [ ] Day 6: Performance review
    - [ ] Day 7: Week 1 summary

22. **Address unmapped cedulas**
    - [ ] Review daily report
    - [ ] Correct cedulas in database
    - [ ] Re-run mapping UPDATE
    - [ ] Verify corrections

23. **Verify cron job**
    - [ ] Check daily execution log
    - [ ] Verify notifications update
    - [ ] Confirm no errors

### Medium-term (Week 2-4)

24. **Performance optimization** (if needed)
    - [ ] Review query performance
    - [ ] Add indexes if needed
    - [ ] Optimize recalculation if slow

25. **User training**
    - [ ] Train support staff
    - [ ] Document common issues
    - [ ] Create FAQ

26. **Consider enhancements**
    - [ ] Evaluate need for partial recalculation function
    - [ ] Consider adding foreign keys (if 100% mapped)
    - [ ] Plan future optimizations

## Rollback Criteria

Execute rollback if:
- [ ] >5% of forms fail to save
- [ ] Recalculation takes >30 seconds
- [ ] Critical data loss detected
- [ ] Application unavailable for >15 minutes
- [ ] Database corruption detected

## Rollback Procedure

If rollback needed:

1. **Stop application** (if necessary)
   ```bash
   systemctl stop apache2  # or nginx/php-fpm
   ```

2. **Restore database backup**
   ```bash
   psql -U postgres -d production_db < backup_prod_[timestamp].sql
   ```

3. **Revert code changes**
   ```bash
   git revert [commit-hash]
   git push
   # Or manually restore old file
   cp formulario_api.php.backup m_capacitaciones/assets/php/formulario_api.php
   ```

4. **Remove cron job**
   ```bash
   crontab -e
   # Comment out or remove the training notification line
   ```

5. **Restart application**
   ```bash
   systemctl start apache2
   ```

6. **Verify rollback**
   - [ ] Application accessible
   - [ ] Forms working
   - [ ] Database intact

7. **Notify stakeholders**
   - [ ] Rollback notification sent
   - [ ] Issues documented
   - [ ] Next steps communicated

## Sign-off

### Pre-Deployment
- [ ] Technical Lead: _________________ Date: _______
- [ ] QA Lead: _________________ Date: _______
- [ ] Product Owner: _________________ Date: _______

### Post-Deployment
- [ ] Technical Lead (verified): _________________ Date: _______
- [ ] Operations (verified): _________________ Date: _______
- [ ] Product Owner (accepted): _________________ Date: _______

## Notes

Use this space to document any issues, deviations, or important observations during deployment:

```
[Date/Time] - [Note]
___________________________________________________________
___________________________________________________________
___________________________________________________________
___________________________________________________________
___________________________________________________________
```

## Lessons Learned

Document lessons learned after deployment for future improvements:

```
What went well:
___________________________________________________________

What could be improved:
___________________________________________________________

Action items for next deployment:
___________________________________________________________
```
