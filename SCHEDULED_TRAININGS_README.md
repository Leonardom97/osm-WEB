# Scheduled Trainings Feature - README

## Overview

This feature implements automatic training scheduling and next date calculation based on training frequency. When a training form is completed, the system automatically calculates when the next training should occur for each attendee.

### NEW: 7-Day Trainer Notification System

The system now includes a proactive notification system for trainers:

- **Trainer Alerts**: Trainers see a prominent alert banner on the `programacion.html` page showing all trainings expiring within 7 days
- **Visual Indicators**: Color-coded badges (red=expired, yellow=<3 days, blue=<7 days) show urgency
- **Next Training Dates**: The programming table shows when each training is scheduled next
- **Pending Collaborators**: Shows count of collaborators who need each training
- **Automatic Updates**: The `actualizar_notificaciones_capacitacion()` function runs after each training form is saved

## What's New

### 1. Sub Área Dropdown (programacion.html)
- **Before:** Text input field (manual typing)
- **After:** Dropdown populated from database
- **Benefit:** Eliminates typos, ensures data consistency

### 2. Automatic Next Date Calculation (formulario_api.php)
- **Before:** Manual tracking of training dates
- **After:** Automatic calculation when forms are saved
- **Formula:** `next_date = last_training_date + frequency_months`
- **Benefit:** No manual date tracking required

### 3. Programadas Tab (Usuarios.html)
- **Before:** Only "Pendientes" and "Realizadas" tabs
- **After:** New "Programadas" tab added
- **Shows:**
  - Training topic and sub-area
  - Last training date
  - Next scheduled date
  - Training frequency
  - Status with color badges
  - Responsible trainer

## Quick Start

### For Administrators

1. **Create Training Programs:**
   - Go to `programacion.html`
   - Click "Nueva Programación"
   - Select:
     - Cargo (position)
     - Sub Área (from dropdown - no typing!)
     - Tema (training topic)
     - Frecuencia (frequency in months)
     - Rol Capacitador (responsible trainer)
   - Save

2. **Result:**
   - System creates programming entry
   - All employees with matching cargo+sub_area get notifications
   - Notifications show "Pendiente" status until first training

### For Trainers

1. **Record Completed Training:**
   - Go to `formulario.html`
   - Fill in training details
   - Add attendees
   - Save form

2. **What Happens Automatically:**
   - System finds all attendees
   - For each attendee with matching programming:
     - Updates `fecha_ultima_capacitacion` to today
     - Calculates `fecha_proxima` = today + frequency
     - Updates status based on next date
   - Notifications updated in real-time

### For Employees

1. **View Your Scheduled Trainings:**
   - Go to `Usuarios.html`
   - Click "Programadas" tab
   - See all your scheduled trainings with:
     - When you last completed it
     - When you need to do it again
     - How often it repeats
     - Current status

2. **Understand Status Badges:**
   - 🟢 **Vigente** (Green) - Training is current, next date is far away
   - 🟡 **Próxima a vencer** (Yellow) - Training due within 30 days
   - 🔴 **Vencida** (Red) - Training is overdue
   - 🔵 **Pendiente** (Blue) - Never completed, needs first training

## Technical Details

### Database Tables Used

```sql
-- Programming entries (defined by admins)
cap_programacion
├─ id_cargo (position)
├─ sub_area (department)
├─ id_tema (training topic)
├─ frecuencia_meses (frequency in months)
└─ id_rol_capacitador (responsible trainer)

-- Notification entries (calculated automatically)
cap_notificaciones
├─ id_colaborador (employee)
├─ id_programacion (links to programming)
├─ fecha_ultima_capacitacion (last completion date)
├─ fecha_proxima (next scheduled date) ← CALCULATED!
├─ dias_para_vencimiento (days until due)
└─ estado (status: vigente/proximo_vencer/vencida/pendiente)

-- Completed trainings (recorded by trainers)
cap_formulario
├─ id_tema (training topic)
├─ fecha (completion date)
└─ (linked to attendees via cap_formulario_asistente)
```

### Calculation Logic

When a training form is saved:

```javascript
FOR EACH attendee IN form:
  FOR EACH programming WHERE matches(attendee.cargo, attendee.sub_area, form.tema):
    
    // Find last completion date
    last_date = MAX(fecha FROM cap_formulario WHERE tema = programming.tema AND attendee IN asistentes)
    
    // Calculate next date
    IF last_date IS NULL:
      next_date = TODAY
      status = 'pendiente'
    ELSE:
      next_date = last_date + programming.frecuencia_meses
      
      IF next_date < TODAY:
        status = 'vencida'
      ELSE IF next_date <= TODAY + 30 days:
        status = 'proximo_vencer'
      ELSE:
        status = 'vigente'
    END IF
    
    // Update notification
    UPDATE cap_notificaciones
    SET fecha_ultima_capacitacion = last_date,
        fecha_proxima = next_date,
        estado = status
    WHERE colaborador = attendee AND programacion = programming
END FOR
```

