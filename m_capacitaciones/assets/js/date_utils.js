// assets/js/date_utils.js
// Shared date utility functions for the training module

/**
 * Format dates without timezone offset issues
 * Parses date string in local timezone to avoid UTC conversion issues
 * 
 * @param {string} dateString - Date string in format YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS
 * @returns {string|null} Formatted date string in es-CO locale or null if input is empty
 * 
 * Problem: When JavaScript creates a date using new Date("2024-01-15"), 
 * it interprets the date string as UTC midnight (00:00:00 UTC). 
 * When this is converted to local time in Colombia (UTC-5), 
 * it becomes 19:00:00 (7 PM) on the previous day (2024-01-14).
 * 
 * Solution: Parse date components separately and create a Date object 
 * in the local timezone to prevent timezone conversion issues.
 */
function formatDateLocal(dateString) {
    if (!dateString) return null;
    
    // Parse date components to avoid timezone issues
    // Date from DB is in format YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS
    const dateOnly = dateString.includes('T') ? dateString.split('T')[0] : dateString;
    const parts = dateOnly.split('-');
    const year = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1; // months are 0-indexed
    const day = parseInt(parts[2], 10);
    
    // Create date in local timezone
    const date = new Date(year, month, day);
    
    // Format as local date string
    return date.toLocaleDateString('es-CO');
}

// Export for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { formatDateLocal };
}
