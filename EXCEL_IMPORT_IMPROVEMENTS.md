# Excel Import Error Handling Improvements

## Problem Description

Users reported that the Excel import functionality in programacion.html was failing. While the core functionality was previously fixed, error handling and user feedback needed improvement.

## Improvements Made

### 1. Enhanced Error Messages

**Before**: Generic error messages that didn't help users understand what went wrong.

**After**: Specific, actionable error messages:
- "La librería XLSX no está cargada. Por favor, recargue la página e intente nuevamente."
- "El archivo Excel está vacío o no tiene datos válidos. Por favor, agregue datos al archivo y vuelva a intentar."
- "El archivo solo contiene la fila de encabezado. Por favor agregue filas con datos y vuelva a intentar."

### 2. Better Error Recovery

Added error handling for FileReader operations:
```javascript
reader.onerror = function(error) {
    console.error('FileReader error:', error);
    showAlert('Error al leer el archivo. Por favor, intente nuevamente.', 'danger');
    document.getElementById('inputExcel').value = '';
};
```

This ensures:
- Users are notified when file reading fails
- The file input is reset so users can try again
- Errors don't leave the UI in a broken state

### 3. File Input Reset on Errors

When an error occurs, the file input is now reset:
```javascript
document.getElementById('inputExcel').value = '';
```

This allows users to immediately select a different file without having to manually clear the input.

### 4. Validation Feedback Summary

Added summary messages after processing the Excel file:

**No errors**:
```
"Se procesaron X fila(s) correctamente. Puede proceder con la importación."
```

**Some errors**:
```
"Se procesaron X fila(s) correctamente, pero hay Y fila(s) con errores. 
Puede importar las filas correctas o corregir los errores primero."
```

**All errors**:
```
"No se pudieron procesar los datos del Excel. Se encontraron X error(es). 
Por favor, revise los errores y corrija el archivo."
```

### 5. Better File Validation

Improved validation messages when reading the Excel file:
```javascript
if (!workbook || !workbook.SheetNames || workbook.SheetNames.length === 0) {
    throw new Error('El archivo no contiene hojas válidas');
}
```

## Files Modified

**m_capacitaciones/assets/js/programacion.js**
- Enhanced `handleExcelFile()` function with better error handling
- Added FileReader error handler
- Improved `processExcelData()` with summary feedback messages
- Added file input reset on errors

## Expected Format

The Excel import expects the following format:

| Column A | Column B | Column C | Column D | Column E |
|----------|----------|----------|----------|----------|
| Cargo ID | Sub Área ID | Tema ID | Frecuencia | Rol Capacitador |
| 117 | 003 | 49 | 12 | Capacitador SIE |
| 043 | 016 | 23 | 12 | Capacitador IND |

**Notes**:
- Sub Área ID should use the ID from adm_área table (e.g., 003, 011, 012)
- All fields are required
- Tema ID and Frecuencia must be valid numbers
- Rol Capacitador must match an existing role name in the database

## Impact

These improvements provide:
- Clearer feedback when import fails
- Better guidance on how to fix issues
- More robust error handling
- Improved user experience
- Easier troubleshooting for users

## Testing

Test the import with:
1. Empty Excel files
2. Files with only headers
3. Files with invalid data (missing required fields, invalid IDs)
4. Valid Excel files with correct data
5. Mixed valid/invalid rows

The improved error handling will guide users through fixing any issues.