### API Endpoints

#### GET /programacion_api.php?action=get_sub_areas
- **Returns:** All unique sub_area values from adm_área table
- **Used by:** programacion.html to populate dropdown
- **Authentication:** Requires active session

#### GET /progreso_api.php?action=get_scheduled_trainings
- **Returns:** All scheduled trainings for current user
- **Response:** JSON array with training details and next dates
- **Used by:** Usuarios.html - Programadas tab
- **Authentication:** Requires active session

#### POST /formulario_api.php?action=save_formulario
- **Action:** Saves training form
- **Side Effect:** Triggers `actualizar_notificaciones_capacitacion()`
- **Result:** Updates all affected notification dates
- **Authentication:** Requires active session

### Database Function

```sql
actualizar_notificaciones_capacitacion()
```

This PostgreSQL function:
1. Finds all collaborator+programming combinations
2. Calculates next training date for each
3. Updates cap_notificaciones table
4. Is called automatically when forms are saved

## File Changes

### Modified Files (7 total):

1. **Usuarios.html**
   - Added "Programadas" tab
   - Added `scheduledTrainingsContainer` div

2. **assets/js/user_trainings.js**
   - Added `loadScheduledTrainings()` function
   - Calls new API endpoint
   - Renders table with scheduled trainings

3. **m_capacitaciones/programacion.html**
   - Changed Sub Área from `<input>` to `<select>`

4. **m_capacitaciones/assets/js/programacion.js**
   - Added `subAreas` array
   - Load sub areas from API
   - Populate dropdown on page load
   - Removed dynamic cargo-based loading

5. **m_capacitaciones/assets/php/programacion_api.php**
   - Modified `get_sub_areas` endpoint
   - Now returns all sub areas (no cargo filter)

6. **m_capacitaciones/assets/php/formulario_api.php**
   - Added call to `actualizar_notificaciones_capacitacion()`
   - Triggered after saving form

7. **m_capacitaciones/assets/php/progreso_api.php**
   - Added `get_scheduled_trainings` endpoint
   - Returns scheduled trainings with calculated dates

## Testing

### Test Scenario 1: Sub Área Dropdown

1. Open `programacion.html`
2. Click "Nueva Programación"
3. Verify Sub Área is a dropdown
4. Verify it contains values like:
   - MANTENIMIENTO INDUSTRIAL
   - ALMACEN
   - COMPRAS
   - CLIPA - SISTEMAS
   - etc.
5. Select a value and save
6. ✅ Should save successfully

### Test Scenario 2: Automatic Date Calculation

**Setup:**
- Create programming: Seguridad Industrial, every 12 months
- Employee: Juan Pérez (has matching cargo+sub_area)

**Test:**
1. Create training form for Seguridad Industrial
2. Date: 2025-10-23
3. Add Juan Pérez as attendee
4. Save form
5. ✅ Form saves successfully

**Verify:**
1. Check database: `SELECT * FROM cap_notificaciones WHERE id_colaborador = Juan's ID`
2. Should show:
   - `fecha_ultima_capacitacion`: 2025-10-23
   - `fecha_proxima`: 2026-10-23 (12 months later)
   - `estado`: 'vigente'
3. ✅ Dates calculated correctly

### Test Scenario 3: Programadas Tab

**Setup:** Same as Scenario 2

**Test:**
1. Login as Juan Pérez
2. Open `Usuarios.html`
3. Click "Programadas" tab
4. ✅ Should see:
   - Training: Seguridad Industrial
   - Last: 23/10/2025
   - Next: 23/10/2026
   - Frequency: Cada 12 meses
   - Status: Vigente (green badge)

**Test Status Changes:**

1. **Simulate date: 2026-09-20** (35 days before due)
   - Status should be: Próxima a vencer (yellow)
   
2. **Simulate date: 2026-10-24** (1 day after due)
   - Status should be: Vencida (red)

## Troubleshooting

### Issue: Sub Área dropdown is empty

**Cause:** No data in adm_área table or API error

**Fix:**
1. Check database: `SELECT COUNT(*) FROM adm_área WHERE sub_area IS NOT NULL`
2. Check browser console for API errors
3. Verify endpoint: `/m_capacitaciones/assets/php/programacion_api.php?action=get_sub_areas`

### Issue: Next dates not calculating

**Cause:** Function not triggered or database error

**Fix:**
1. Check if function exists: 
   ```sql
   SELECT proname FROM pg_proc WHERE proname = 'actualizar_notificaciones_capacitacion'
   ```
2. Check PHP error logs
3. Manually call function: `SELECT actualizar_notificaciones_capacitacion()`

### Issue: Programadas tab shows no data

**Causes:**
1. No programming entries for user
2. User session issue
3. API error

**Fix:**
1. Verify user has programming:
   ```sql
   SELECT * FROM cap_notificaciones WHERE id_colaborador = (
     SELECT ac_id FROM adm_colaboradores WHERE ac_cedula = 'USER_CEDULA'
   )
   ```
