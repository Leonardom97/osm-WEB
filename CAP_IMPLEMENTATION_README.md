# Training Module Implementation - Quick Start

This README provides a quick overview of the training module implementation with `id_colaborador` mapping.

## 📋 What's Included

This implementation adds the `id_colaborador` column to training tables while maintaining `cedula` for audit purposes. It includes:

- ✅ Database migration script
- ✅ Backend PHP changes for automatic mapping
- ✅ Comprehensive documentation
- ✅ Testing guides
- ✅ Deployment checklists
- ✅ Cron job setup

## 🎯 Key Features

1. **Automatic Collaborator Mapping**: Forms automatically map cedulas to colaborador IDs
2. **Audit Trail**: Original cedula column maintained for audit purposes
3. **Performance**: 5 new indexes for fast queries
4. **Non-destructive**: No data deleted, only columns added
5. **Recalculation**: Automatic notification updates via PHP and daily cron

## 📚 Documentation

| Document | Purpose | When to Use |
|----------|---------|-------------|
| **IMPLEMENTATION_GUIDE.md** | Complete step-by-step implementation instructions | Before deploying |
| **TESTING_GUIDE_CAP.md** | 12 comprehensive manual tests | Testing in staging |
| **DEPLOYMENT_CHECKLIST.md** | Pre/post deployment verification | During deployment |
| **IMPLEMENTATION_SUMMARY_CAP.md** | Executive summary and technical details | Overview and reference |

## 🚀 Quick Start

### Prerequisites

- PostgreSQL database with existing training module
- PHP with PDO extension
- Access to crontab (for scheduling)
- Backup of production database

### Installation Steps

1. **Backup Database**
   ```bash
   pg_dump -U postgres -d your_database > backup_$(date +%Y%m%d).sql
   ```

2. **Run Migration (in STAGING first)**
   ```bash
   psql -U postgres -d staging_db -f db/migration_cap_id_colaborador.sql
   ```

3. **Review Results**
   ```bash
   psql -U postgres -d staging_db -f db/report_unmapped_cedulas.sql
   ```

4. **Deploy PHP Changes**
   ```bash
   # Update formulario_api.php on server
   # File is already modified in this branch
   ```

5. **Setup Cron Job**
   ```bash
   chmod +x db/cron_setup.sh
   ./db/cron_setup.sh
   ```

6. **Test**
   - Follow steps in `TESTING_GUIDE_CAP.md`
   - Verify all 12 tests pass
   - Check logs for errors

7. **Deploy to Production**
   - Follow `DEPLOYMENT_CHECKLIST.md`
   - Estimated time: 1 hour 10 minutes

## 📊 Expected Results

After migration:
- ✅ >99% of cedulas mapped to id_colaborador
- ✅ All forms save attendees with id_colaborador
- ✅ Notifications automatically update
- ✅ Daily cron recalculates states
- ✅ Cedula column preserved for audit

## 🔧 What Changed

### Database
- Added `id_colaborador INTEGER` to `cap_formulario_asistente`
- Added `cedula VARCHAR(255)` to `cap_notificaciones`
- Created 5 new indexes for performance

### Backend
- Modified `formulario_api.php`:
  - Automatic cedula → id_colaborador mapping
  - Logging for unmapped cedulas
  - Audit information in response

### Frontend
- No changes needed (already implemented)

## 📁 File Structure

```
db/
├── migration_cap_id_colaborador.sql    # Main migration script
├── cron_setup.sh                       # Cron job setup helper
└── report_unmapped_cedulas.sql         # Diagnostic queries

m_capacitaciones/assets/php/
└── formulario_api.php                  # Modified for id_colaborador mapping

Documentation/
├── IMPLEMENTATION_GUIDE.md             # Detailed implementation steps
├── TESTING_GUIDE_CAP.md               # Testing procedures
├── DEPLOYMENT_CHECKLIST.md            # Deployment verification
└── IMPLEMENTATION_SUMMARY_CAP.md      # Technical summary
```

## ✅ Acceptance Criteria

All 6 acceptance criteria from the problem statement are met:

| AC | Description | Status |
|----|-------------|--------|
| AC1 | programacion_save triggers recalculation | ✅ Implemented |
| AC2 | formulario_save populates id_colaborador >99% | ✅ Implemented |
| AC3 | cap_notificaciones updates correctly | ✅ Implemented |
| AC4 | Cron daily updates states | ✅ Implemented |
| AC5 | Excel import without duplicates | ✅ Implemented |
| AC6 | cedula column never deleted | ✅ Implemented |

## 🔍 Key SQL Queries

### Check Mapping Status
```sql
SELECT 
  COUNT(*) as total,
  COUNT(id_colaborador) as mapped,
  ROUND(COUNT(id_colaborador)::NUMERIC / COUNT(*) * 100, 2) as pct_mapped
FROM cap_formulario_asistente;
```

