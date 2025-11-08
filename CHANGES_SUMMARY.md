# Training Scheduling System Changes Summary

## Overview
This document summarizes the changes made to the training scheduling system to modify how training dates are managed and calculated.

## Key Changes

### 1. Programacion Module Changes (`programacion.html` + `programacion.js`)

#### Modal Changes:
- **REMOVED**: "Fecha Última Capacitación" field
- **ADDED**: "Fecha Próxima Capacitación" field (required)
- The modal now requires users to specify the next scheduled training date directly

#### Table Display Changes:
- **REMOVED**: "Última Capacitación" column
- **KEPT**: "Próxima Capacitación" column showing the programmed next training date
- Table now has 10 columns instead of 11

#### JavaScript Changes (`programacion.js`):
- Updated `saveProgramacion()` to send `fecha_proxima_capacitacion` instead of `fecha_ultima_capacitacion`
- Updated `editProgramacion()` to load `fecha_proxima_capacitacion` into the form
- Updated `renderTable()` to display only próxima capacitación column

### 2. Backend API Changes (`programacion_api.php`)

#### Create Operation:
- Now requires `fecha_proxima_capacitacion` as a mandatory field
- Calculates `fecha_notificacion_previa` as 1 month before próxima capacitación
- No longer stores `fecha_ultima_capacitacion` in programacion table

#### Update Operation:
- Updates `fecha_proxima_capacitacion` when provided
- Recalculates notification date accordingly

#### List Operation (NEW - Role-based Filtering):
- Checks user's role from session
- If user is a specific trainer (e.g., `Capacitador_TI`, `Capacitador_SIE`, etc.):
  - Only shows programaciones assigned to their role
- If user is `Administrador`, `Capacitador`, or `Aux_Capacitador`:
  - Shows all programaciones

### 3. Dashboard Backend Changes (`malla_api.php`)

#### get_malla Query (Main Dashboard Data):
The logic now works as follows:

1. **Match employees to programaciones** based on cargo and sub_area
2. **Get user's completion history** from `cap_formulario_asistente` table
3. **Calculate next due date**:
   - If user has completed the training: `user_completion_date + frequency`
   - If user has NOT completed: use programmed `fecha_proxima_capacitacion`
4. **Calculate status**:
   - `vencida` (overdue): next due date has passed
   - `proximo_vencer` (about to expire): next due date is within 30 days
   - `al_dia` (up to date): user completed and next due date is in the future
   - `pendiente` (pending): user never completed and programmed date is in the future

#### get_user_pending_trainings (User Profile):
- Same logic applied for individual user view
- Shows trainings specific to the user's cargo and sub_area
- Calculates status based on individual completion history

### 4. Users Module Changes (`Usuarios.html`)

#### Modal Changes:
- Changed "Ver Más" trainings modal from `modal-xl` to `modal-fullscreen`
- Provides full-screen view for better data visibility

## Data Flow

### Programming Flow:
1. Trainer creates a programacion with:
   - Cargo, Sub Área, Tema, Frecuencia, Rol Capacitador
   - **Fecha Próxima Capacitación** (next scheduled training date)
2. System calculates notification date (1 month before)
3. Programacion is saved with these dates

### Training Execution Flow:
1. When training is completed, form is created in `cap_formulario`
2. Attendees are registered in `cap_formulario_asistente`
3. Each attendee's completion is tracked individually

### Status Calculation Flow:
1. System looks up user's last completion date from `cap_formulario_asistente`
2. If user completed:
   - Next due date = completion_date + frequency_months
   - Compare with today to determine status
3. If user never completed:
   - Next due date = programmed fecha_proxima_capacitacion
   - Compare with today to determine status

## Database Schema Notes

The `cap_programacion` table should have:
- `fecha_proxima_capacitacion` (DATE) - The programmed next training date
- `fecha_notificacion_previa` (DATE) - When to send notification
- Note: `fecha_ultima_capacitacion` column exists but is no longer used by the application

The `cap_formulario_asistente` table tracks:
- `id_colaborador` - Reference to employee
- `id_formulario` - Reference to training form
- `estado_aprobacion` - Whether the employee passed ('aprobo')

The `cap_formulario` table tracks:
- `id_tema` - Which training topic
- `fecha` - When the training was conducted

## Role-Based Access

### Trainer Roles:
- `Capacitador_TI` - Only sees TI trainings
- `Capacitador_SIE` - Only sees SIE trainings
- `Capacitador_GH` - Only sees GH trainings
- `Capacitador_MT` - Only sees MT trainings
- `Capacitador_ADM` - Only sees ADM trainings
- `Capacitador_IND` - Only sees IND trainings
- `Capacitador_AGR` - Only sees AGR trainings

### Admin Roles:
- `Administrador` - Sees all trainings
- `Capacitador` - Sees all trainings
- `Aux_Capacitador` - Sees all trainings

## Testing Recommendations

### 1. Test Programacion Module:
- [ ] Create new programacion with fecha_proxima_capacitacion
- [ ] Verify notification date is calculated correctly (1 month before)
- [ ] Edit existing programacion and change dates
- [ ] Verify role-based filtering (login as Capacitador_TI, should only see TI trainings)
- [ ] Delete programacion (soft delete)

### 2. Test Dashboard:
- [ ] Verify employees appear with correct cargo/sub_area matching
- [ ] Check status calculation for users who have completed training
- [ ] Check status calculation for users who have NOT completed training
- [ ] Verify "días restantes" calculation is accurate
- [ ] Test filters (estado, cargo, sub_area, tema, rol)

### 3. Test User Profile (Usuarios.html):
- [ ] Navigate to user profile
- [ ] Check "Pendientes" tab shows correct pending trainings
- [ ] Check "Programadas" tab shows all applicable trainings with status
- [ ] Verify modal is full-screen
- [ ] Test filtering and sorting in modal

### 4. Test Different Scenarios:

#### Scenario 1: New Employee
- Employee has no training history
- Should show all programaciones for their cargo/sub_area as "pendiente"
- Next due date should be the programmed fecha_proxima_capacitacion

#### Scenario 2: Employee with Recent Training
- Employee completed training 2 months ago
- Frequency is 12 months
- Should show as "al_dia"
- Next due date should be 10 months from now

#### Scenario 3: Employee with Overdue Training
- Employee completed training 14 months ago
- Frequency is 12 months
- Should show as "vencida"
- Next due date should be 2 months in the past (negative days)

#### Scenario 4: Training About to Expire
- Employee completed training 11 months ago
- Frequency is 12 months
- Should show as "proximo_vencer"
- Next due date should be 1 month from now

## Files Modified

1. `/m_capacitaciones/programacion.html` - Modal and table structure
2. `/m_capacitaciones/assets/js/programacion.js` - Frontend logic
3. `/m_capacitaciones/assets/php/programacion_api.php` - Backend CRUD operations
4. `/m_capacitaciones/assets/php/malla_api.php` - Dashboard data queries
5. `/Usuarios.html` - Modal size change

## Breaking Changes

None. The changes are backward compatible:
- Old `fecha_ultima_capacitacion` data in the database is simply not used
- All status calculations now use individual user completion history from `cap_formulario_asistente`

## Migration Notes

No database migration required:
- `fecha_proxima_capacitacion` column already exists (added in previous migration)
- Existing programaciones may need to have `fecha_proxima_capacitacion` set manually
- The system will work with NULL values (showing as "pendiente")