2. Check browser console for errors
3. Verify API endpoint returns data

## Maintenance

### Regular Tasks

1. **Monitor Overdue Trainings:**
   ```sql
   SELECT COUNT(*) FROM cap_notificaciones WHERE estado = 'vencida'
   ```

2. **Update Notification Dates Manually (if needed):**
   ```sql
   SELECT actualizar_notificaciones_capacitacion()
   ```

3. **View Programming Coverage:**
   ```sql
   SELECT 
     c.cargo,
     p.sub_area,
     t.nombre,
     COUNT(DISTINCT col.ac_id) as affected_employees
   FROM cap_programacion p
   JOIN adm_cargos c ON p.id_cargo = c.id_cargo
   JOIN cap_tema t ON p.id_tema = t.id
   LEFT JOIN adm_colaboradores col ON col.ac_id_cargo = p.id_cargo 
     AND (p.sub_area IS NULL OR col.ac_sub_area = p.sub_area)
   WHERE p.activo = true AND col.ac_id_situación IN ('A', 'V', 'P')
   GROUP BY c.cargo, p.sub_area, t.nombre
   ```

## Performance Considerations

- Function `actualizar_notificaciones_capacitacion()` runs on every form save
- For large datasets, may take a few seconds
- Runs in transaction with form save (rollback on error)
- No manual optimization needed

## Security

✅ **All endpoints verified:**
- Session validation required
- SQL injection protection via prepared statements
- No direct user input to database
- Authorization checks in place

## Support

For issues or questions:
1. Check FINAL_SUMMARY.md for testing checklist
2. Check DATA_FLOW_DIAGRAM.md for system architecture
3. Check USER_EXPERIENCE.md for user-facing examples
4. Review PHP error logs
5. Check browser console for JavaScript errors

## Version History

- **2025-10-23**: Initial implementation
  - Sub Área dropdown
  - Automatic date calculation
  - Programadas tab
  - Complete documentation

- **2025-10-23 (Update)**: Trainer Notification System
  - Added 7-day advance warning system for trainers
  - Trainer alerts displayed on programacion.html
  - Next training dates shown in programming table
  - Pending collaborators count for each training
  - Color-coded urgency indicators (red/yellow/blue)
  - Enhanced notification API with `get_trainer_alerts` endpoint
  - Improved notification function to properly track completed trainings

## Trainer Notification Flow

### How It Works

1. **Training Completion**:
   - When Alba creates a training form in `formulario.html`
   - The `actualizar_notificaciones_capacitacion()` function runs
   - System calculates next training date = last_training_date + frequency_months
   - Notifications created for all matching collaborators (by cargo + sub_area)

2. **7-Day Advance Warning**:
   - Trainers see alerts 7 days before training expires
   - Alert banner appears at top of `programacion.html`
   - Shows: tema, cargo, sub_area, days remaining, pending count
   - Color-coded by urgency:
     - 🔴 Red: Expired trainings (negative days)
     - 🟡 Yellow: Expiring in 3 days or less
     - 🔵 Blue: Expiring within 7 days

3. **Programming Table Enhancements**:
   - **Próxima Capacitación** column: Shows next training date
   - **Pendientes** column: Count of collaborators needing training
   - Date badges show urgency with colors
   - Helps trainers plan and prioritize

4. **Notification Updates**:
   - Run automatically after each training form save
   - Can be manually triggered via API: `programacion_api.php?action=update_notifications`
   - Updates all notification states: pendiente, proximo_vencer, vencida, vigente

### API Endpoints

#### For Trainers
- `notificaciones_api.php?action=get_trainer_alerts`
  - Returns trainings expiring in 7 days or less
  - Filtered by trainer's role
  - Grouped by programming (unique trainings)
  - Includes pending collaborator count

#### For Programming Table
- `programacion_api.php?action=list`
  - Returns all active programming
  - Includes next training date for each
  - Includes days until next training
  - Includes count of pending collaborators

### Example Scenario

**Alba (Capacitador MT)** creates a programming:
- Cargo: Polinizador
- Sub_area: Producción Agrícola
- Tema: Seguridad Industrial
- Frecuencia: 12 meses
- Rol: Capacitador_MT

**On 2024-10-23**, Alba creates a training form for this topic.

**Results**:
- Lina (Polinizador, Producción Agrícola) receives the training
- System records: fecha_ultima_capacitacion = 2024-10-23
- System calculates: fecha_proxima = 2025-10-23 (12 months later)
- Lina sees in her panel: "Próxima capacitación: 23/10/2025"

**On 2025-10-16** (7 days before):
- Alba sees alert on programacion.html:
  - "Seguridad Industrial - Polinizador (Producción Agrícola)"
  - "Vence en 7 días - 1 colaborador(es) pendiente(s)"
- Alba can plan to call Lina for the upcoming training

**After the training**:
- Alba creates new training form on 2025-10-23
- System updates: fecha_proxima = 2026-10-23
- Notification resets for next cycle

## License

Part of OSM-WEB system. Internal use only.
