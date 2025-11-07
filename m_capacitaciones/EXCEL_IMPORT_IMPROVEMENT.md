# Excel Import Fix and Template Download Feature

## Summary

This document describes the improvements made to the Excel import functionality in the `programacion.html` module, including bug fixes and the addition of a template download feature.

## Problem Statement

The user reported two issues:
1. Excel import in the `programacion.html` module was failing during execution
2. Need a button to download a template file in the import modal

## Analysis

After analyzing the existing code and documentation, I found:

### Existing Implementation
- The frontend Excel import logic in `programacion.js` was already well-implemented with comprehensive validation
- Error handling and user feedback mechanisms were in place
- The XLSX library was properly loaded from CDN

### Issues Identified
1. **Backend validation gap**: The `bulk_import` action in `programacion_api.php` was not validating that `sub_area` is required, despite this being a mandatory field according to the documentation
2. **Inconsistent NULL handling**: The duplicate check and insert statement allowed NULL values for `sub_area`, which contradicts the requirement
3. **Missing template download feature**: No button to download a template file

## Changes Made

### 1. Frontend Changes (programacion.html)

Added a "Download Template" button in the import modal:
```html
<div class="d-flex justify-content-between align-items-start mb-2">
    <h6 class="mb-0">Formato del archivo Excel:</h6>
    <button type="button" class="btn btn-sm btn-success" id="btnDownloadTemplate">
        <i class="fas fa-download"></i> Descargar Plantilla
    </button>
</div>
```

**Benefits:**
- Users can easily download a correctly formatted template
- Reduces errors from incorrect file format
- Improves user experience

### 2. Frontend JavaScript Changes (programacion.js)

Added `downloadTemplate()` function with the following features:
- Checks if XLSX library is loaded
- Creates a new Excel workbook programmatically
- Includes proper column headers and 3 example rows
- Sets appropriate column widths for readability
- Generates filename with current date (e.g., `plantilla_programacion_2025-11-07.xlsx`)
- Shows success/error alerts to user

```javascript
function downloadTemplate() {
    // Check if XLSX library is loaded
    if (typeof XLSX === 'undefined') {
        showAlert('Error: La librería XLSX no está cargada...', 'danger');
        return;
    }

    try {
        // Create workbook with template data
        const wb = XLSX.utils.book_new();
        const templateData = [
            ['Cargo ID', 'Sub Área ID', 'Tema ID', 'Frecuencia', 'Rol Capacitador'],
            ['117', '003', 49, 12, 'Capacitador SIE'],
            ['043', '016', 23, 12, 'Capacitador IND'],
            ['068', '001', 47, 6, 'Capacitador SIE']
        ];
        
        const ws = XLSX.utils.aoa_to_sheet(templateData);
        ws['!cols'] = [
            { wch: 12 }, { wch: 15 }, { wch: 10 }, { wch: 12 }, { wch: 20 }
        ];
        
        XLSX.utils.book_append_sheet(wb, ws, 'programacion');
        
        const today = new Date();
        const dateStr = today.toISOString().split('T')[0];
        const filename = `plantilla_programacion_${dateStr}.xlsx`;
        
        XLSX.writeFile(wb, filename);
        showAlert('Plantilla descargada exitosamente', 'success');
    } catch (error) {
        console.error('Error generating template:', error);
        showAlert('Error al generar la plantilla: ' + error.message, 'danger');
    }
}
```

### 3. Backend Changes (programacion_api.php)

#### Change 1: Required Field Validation
```php
// Before
if (empty($item['id_cargo']) || empty($item['id_tema']) || empty($item['id_rol_capacitador'])) {
    $errors[] = "Fila " . ($index + 1) . ": Campos requeridos faltantes";
    continue;
}

// After
if (empty($item['id_cargo']) || empty($item['id_tema']) || empty($item['id_rol_capacitador']) || empty($item['sub_area'])) {
    $errors[] = "Fila " . ($index + 1) . ": Campos requeridos faltantes";
    continue;
}
```

#### Change 2: Duplicate Check Simplification
```php
// Before
$checkStmt = $pg->prepare("
    SELECT COUNT(*) FROM cap_programacion 
    WHERE id_cargo = ? AND id_tema = ? 
    AND (sub_area = ? OR (sub_area IS NULL AND ? IS NULL))
    AND activo = true
");
$checkStmt->execute([
    $item['id_cargo'],
    $item['id_tema'],
    $item['sub_area'] ?? null,
    $item['sub_area'] ?? null
]);

// After (simplified since sub_area is required)
$checkStmt = $pg->prepare("
    SELECT COUNT(*) FROM cap_programacion 
    WHERE id_cargo = ? AND id_tema = ? AND sub_area = ?
    AND activo = true
");
$checkStmt->execute([
    $item['id_cargo'],
    $item['id_tema'],
    $item['sub_area']
]);
```

