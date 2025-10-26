# Training History Modal - User Panel Documentation

## Overview
The Training History Modal is a comprehensive feature in the User Panel (`Usuarios.html`) that displays all training records for the logged-in user. It includes filtering, sorting, and Excel export capabilities.

## Features

### 1. Data Display
The modal displays training records with the following 15 columns:
1. **Proceso** - Training process (from `cap_proceso` table)
2. **Lugar** - Training location (from `cap_lugar` table)
3. **Responsable Capacitación** - Training coordinator name (from `adm_usuarios` table)
4. **Tema** - Training topic (from `cap_tema` table)
5. **Tipo de Actividad** - Activity type (from `cap_tipo_actividad` table)
6. **Fecha** - Training date
7. **Hora Inicio** - Start time
8. **Hora Fin** - End time
9. **Estado Aprobación** - Approval status (from `cap_formulario_asistente`)
10. **Empresa** - Company
11. **Cargo** - Position/Job title
12. **Área** - Area
13. **Sub-Área** - Sub-area
14. **Rango** - Range/Level
15. **Situación** - Status (Active, Inactive, etc.)

### 2. Filtering
- **By User**: Automatically filters by the logged-in user's cedula (ID number)
- **Search**: Real-time text search across all columns
- Only shows records where the user is listed as an attendee in `cap_formulario_asistente`

### 3. Sorting
- All columns are sortable
- Click column header to sort ascending
- Click again to sort descending
- Visual indicators show current sort column and direction

### 4. Excel Export
- Export all displayed training records to Excel format (.xlsx)
- Maintains all 15 columns with proper headers in Spanish
- Auto-sizes columns for readability
- Filename format: `Capacitaciones_{cedula}_{date}.xlsx`

## Technical Implementation

### Database Schema
The feature queries data from the following PostgreSQL tables:
- `cap_formulario` - Main training form data
- `cap_formulario_asistente` - Attendee records (links users to trainings)
- `cap_tema` - Training topics
- `cap_tipo_actividad` - Activity types
- `cap_proceso` - Process categories
- `cap_lugar` - Training locations
- `adm_usuarios` - User information (for coordinators)

### Files Involved

#### 1. HTML: `Usuarios.html`
- Contains the modal structure (lines 254-351)
- Defines the 15-column table layout
- Includes search input and export button

#### 2. JavaScript: `assets/js/user_trainings.js`
Key functions:
- `openAllTrainingsModal()` - Opens the modal and loads data
- `loadAllTrainings()` - Fetches data from API
- `renderTrainingsTable(data)` - Renders table rows
- `filterTrainingsTable()` - Implements real-time search
- `sortTrainingsTable(column)` - Handles column sorting
- `exportToExcel()` - Generates Excel file using XLSX.js

#### 3. PHP API: `m_capacitaciones/assets/php/progreso_api.php`
Action: `get_full_training_history`
- Queries database for all training records filtered by user's cedula
- Joins multiple tables to get complete information
- Returns JSON response with training data array

### SQL Query
```sql
SELECT 
    pr.proceso,
    l.lugar,
    CONCAT_WS(' ', NULLIF(u.nombre1, ''), NULLIF(u.nombre2, ''), 
              NULLIF(u.apellido1, ''), NULLIF(u.apellido2, '')) AS responsable_capacitacion,
    t.nombre AS tema,
    ta.nombre AS tipo_actividad,
    f.fecha,
    f.hora_inicio,
    f.hora_final AS hora_fin,
    fa.estado_aprovacion,
    fa.empresa,
    fa.cargo,
    fa.área AS area,
    fa.sub_área AS sub_area,
    fa.rango,
    fa.situacion
FROM cap_formulario_asistente fa
INNER JOIN cap_formulario f ON fa.id_formulario = f.id
INNER JOIN cap_tema t ON f.id_tema = t.id
LEFT JOIN cap_tipo_actividad ta ON f.id_tipo_actividad = ta.id
LEFT JOIN cap_proceso pr ON f.id_proceso = pr.id
LEFT JOIN cap_lugar l ON f.id_lugar = l.id
LEFT JOIN adm_usuarios u ON f.id_usuario = u.id
WHERE fa.cedula = ?
ORDER BY f.fecha DESC
```

## User Flow

1. User logs in to the system (as collaborator or admin)
2. Navigates to User Panel (`Usuarios.html`)
3. Clicks "Ver Más" button in the "Últimas Capacitaciones" card
4. Modal opens showing all training records
5. User can:
   - Search across all columns using the search box
   - Click column headers to sort
   - Click "Exportar a Excel" to download data
   - View total record count

## Security
- User authentication required via PHP session
- Only shows data for the logged-in user's cedula
- Session validation occurs on every API call
- No direct database access from client side

## Dependencies
- **Bootstrap 5** - Modal and UI components
- **Font Awesome** - Icons
- **XLSX.js** (`assets/js/xlsx.full.min.js`) - Excel export functionality
- **PostgreSQL** - Database backend

## Recent Fixes (October 2025)
1. Fixed SQL syntax error: removed duplicate `responsable` field definition
2. Corrected column reference: changed `ta.tipo_actividad` to `ta.nombre` (correct table column)
3. Both issues fixed in `progreso_api.php` for endpoints:
   - `get_completed_trainings_details`
   - `get_full_training_history`

## Testing
To test the feature:
1. Log in as a user with existing training records
2. Navigate to User Panel
3. Click "Ver Más" button
4. Verify all 15 columns display correctly
5. Test search functionality
6. Test column sorting
7. Test Excel export

## Troubleshooting

### Modal shows no data
- Verify user has training records in `cap_formulario_asistente` table
- Check that cedula matches between `adm_colaboradores` and `cap_formulario_asistente`
- Check browser console for API errors

### Excel export fails
- Verify XLSX.js library is loaded: `assets/js/xlsx.full.min.js`
- Check browser console for JavaScript errors
- Ensure data is loaded before clicking export button

### Columns show "-" or empty values
- Check that related tables have data (e.g., `cap_tema`, `cap_proceso`, etc.)
- Verify foreign key relationships in database
- Check LEFT JOIN vs INNER JOIN usage in SQL query

## Future Enhancements
Potential improvements:
- Date range filtering
- Export filtered/sorted data only (currently exports all)
- Additional export formats (CSV, PDF)
- Pagination for large datasets
- Training status badges (completed, pending, upcoming)