### List Unmapped Cedulas
```sql
SELECT cedula, COUNT(*) as occurrences
FROM cap_formulario_asistente
WHERE id_colaborador IS NULL
GROUP BY cedula
ORDER BY occurrences DESC;
```

### Check Notification States
```sql
SELECT estado, COUNT(*) 
FROM cap_notificaciones 
GROUP BY estado;
```

### Verify Recent Updates
```sql
SELECT COUNT(*) 
FROM cap_notificaciones 
WHERE fecha_actualizacion > NOW() - INTERVAL '1 day';
```

## 🐛 Troubleshooting

### Unmapped Cedulas

**Problem**: Some cedulas don't map to id_colaborador

**Solution**:
1. Run `report_unmapped_cedulas.sql` to identify
2. Check for formatting differences (dots, spaces)
3. Correct in `adm_colaboradores` or `cap_formulario_asistente`
4. Re-run UPDATE statement from migration

### Slow Recalculation

**Problem**: `actualizar_notificaciones_capacitacion()` takes >10 seconds

**Solution**:
1. Verify indexes are created: `\di idx_*`
2. Run `ANALYZE` on tables
3. Check data volume
4. Consider partial recalculation (future enhancement)

### Form Save Errors

**Problem**: Forms fail to save with attendees

**Solution**:
1. Check PHP error log: `tail -f /var/log/php/error.log`
2. Verify `id_colaborador` column exists
3. Check database connection
4. Verify PostgreSQL version supports `regexp_replace`

## 📝 Logs to Monitor

After deployment, monitor these logs:

```bash
# PHP errors (unmapped cedulas)
tail -f /var/log/php/error.log | grep "Cedula not found"

# Cron execution
tail -f /var/log/cap_notif_recalc.log

# PostgreSQL
tail -f /var/log/postgresql/postgresql-*.log

# Web server
tail -f /var/log/apache2/error.log  # or nginx/error.log
```

## 🔄 Rollback

If issues occur, rollback using:

```bash
# Restore database
psql -U postgres -d your_database < backup_YYYYMMDD.sql

# Or use rollback script (at end of migration_cap_id_colaborador.sql)
```

## 🎓 Training

For team members:
1. Read `IMPLEMENTATION_GUIDE.md` for overview
2. Review `formulario_api.php` changes
3. Understand mapping logic
4. Know how to read logs
5. Practice with `report_unmapped_cedulas.sql`

## 📞 Support

### Common Questions

**Q: Will existing data be affected?**
A: No. Migration only adds columns and doesn't delete or modify existing data.

**Q: What happens if a cedula can't be mapped?**
A: It's saved with `id_colaborador = NULL` and logged for review.

**Q: Do I need to update the frontend?**
A: No. Frontend is already implemented and compatible.

**Q: How do I fix unmapped cedulas?**
A: Run the report query, identify issues, correct the data, and re-run the UPDATE statement.

**Q: Can I add foreign keys?**
A: Yes, but only after achieving 100% mapping and QA approval. Instructions are in the migration script (commented out).

### Getting Help

1. Check logs first
2. Review documentation
3. Run diagnostic queries
4. Check GitHub issues
5. Contact database administrator

## 🏁 Success Criteria

Deployment is successful when:
- ✅ Migration completes without errors
- ✅ Mapping percentage >99%
- ✅ Forms save successfully
- ✅ Notifications update correctly
- ✅ Cron job executes daily
- ✅ No critical errors in logs
- ✅ All tests pass

## 📅 Maintenance

### Daily (Week 1)
- Check error logs
- Review unmapped cedulas
- Verify cron execution
- Monitor form saves

### Weekly
- Review mapping statistics
- Correct unmapped cedulas
- Monitor performance
- User feedback review

### Monthly
- Performance optimization review
- Consider adding foreign keys
- Plan enhancements

## 🔐 Security

- No credentials in code
- Cedulas maintained for audit
- Logging includes warnings only (no sensitive data)
- Database backups required
- Rollback procedure documented

## 📈 Metrics

Track these metrics post-deployment:
- Mapping percentage (target: >99%)
- Form save success rate (target: 100%)
- Recalculation time (target: <10s)
- Unmapped cedula rate (target: decreasing)
- User satisfaction (target: no complaints)

## 🎉 Summary

This implementation provides:
- ✅ Clean, maintainable code
- ✅ Non-destructive changes
- ✅ Comprehensive documentation
- ✅ Testing procedures
- ✅ Deployment guidelines
- ✅ Rollback capability
- ✅ Performance optimization
- ✅ Audit trail preservation

Ready for staging testing and production deployment! 🚀

---

**Last Updated**: 2025-10-26  
**Version**: 1.0  
**Status**: Ready for Deployment
