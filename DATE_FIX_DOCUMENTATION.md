# Date Display Fix - Timezone Issue

## Problem Description

The "última capacitación" (last training) column in dashboard.html was showing dates one day earlier than the actual date stored in the database.

### Root Cause

When JavaScript creates a date using `new Date("2024-01-15")`, it interprets the date string as UTC midnight (00:00:00 UTC). When this is converted to local time in Colombia (UTC-5), it becomes 19:00:00 (7 PM) on the **previous day** (2024-01-14). This causes dates to display as one day earlier than they should.

## Solution

Created a `formatDateLocal()` helper function that:
1. Parses date components (year, month, day) separately from the date string
2. Creates a Date object in the local timezone (not UTC)
3. Formats the date using `toLocaleDateString('es-CO')`

This ensures the date is interpreted as midnight in the local timezone, not UTC, preventing the off-by-one-day error.

## Implementation

### Function Added

```javascript
// Helper function to format dates without timezone offset issues
// Parses date string in local timezone to avoid UTC conversion issues
function formatDateLocal(dateString) {
    if (!dateString) return null;
    
    // Parse date components to avoid timezone issues
    // Date from DB is in format YYYY-MM-DD
    const parts = dateString.split('T')[0].split('-');
    const year = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1; // months are 0-indexed
    const day = parseInt(parts[2], 10);
    
    // Create date in local timezone
    const date = new Date(year, month, day);
    
    // Format as local date string
    return date.toLocaleDateString('es-CO');
}
```

### Files Modified

1. **m_capacitaciones/assets/js/dashboard.js**
   - Added `formatDateLocal()` helper function
   - Updated all date displays in table rendering
   - Updated date formatting in Excel export functions

2. **m_capacitaciones/assets/js/programacion.js**
   - Added `formatDateLocal()` helper function
   - Updated date displays in table rendering

3. **m_capacitaciones/assets/js/modulo_malla.js**
   - Added `formatDateLocal()` helper function
   - Updated date displays in table rendering and Excel export

## Impact

This fix ensures that:
- "Última Capacitación" (last training date) displays correctly
- "Próxima Capacitación" (next training date) displays correctly
- All date fields show the correct date as stored in the database
- Excel exports contain the correct dates
- No timezone-related date shifts occur

## Testing

The fix has been tested with various date formats and ensures consistent, correct date display across all training-related pages in the application.

## Related Issues

- Date display showing one day less than actual in training records
- Timezone conversion causing incorrect date rendering in Colombian time zone (UTC-5)
