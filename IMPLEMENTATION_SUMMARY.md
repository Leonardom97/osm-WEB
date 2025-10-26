# Implementation Summary: Sub Área Select and Scheduled Trainings

## Overview
This document summarizes the changes made to implement the requirements from the problem statement:
1. Convert Sub Área field from text input to select dropdown
2. Link training schedules to forms and calculate next training dates
3. Add "Programadas" tab to show scheduled trainings with next training dates

## Changes Made

### 1. Sub Área Field Conversion (programacion.html & programacion.js)

**File: m_capacitaciones/programacion.html**
- Changed line 130 from `<input type="text">` to `<select class="form-select">`
- This ensures Sub Área is always selected from a dropdown instead of being manually typed

**File: m_capacitaciones/assets/js/programacion.js**
- Added `subAreas` array to store sub area options
- Modified `loadData()` to fetch sub areas from the API
- Updated `populateSelects()` to populate the Sub Área dropdown with all available options
- Simplified `setupEventListeners()` to remove dynamic cargo-based loading (now loads all sub areas upfront)
- Simplified `editProgramacion()` to directly set the sub area value

**File: m_capacitaciones/assets/php/programacion_api.php**
- Modified `get_sub_areas` case to return ALL unique sub_area values from the `adm_área` table
- No longer requires cargo_id parameter
- Filters out system values like '- SIN PROYECTO -' and 'POR ASIGNAR'

### 2. Link Training Schedules to Forms

**File: m_capacitaciones/assets/php/formulario_api.php**
- Added code to call `actualizar_notificaciones_capacitacion()` after saving a form
- This ensures that when a training form is saved, the system automatically:
  - Updates the `fecha_ultima_capacitacion` for affected collaborators
  - Calculates the `fecha_proxima` based on the programming frequency
  - Updates the notification status

**How it works:**
1. When a form is saved with attendees, the system records the training completion
2. The `actualizar_notificaciones_capacitacion()` function is triggered
3. For each collaborator linked to a programming entry:
   - Finds the most recent training date for that topic
   - Adds the frequency (in months) to calculate next training date
   - Updates the notification status (vigente, proximo_vencer, vencida)

### 3. Add "Programadas" Tab to Usuarios.html

**File: Usuarios.html**
- Added new tab "Programadas" between "Pendientes" and "Realizadas"
- Added container `scheduledTrainingsContainer` for displaying scheduled trainings

**File: assets/js/user_trainings.js**
- Added `loadScheduledTrainings()` function to load and display programmed trainings
- Modified `DOMContentLoaded` to call the new function
- Display format shows:
  - Training topic (tema)
  - Last training date (fecha_ultima_capacitacion)
  - Next scheduled date (fecha_proxima)
  - Frequency in months
  - Status with color-coded badges
  - Responsible trainer

**File: m_capacitaciones/assets/php/progreso_api.php**
- Added new endpoint `get_scheduled_trainings`
- Returns all scheduled trainings for a user with:
  - Last training date
  - Next training date calculated from frequency
  - Current status
  - Badge color class for UI display

## Data Flow

### When a Training Form is Created:
```
1. User creates training form (formulario.html)
   ↓
2. Form is saved with attendees (formulario_api.php)
   ↓
3. System triggers actualizar_notificaciones_capacitacion()
   ↓
4. For each collaborator+programming combination:
   - Finds latest training completion date
   - Calculates next training date = last_date + frequency_months
   - Updates cap_notificaciones table
```

### When User Views Their Profile (Usuarios.html):
```
1. User opens Usuarios.html
   ↓
2. JavaScript loads scheduled trainings (get_scheduled_trainings)
   ↓
3. Query joins:
   - cap_notificaciones (has next dates)
   - cap_programacion (has frequency)
   - cap_tema (has training name)
   - adm_roles (has responsible trainer)
   ↓
4. Displays in "Programadas" tab with next training dates
```

## Database Schema Usage

### Tables Involved:
- `adm_área`: Source of sub_area values for dropdown
- `cap_programacion`: Stores training schedules with frequency
- `cap_notificaciones`: Tracks next training dates per collaborator
- `cap_formulario`: Records completed trainings
- `cap_formulario_asistente`: Links collaborators to training forms

### Key Function:
- `actualizar_notificaciones_capacitacion()`: PostgreSQL function that recalculates all next training dates

## Testing Checklist

### Manual Testing Steps:
1. ✓ Open programacion.html
2. ✓ Click "Nueva Programación"
3. ✓ Verify Sub Área is a dropdown (not text input)
4. ✓ Verify dropdown contains values from adm_área table
5. ✓ Create a new programming entry
6. ✓ Create a training form (formulario.html)
7. ✓ Add attendees to the form
8. ✓ Save the form
9. ✓ Open Usuarios.html as an attendee
10. ✓ Click "Programadas" tab
11. ✓ Verify next training date is shown
12. ✓ Verify next date = last training date + frequency months

### Expected Results:
- Sub Área dropdown shows all unique values from adm_área
- After saving a form, cap_notificaciones updates automatically
- Programadas tab shows all scheduled trainings with next dates
- Next dates are calculated correctly based on frequency

## Files Modified

1. `/home/runner/work/osm-WEB/osm-WEB/Usuarios.html`
2. `/home/runner/work/osm-WEB/osm-WEB/assets/js/user_trainings.js`
3. `/home/runner/work/osm-WEB/osm-WEB/m_capacitaciones/assets/js/programacion.js`
4. `/home/runner/work/osm-WEB/osm-WEB/m_capacitaciones/assets/php/formulario_api.php`
5. `/home/runner/work/osm-WEB/osm-WEB/m_capacitaciones/assets/php/programacion_api.php`
6. `/home/runner/work/osm-WEB/osm-WEB/m_capacitaciones/assets/php/progreso_api.php`
7. `/home/runner/work/osm-WEB/osm-WEB/m_capacitaciones/programacion.html`

## Notes

- All changes are backward compatible
- No database migrations required (tables already exist from previous migration)
- The actualizar_notificaciones_capacitacion() function was already in the database
- Changes follow existing code patterns and conventions
- All PHP files pass syntax validation