#### Change 3: Insert Statement
```php
// Before
$stmt->execute([
    $item['id_tema'],
    $item['id_cargo'],
    $item['sub_area'] ?? null,  // Allowed NULL
    $frecuencia,
    $item['id_rol_capacitador'],
    $fecha_proxima,
    $fecha_notificacion
]);

// After
$stmt->execute([
    $item['id_tema'],
    $item['id_cargo'],
    $item['sub_area'],  // Required, no NULL fallback
    $frecuencia,
    $item['id_rol_capacitador'],
    $fecha_proxima,
    $fecha_notificacion
]);
```

## Testing

### Automated Tests

Created comprehensive test suite with 9 test scenarios:

1. ✅ **Valid Data**: All data is valid and should import successfully
2. ✅ **Missing Cargo**: Error reported for missing cargo field
3. ✅ **Missing Sub Area**: Error reported for missing sub_area field
4. ✅ **Missing Tema**: Error reported for missing tema field
5. ✅ **Missing Rol**: Error reported for missing rol field
6. ✅ **Invalid Tema Type**: Error reported for non-numeric tema
7. ✅ **Invalid Frecuencia**: Error reported for negative/invalid frecuencia
8. ✅ **Empty Rows**: Empty rows are properly skipped
9. ✅ **Mixed Valid/Invalid**: Valid rows imported, errors reported for invalid rows

**All 9 tests passed successfully.**

### Manual Testing

Created test files and utilities:
- `/tmp/excel_import_tests/` - Directory with 9 test Excel files
- `/tmp/test-download-template.html` - Standalone page to test download functionality
- Test scripts for automated validation

## File Structure

```
m_capacitaciones/
├── programacion.html           # Updated with download button
├── assets/
│   ├── js/
│   │   └── programacion.js    # Added downloadTemplate() function
│   └── php/
│       └── programacion_api.php # Fixed bulk_import validation
└── ejemplo_importacion.xlsx    # Existing template file (still available)
```

## User Guide

### How to Use the Download Template Feature

1. Navigate to **Programación de Capacitaciones** page
2. Click the **"Importar Excel"** button
3. In the import modal, click **"Descargar Plantilla"** button
4. An Excel file will be downloaded with the current date in the filename
5. Open the file, replace the example data with your data
6. Upload the file using the file input field

### Excel Template Format

The template includes:

| Cargo ID | Sub Área ID | Tema ID | Frecuencia | Rol Capacitador |
|----------|-------------|---------|------------|-----------------|
| 117      | 003         | 49      | 12         | Capacitador SIE |
| 043      | 016         | 23      | 12         | Capacitador IND |
| 068      | 001         | 47      | 6          | Capacitador SIE |

**Column Descriptions:**
- **Cargo ID**: Position/job code from `adm_cargos` table
- **Sub Área ID**: Sub-area code from `adm_área` table (e.g., '003', '016')
- **Tema ID**: Training topic ID from `cap_tema` table
- **Frecuencia**: Frequency in months (must be > 0)
- **Rol Capacitador**: Trainer role name (must match exactly with `adm_roles` table)

### Validation Rules

The system validates:
- ✅ All required fields are present (Cargo, Sub Área, Tema, Rol)
- ✅ Tema ID is a valid number
- ✅ Frecuencia is a valid number greater than 0
- ✅ Rol Capacitador exists in the database
- ✅ No duplicate combinations of Cargo + Sub Área + Tema
- ✅ Empty rows are automatically skipped

## Benefits

1. **Improved User Experience**
   - Easy access to template file
   - No need to search for example files
   - Template always has the correct format

2. **Reduced Errors**
   - Template generated programmatically ensures correct format
   - Backend validation catches missing required fields
   - Clear error messages guide users

3. **Better Data Quality**
   - Required sub_area field ensures complete data
   - Simplified duplicate detection prevents inconsistencies

4. **Maintainability**
   - Template generation in code means updates are easy
   - Single source of truth for template format
   - No need to maintain separate template files

## Backward Compatibility

✅ All changes are backward compatible:
- Existing Excel files that include sub_area will continue to work
- The existing `ejemplo_importacion.xlsx` file still works
- Frontend validation logic remains the same
- Only added stricter backend validation

## Security

- ✅ All user input is validated before database insertion
- ✅ SQL injection protected by prepared statements
- ✅ XSS protection through HTML escaping in frontend
- ✅ File type validation (only .xlsx and .xls accepted)

## Performance

- ✅ No performance impact - template generation is client-side
- ✅ File size is small (< 10KB typically)
- ✅ Uses existing XLSX library (no additional dependencies)

## Future Enhancements

Possible improvements for future versions:
1. Add option to download template with all available cargos/temas pre-filled
2. Include data validation in Excel file itself (dropdown lists)
3. Add import preview with ability to edit before final import
4. Support for bulk update (not just insert)
5. Import history log

## Related Documentation

- `README_IMPORTACION.md` - Detailed import format documentation
- `EXCEL_IMPORT_FIX_SUMMARY.md` - Previous Excel import fixes
- `ejemplo_importacion.xlsx` - Example import file in repository

## Support

For issues or questions:
1. Check error messages in the import modal
2. Verify Excel file format matches template
3. Consult `README_IMPORTACION.md` for detailed field descriptions
4. Check browser console for technical errors
