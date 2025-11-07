// assets/js/date-utils.js
// Utility functions for date handling to avoid timezone issues

/**
 * Parse a date string (YYYY-MM-DD) as a local date.
 * 
 * When PostgreSQL returns a date like "2024-11-03", JavaScript's Date constructor
 * interprets it as UTC midnight, which can cause the date to shift by one day
 * when converted to local time. This function parses it as a local date instead.
 * 
 * @param {string} dateStr - Date string in YYYY-MM-DD format
 * @returns {Date|null} Date object or null if input is invalid
 */
function parseLocalDate(dateStr) {
    if (!dateStr) return null;
    const [year, month, day] = dateStr.split('-').map(Number);
    return new Date(year, month - 1, day);
}

/**
 * Get current date at midnight (00:00:00) for accurate day comparisons.
 * 
 * @returns {Date} Current date at midnight
 */
function getTodayAtMidnight() {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    return today;
}

// Make functions available globally if needed
if (typeof window !== 'undefined') {
    window.parseLocalDate = parseLocalDate;
    window.getTodayAtMidnight = getTodayAtMidnight;
}

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { parseLocalDate, getTodayAtMidnight };
}
