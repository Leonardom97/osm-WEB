# Summary of Changes - File Upload and Sub-Area Requirements

## Overview
This document summarizes the changes made to fix the file upload functionality and implement the sub-area selector requirements in the OSM-WEB training module.

## Problem Statement
1. **File Upload Error**: The file upload in `/m_capacitaciones/formulario.html` was not working correctly. Files needed to be saved to `/m_capacitaciones/assets/docs/[formulario_id]/archivos/` directory structure.

2. **Sub-Area Selector**: The programming modal (`/m_capacitaciones/programacion.html`) needed to have a sub-area selector that dynamically loads options from the `adm_área` table based on the selected cargo, and this field needed to be mandatory.

3. **Role Restrictions**: Specific roles needed to be enabled for programming functionality.

## Changes Made

### 1. File Upload Functionality (`file_upload_api.php`)

#### Modified Files:
- `/m_capacitaciones/assets/php/file_upload_api.php`

#### Changes:
- Updated directory structure from `m_capacitaciones/uploads/formulario/[id]/` to `m_capacitaciones/assets/docs/[id]/archivos/`
- Modified base directory path: `__DIR__ . '/../docs'`
- Updated file path generation in all three cases: `upload_file`, `get_file`, and `delete_file`
- Ensured proper directory creation with correct permissions (0755)

#### Key Code Changes:
```php
// OLD:
$baseDir = __DIR__ . '/../../../m_capacitaciones/uploads/formulario';
$uploadDir = $baseDir . '/' . $formulario_id;
// Results in: /m_capacitaciones/uploads/formulario/[id]/

// NEW:
$baseDir = __DIR__ . '/../docs';
// Where __DIR__ is: /m_capacitaciones/assets/php
// Results in: /m_capacitaciones/assets/docs
$formularioDir = $baseDir . '/' . $formulario_id;
$uploadDir = $formularioDir . '/archivos';
// Final path: /m_capacitaciones/assets/docs/[id]/archivos/
```

### 2. Sub-Area Selector - Backend (`programacion_api.php`)

#### Modified Files:
- `/m_capacitaciones/assets/php/programacion_api.php`

#### Changes:
1. **`get_sub_areas` Endpoint**:
   - Changed query logic to fetch from `adm_área` table instead of only `adm_colaboradores`
   - First queries `adm_colaboradores` to get areas associated with the selected cargo
   - Then queries `adm_área` table to get distinct sub-areas for those areas

2. **`create` and `update` Actions**:
   - Added `sub_area` to required fields validation
   - Removed nullable behavior - `sub_area` is now always required
   - Added trim() to prevent whitespace-only values

3. **`get_roles` Action**:
   - Updated to explicitly list all authorized roles
   - Added support for both space and underscore formats (e.g., "Capacitador SIE" and "Capacitador_SIE")
   - Included all required roles: Capacitador SIE, GH, TI, MT, IND, ADM, AGR, Administrador, Capacitador, Aux_Capacitador

#### Key Code Changes:
```php
// NEW get_sub_areas logic:
$stmt = $pg->prepare("
    SELECT DISTINCT ac_id_area
    FROM adm_colaboradores
    WHERE ac_id_cargo = ? AND ac_id_area IS NOT NULL
    AND ac_id_situación IN ('A', 'V', 'P')
");
// Then query adm_área table for sub_areas

// Required field validation:
$required = ['id_tema', 'id_cargo', 'sub_area', 'frecuencia_meses', 'id_rol_capacitador'];
```

### 3. Sub-Area Selector - Frontend HTML (`programacion.html`)

#### Modified Files:
- `/m_capacitaciones/programacion.html`

#### Changes:
- Updated label from "Sub Área (Opcional)" to "Sub Área <span class="text-danger">*</span>"
- Added `required` attribute to the input field
- Added `data-role` attribute to body tag for role-based access control
- Restricted access to specific capacitador roles

#### Key Code Changes:
```html
<!-- OLD: -->
<label class="form-label">Sub Área (Opcional)</label>
<input type="text" class="form-control" id="inputSubArea" placeholder="Ej: Mantenimiento Industrial">

<!-- NEW: -->
<label class="form-label">Sub Área <span class="text-danger">*</span></label>
<input type="text" class="form-control" id="inputSubArea" placeholder="Ej: Mantenimiento Industrial" required>

<!-- Body tag role restrictions: -->
<body id="page-top" data-role="Administrador,Capacitador,Aux_Capacitador,Capacitador_SIE,Capacitador_GH,Capacitador_TI,Capacitador_MT,Capacitador_ADM,Capacitador_IND,Capacitador_AGR">
```

### 4. Sub-Area Selector - Frontend JavaScript (`programacion.js`)

#### Modified Files:
- `/m_capacitaciones/assets/js/programacion.js`

#### Changes:
1. **`btnNuevaProgramacion` Click Handler**:
   - Always sets sub_area as required with asterisk in label
   - Ensures field starts as required text input

