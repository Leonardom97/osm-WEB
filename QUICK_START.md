# 🚀 Quick Start Guide - User Tracking Feature

## ⚡ TL;DR - What's New?

The system now tracks **who creates** and **who edits** training forms. This information is:
- Stored in the database
- Displayed in the edit form
- Shown in the consultation table
- Exported to Excel

## 📋 Installation (One-Time Setup)

### Step 1: Apply Database Migration
Open your PostgreSQL client and run:
```sql
-- Connect to your database first, then run:
\i /path/to/osm-WEB/db/migration_add_tracking_fields.sql
```

**OR** use psql command line:
```bash
psql -h 192.168.125.25 -p 5432 -U formatos -d web_osm -f db/migration_add_tracking_fields.sql
```

✅ You should see: "ALTER TABLE" messages without errors

### Step 2: Verify Migration
```sql
SELECT column_name FROM information_schema.columns 
WHERE table_name = 'cap_formulario' 
AND column_name IN ('creado_por', 'editado_por', 'fecha_creacion', 'fecha_edicion');
```

✅ You should see 4 rows returned

## 🎯 How It Works

### Creating a Form
1. Log in as any user (e.g., "administrador")
2. Go to `/m_capacitaciones/formulario.html`
3. Fill out and save the form
4. ✨ **System automatically records you as the creator**

### Editing a Form
1. Go to `/m_capacitaciones/ed_formulario.html`
2. Click edit button on any form
3. You'll see: 
   ```
   ℹ️ Registro creado por: [original creator]
      Última edición por: [last editor or "No editado"]
   ```
4. Make changes and save
5. ✨ **System automatically records you as the editor**

### Viewing Tracking Info
1. Go to `/m_capacitaciones/Consultas_capacitacion.html`
2. Look at the **last column** "Registrado por"
3. You'll see:
   ```
   Creado por: administrador
   Editado por: Lina
   ```

### Exporting to Excel
1. Click the export button (green download icon)
2. Choose: All, Filtered, or Selected
3. Open the Excel file
4. ✨ **Last two columns show creator and editor**

## 🔍 Quick Test (2 minutes)

### Test 1: Create
```
1. Login as "administrador"
2. Create a form at /m_capacitaciones/formulario.html
3. Note the ID (e.g., "ID: 123")
```

### Test 2: View
```
1. Go to /m_capacitaciones/Consultas_capacitacion.html
2. Find form 123
3. Check "Registrado por" column
4. Should show: "Creado por: administrador"
```

### Test 3: Edit
```
1. Logout and login as different user
2. Go to /m_capacitaciones/ed_formulario.html
3. Edit form 123
4. See tracking info in blue box
5. Save changes
```

### Test 4: Verify
```
1. Check consultation table again
2. Should now show:
   Creado por: administrador
   Editado por: [your username]
```

## 📊 What Gets Tracked?

| Field | Description | When Set |
|-------|-------------|----------|
| `creado_por` | User ID who created the form | On creation |
| `editado_por` | User ID who last edited | On each edit |
| `fecha_creacion` | Creation timestamp | On creation |
| `fecha_edicion` | Last edit timestamp | On each edit |

## 🎨 UI Changes

### Edit Form Modal
**Before:**
```
Capacitación ID 123
[Form fields...]
```

**After:**
```
Capacitación ID 123
ℹ️ Registro creado por: administrador
   Última edición por: Lina
[Form fields...]
```

### Consultation Table
**Before:**
```
| ID | Tema | ... | Asistentes |
| 1  | BPM  | ... | 12         |
```

**After:**
```
| ID | Tema | ... | Asistentes | Registrado por              |
| 1  | BPM  | ... | 12         | Creado por: administrador   |
|    |      |     |            | Editado por: Lina           |
```

### Excel Export
**Before:**
```
id | Capacitador | ... | no aprovados
1  | Juan Pérez  | ... | 2
```

**After:**
```
id | Capacitador | ... | no aprovados | creado por    | editado por
1  | Juan Pérez  | ... | 2            | administrador | Lina
```

## 🐛 Troubleshooting

### "No hay sesión activa" error
**Problem:** Session expired or not logged in  
**Solution:** Log in again

### "No disponible" in tracking column
**Problem:** Form was created before this feature was added  
**Solution:** Edit the form once to add tracking info

### Column not showing in table
**Problem:** Browser cache or page not refreshed  
**Solution:** Hard refresh (Ctrl+F5) or clear cache

### Migration fails
**Problem:** Database connection issue  
**Solution:** Check database credentials in `php/db_postgres.php`

## 📞 Need Help?

1. **Migration issues**: See `db/README_MIGRATION.md`
2. **Testing help**: See `TESTING_GUIDE.md`
3. **Technical details**: See `IMPLEMENTATION_SUMMARY.md`
4. **Visual guides**: See `FLOW_DIAGRAM.md`

## ✅ Checklist

Before considering the feature complete:

- [ ] Database migration applied successfully
- [ ] Can create a form and see creator in consultation table
- [ ] Can edit a form and see editor in consultation table
- [ ] Can see tracking info in edit modal
- [ ] Can export to Excel with creator/editor columns
- [ ] Can filter by creator/editor name
- [ ] Can sort by creator name

## 🎉 Success Criteria

You'll know it's working when:
1. ✅ New forms show creator in "Registrado por" column
2. ✅ Edited forms show both creator and editor
3. ✅ Edit modal displays tracking info in blue box
4. ✅ Excel export includes creator and editor columns
5. ✅ Filtering by creator/editor name works

---

**That's it! You're all set! 🚀**

For detailed documentation, see the other .md files in the repository.
