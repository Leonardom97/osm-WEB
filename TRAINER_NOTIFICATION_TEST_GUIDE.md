# Trainer Notification System - Test Guide

## Prerequisites
1. Database migration applied: `db/migration_training_scheduling.sql`
2. At least one trainer account (e.g., with role "Capacitador_MT")
3. At least one collaborator account with:
   - Position (ac_id_cargo)
   - Sub-area (ac_sub_area)
   - Active status (ac_id_situación = 'A', 'V', or 'P')

## Test Scenario Setup

### Users for Testing:
- **Alba**: Trainer with role "Capacitador_MT"
- **Lina**: Collaborator with:
  - Cargo: Polinizador (ID: 117)
  - Sub_area: Producción Agrícola
  - Status: Active

## Test 1: Create Training Programming

### Steps:
1. **Login as Alba (Trainer)**
   - Go to login page
   - Enter credentials for trainer account
   - Navigate to "Programación de Capacitaciones" (programacion.html)

2. **Create New Programming:**
   - Click "Nueva Programación" button
   - Fill in form:
     - Cargo: Polinizador (or any cargo matching Lina's)
     - Sub Área: Producción Agrícola (or matching Lina's sub_area)
     - Tema: Seguridad Industrial (or any topic)
     - Frecuencia: 12 months
     - Rol Capacitador: Capacitador_MT (Alba's role)
   - Click "Guardar"

3. **Verify Programming Created:**
   - Programming appears in table
   - Table shows:
     - Cargo, Sub Área, Tema, Frequency
     - Rol Capacitador badge (blue)
     - "Próxima Capacitación" column (should show date or "-")
     - "Pendientes" column (should show count or "0")

### Expected Results:
✅ Programming created successfully
✅ System creates notifications for matching collaborators (Lina)
✅ Table displays with new columns

---

## Test 2: Create Training Form (Initial Training)

### Steps:
1. **Login as Alba (Trainer)**
   - Navigate to "Capacitación" form (formulario.html)

2. **Fill Training Form:**
   - Proceso: Select a process
   - Lugar: Select a location
   - Responsable: Alba's cedula
   - Tipo Actividad: Select activity type
   - Tema: Seguridad Industrial (same as programming)
   - Fecha: Today's date (e.g., 2024-10-23)
   - Hora inicio/final: Any times
   - Add Lina as attendee (search by cedula)
   - Estado aprovación: aprobo

3. **Save Form:**
   - Click save button
   - Wait for success message

4. **Verify Notification Update:**
   - Go back to "Programación de Capacitaciones" (programacion.html)
   - Check the programming row:
     - "Próxima Capacitación" should show date 12 months from today
     - "Pendientes" should show "0" or reduced count

### Expected Results:
✅ Form saved successfully
✅ `actualizar_notificaciones_capacitacion()` function runs
✅ Lina's notification updated with:
  - fecha_ultima_capacitacion = 2024-10-23
  - fecha_proxima = 2025-10-23 (12 months later)
  - estado = 'vigente' (if > 30 days away)
✅ Programming table shows next training date
✅ Pending count updated

---

## Test 3: View 7-Day Alert (Simulated)

**Note:** This test requires either:
- Manually adjusting dates in the database, OR
- Waiting until 7 days before a real expiration, OR
- Creating a test programming with 1-month frequency

### Option A: Manual Database Adjustment (For Testing)

1. **Update notification date (SQL):**
   ```sql
   UPDATE cap_notificaciones 
   SET fecha_proxima = CURRENT_DATE + INTERVAL '5 days',
       dias_para_vencimiento = 5,
       estado = 'proximo_vencer'
   WHERE id_programacion IN (
     SELECT id FROM cap_programacion WHERE id_rol_capacitador = [Alba's role ID]
   );
   ```

2. **Reload programacion.html as Alba:**
   - Alert banner should appear at top of page
   - Alert should be yellow (warning color)
   - Alert should show:
     - "Capacitaciones que Vencen Pronto"
     - Training details: tema, cargo, sub_area
     - "Vence en 5 días"
     - "X colaborador(es) pendiente(s)"

3. **Check Programming Table:**
   - Find the programming row
   - "Próxima Capacitación" badge should be yellow
   - Should show "En 5 días"

### Option B: Test with 1-Month Frequency

1. **Create programming with 1-month frequency**
2. **Complete a training form on day 1**
3. **Wait or simulate 23-24 days**
4. **Check programacion.html for alerts**

### Expected Results:
✅ Alert banner appears when trainings expire within 7 days
✅ Alert is color-coded (yellow for <7 days, red for expired)
✅ Alert shows training details and pending count
✅ Table badges are color-coded (yellow/red)
✅ Trainer can see which trainings need attention

---

## Test 4: Trainer Alert Colors and Urgency

### Test Different Urgency Levels:

1. **7 Days Before (Blue):**
   - Set fecha_proxima = CURRENT_DATE + 7 days
   - Alert should be blue (info)
   - Badge should be blue

2. **3 Days Before (Yellow):**
   - Set fecha_proxima = CURRENT_DATE + 3 days
   - Alert should be yellow (warning)
   - Badge should be yellow/orange

3. **Expired (Red):**
   - Set fecha_proxima = CURRENT_DATE - 1 day
   - Alert should be red (danger)
   - Badge should be red
   - Text should say "Vencida hace X días"

### Expected Results:
✅ Alert colors change based on urgency
✅ Table badges change based on urgency
✅ Text adapts to show "Vence en X días" or "Vencida hace X días"
✅ Most urgent trainings appear at top of alert list

---

## Test 5: Collaborator Panel View

### Steps:
1. **Login as Lina (Collaborator)**
   - Navigate to user panel or training list
   - Check "Programadas" tab (if available)

2. **Verify Notification:**
   - Should see training in list
   - Should show:
     - Tema: Seguridad Industrial
     - Última capacitación: 2024-10-23
     - Próxima capacitación: 2025-10-23
     - Estado: Vigente (or color badge)

### Expected Results:
✅ Collaborator sees their scheduled trainings
✅ Next training date is displayed
✅ Status is clear (vigente, próximo a vencer, vencida)

---

## Test 6: Multiple Trainers (Role-Based Filtering)

### Setup:
- Create programming for "Capacitador_MT"
- Create programming for "Capacitador_GH"
- Set both to expire within 7 days

### Steps:
1. **Login as trainer with "Capacitador_MT" role:**
   - Go to programacion.html
   - Should see alerts ONLY for "Capacitador_MT" trainings
   - Should NOT see "Capacitador_GH" trainings

2. **Login as trainer with "Capacitador_GH" role:**
   - Go to programacion.html
   - Should see alerts ONLY for "Capacitador_GH" trainings
   - Should NOT see "Capacitador_MT" trainings

### Expected Results:
✅ Trainers only see alerts for their assigned roles
✅ Role-based filtering works correctly
✅ No unauthorized access to other trainers' notifications

---

## Test 7: Notification Update After Training

### Steps:
1. **Initial State:**
   - Programming exists
   - Notification shows training expires in 5 days

2. **Complete Training:**
   - Create training form for the topic
   - Add collaborator as attendee
   - Save form

3. **Verify Update:**
   - Go back to programacion.html
   - Alert should disappear (or show new date 12 months ahead)
   - "Próxima Capacitación" should show date 12 months from today
   - "Pendientes" count should update

### Expected Results:
✅ Notification updates automatically after training completion
✅ Alert disappears or updates for new cycle
✅ Next training date recalculated correctly
✅ Pending count decreases

---

## Test 8: Manual Notification Update

### Steps:
1. **Use API endpoint directly:**
   ```
   GET /m_capacitaciones/assets/php/programacion_api.php?action=update_notifications
   ```

2. **Or trigger from browser console:**
   ```javascript
   fetch('assets/php/programacion_api.php?action=update_notifications')
     .then(r => r.json())
     .then(data => console.log(data));
   ```

3. **Verify response:**
   - Should return: `{"success": true, "message": "Notificaciones actualizadas"}`

4. **Check programacion.html:**
   - Reload page
   - Verify alerts and table are updated

### Expected Results:
✅ Manual update triggers successfully
✅ Notifications recalculated
✅ UI reflects latest data

---

## Test 9: Edge Cases

### Test A: No Pending Trainings
- Remove all trainings or mark all as complete
- Go to programacion.html
- Alert banner should NOT appear
- Table should show "0" pending or "-" for next date

### Test B: Multiple Collaborators
- Create programming affecting 5+ collaborators
- Set to expire in 5 days
- Alert should show: "5 colaborador(es) pendiente(s)"

### Test C: Multiple Trainings Expiring
- Create 3 different programming entries
- Set all to expire within 7 days
- Alert should list all 3 trainings
- Alert should be color-coded by most urgent

### Test D: Sub_area Null Handling
- Create programming with sub_area = NULL
- Should match all collaborators with that cargo
- Verify notifications created for all

### Expected Results:
✅ System handles edge cases gracefully
✅ Counts are accurate
✅ Null values handled correctly
✅ Multiple trainings displayed properly

---

## Test 10: Complete Workflow (End-to-End)

### Scenario: Alba and Lina's Training Cycle

1. **Day 0: Programming Creation**
   - Alba creates programming for "Seguridad Industrial"
   - Target: Polinizador role, Producción Agrícola sub_area
   - Frequency: 12 months

2. **Day 0: First Training**
   - Alba conducts training
   - Lina attends
   - System records: fecha_proxima = Day 365

3. **Day 358: 7 Days Before**
   - Alba logs in to programacion.html
   - Sees blue alert: "Vence en 7 días - 1 colaborador pendiente"
   - Plans to contact Lina

4. **Day 362: 3 Days Before**
   - Alba logs in
   - Alert is now yellow: "Vence en 3 días"
   - More urgent visual indicator

5. **Day 365: Training Day**
   - Alba conducts second training
   - Lina attends
   - System updates: fecha_proxima = Day 730

6. **Day 365+: After Training**
   - Alba checks programacion.html
   - Alert is gone
   - Table shows next date: Day 730

### Expected Results:
✅ Complete cycle works as designed
✅ Alerts appear at correct times
✅ Colors change based on urgency
✅ System resets after training completion
✅ Next cycle begins automatically

---

## Troubleshooting

### Issue: Alerts not appearing
**Solutions:**
1. Verify programming is active (activo = true)
2. Check trainer's role matches programming role
3. Verify notification dates in database
4. Run manual update: `?action=update_notifications`
5. Check browser console for JavaScript errors

### Issue: Wrong dates displayed
**Solutions:**
1. Verify formula_api.php calls `actualizar_notificaciones_capacitacion()`
2. Check training form date is correct
3. Verify frequency_meses in programming
4. Check for timezone issues

### Issue: Pending count incorrect
**Solutions:**
1. Verify collaborators have matching cargo + sub_area
2. Check colaborador status (should be 'A', 'V', or 'P')
3. Verify attendee records in cap_formulario_asistente
4. Run notification update manually

### Issue: Colors not showing
**Solutions:**
1. Clear browser cache
2. Verify Bootstrap CSS is loaded
3. Check CSS classes in programacion.js
4. Inspect element to verify badge classes applied

---

## API Endpoints Reference

### Get Trainer Alerts (7-day warnings)
```
GET /m_capacitaciones/assets/php/notificaciones_api.php?action=get_trainer_alerts
```
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id_programacion": 1,
      "tema_nombre": "Seguridad Industrial",
      "cargo_nombre": "Polinizador",
      "sub_area": "Producción Agrícola",
      "rol_capacitador_nombre": "Capacitador_MT",
      "colaboradores_pendientes": 3,
      "dias_para_vencimiento": 5,
      "fecha_proxima": "2024-10-28"
    }
  ]
}
```

### Get Programming List (with next dates)
```
GET /m_capacitaciones/assets/php/programacion_api.php?action=list
```
**Response includes:**
- proxima_capacitacion: Next training date
- dias_para_proxima: Days until next training
- colaboradores_pendientes: Count of pending collaborators

### Update Notifications Manually
```
GET /m_capacitaciones/assets/php/programacion_api.php?action=update_notifications
```
**Response:**
```json
{
  "success": true,
  "message": "Notificaciones actualizadas"
}
```

---

## Success Criteria

All tests should pass with these results:

✅ Trainer alerts appear 7 days before trainings expire
✅ Alerts are color-coded by urgency (red/yellow/blue)
✅ Programming table shows next training dates
✅ Pending collaborator counts are accurate
✅ Role-based filtering works (trainers see only their trainings)
✅ Notifications update automatically after training completion
✅ System handles edge cases (null sub_area, multiple collaborators, etc.)
✅ Complete workflow from programming to alert to training completion works
✅ API endpoints return correct data
✅ No security vulnerabilities (passed CodeQL check)
✅ No PHP syntax errors
✅ No JavaScript syntax errors

---

## Notes

- This system is designed to help trainers stay proactive about upcoming trainings
- The 7-day advance warning gives sufficient time to plan and contact collaborators
- Color-coding helps prioritize urgent trainings
- The system integrates seamlessly with existing training management workflow
- All changes are backwards compatible with existing functionality

## Support

For issues or questions:
1. Check SCHEDULED_TRAININGS_README.md for detailed documentation
2. Review PHP error logs
3. Check browser console for JavaScript errors
4. Verify database migration was applied
5. Test API endpoints directly using browser or Postman