2. **`inputCargo` Change Handler**:
   - Updated to always make sub_area required (removed optional behavior)
   - Maintains dynamic conversion between text input and select dropdown
   - If sub-areas found: converts to select dropdown (required)
   - If no sub-areas: keeps as text input (required)
   - Always displays asterisk in label

3. **`saveProgramacion` Function**:
   - Added explicit validation for sub_area to ensure it's not empty
   - Changed from `sub_area: value || null` to `sub_area: value.trim()`
   - Added alert if sub_area is empty

#### Key Code Changes:
```javascript
// NEW validation in saveProgramacion:
const subAreaValue = document.getElementById('inputSubArea').value;
if (!subAreaValue || subAreaValue.trim() === '') {
    alert('El campo Sub Área es obligatorio');
    document.getElementById('inputSubArea').focus();
    return;
}

// NEW behavior in cargo change handler:
// Always shows: 'Sub Área <span class="text-danger">*</span>'
// Always sets: select.required = true; or input.required = true;
```

### 5. Configuration Updates

#### Modified Files:
- `.gitignore`

#### Changes:
- Added `m_capacitaciones/assets/docs/` to prevent uploaded files from being tracked in git
- Added `m_capacitaciones/uploads/` for legacy support

### 6. Documentation

#### New Files:
- `/m_capacitaciones/README_FILE_UPLOAD.md` - Comprehensive documentation for file upload and sub-area features
- `/CHANGES_SUMMARY.md` - This file, documenting all changes

## Testing Performed

### Syntax Validation:
- ✅ PHP syntax check on `file_upload_api.php` - No errors
- ✅ PHP syntax check on `programacion_api.php` - No errors
- ✅ JavaScript syntax check on `programacion.js` - No errors
- ✅ JavaScript syntax check on `formulario.js` - No errors

### Manual Testing Required:
The following tests should be performed in the deployed environment:

1. **File Upload Test**:
   - Navigate to `/m_capacitaciones/formulario.html`
   - Fill out form and select a file
   - Verify file uploads to `/m_capacitaciones/assets/docs/[id]/archivos/`
   - Verify database `archivo_adjunto` field is populated

2. **Sub-Area Selector Test**:
   - Navigate to `/m_capacitaciones/programacion.html`
   - Click "Nueva Programación"
   - Select a cargo
   - Verify sub-area field shows options or text input
   - Try submitting without sub-area (should fail)
   - Submit with sub-area (should succeed)

3. **Role Access Test**:
   - Verify only authorized roles can access programacion.html
   - Test with different user roles

## Database Requirements

### Required Database Changes:
Ensure the migration `migration_add_session_management.sql` has been run, which adds:
```sql
ALTER TABLE cap_formulario 
ADD COLUMN archivo_adjunto VARCHAR(255);
```

### Table Structure:
- `cap_formulario` must have `archivo_adjunto` column (VARCHAR(255), nullable)
- `cap_programacion` has `sub_area` column (VARCHAR, existing in table)
  - **Note**: The `sub_area` field is enforced as mandatory at the application level (frontend and backend validation), but the database column itself allows NULL values for backward compatibility with existing records. All new/updated records will have this field populated due to application-level validation.
- `adm_área` table must have `id_area`, `area`, and `sub_area` columns
- `adm_roles` table must contain the required role names

## Security Considerations

1. **File Upload Security**:
   - File type validation (MIME type checking)
   - File size validation (2MB limit)
   - Filename sanitization
   - Directory creation with safe permissions
   - Session authentication required

2. **Access Control**:
   - Role-based page access (data-role attribute)
   - API endpoint session validation
   - SQL injection prevention via prepared statements

3. **Data Validation**:
   - Client-side and server-side validation
   - Required field enforcement
   - String trimming to prevent whitespace-only values

## Rollback Plan

If issues occur, the following files can be reverted:
1. `m_capacitaciones/assets/php/file_upload_api.php`
2. `m_capacitaciones/assets/php/programacion_api.php`
3. `m_capacitaciones/assets/js/programacion.js`
4. `m_capacitaciones/programacion.html`
5. `.gitignore`

Database changes (archivo_adjunto column) should NOT be rolled back as they're additive.

## Known Limitations

1. File upload only works with active user session
2. Sub-area options depend on existing data in `adm_colaboradores` and `adm_área` tables
3. Maximum file size is hardcoded to 2MB
4. File upload is optional, not required

## Future Improvements

1. Add file preview/download functionality
2. Add ability to delete/replace uploaded files
3. Add file type icons in UI
4. Implement file virus scanning
5. Add bulk upload capability
6. Create automated tests for file upload and sub-area logic
7. Add file upload progress indicator
8. Implement file compression for large images

## Contact

For questions or issues regarding these changes, please contact the development team.

## Version History

- **v1.0** (2025-10-23): Initial implementation of file upload fix and sub-area selector requirements
