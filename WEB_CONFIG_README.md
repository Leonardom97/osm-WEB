# Web Configuration Management Module

## Overview
This module provides centralized management of website-wide configuration including:
- Site title
- Footer copyright text
- Favicon (site icon)
- Login page image
- Primary theme color
- Theme presets (up to 3 saved configurations)

## Database Setup

### 1. Run Migration Script
Execute the migration script to create the required database table:

```sql
-- Run this in PostgreSQL
\i db/migration_adm_webmain.sql
```

Or manually connect to your database and execute:
```bash
psql -U postgres -d osm2 -f db/migration_adm_webmain.sql
```

### 2. Table Structure
The `adm_webmain` table includes:
- `id`: Primary key
- `site_title`: Website title (max 100 chars)
- `footer_text`: Footer copyright text (max 200 chars)
- `favicon_path`: Path to favicon image
- `login_image_path`: Path to login page image
- `primary_color`: Hex color code for theme (e.g., #772e22)
- `is_active`: Boolean flag for active configuration
- `theme_name`: Descriptive name for the theme
- `created_at`: Timestamp of creation
- `updated_at`: Timestamp of last update

## Features

### 1. Dynamic Configuration Loading
All pages automatically load and apply configuration from the database:
- Page titles are updated
- Favicons are dynamically set
- Footer text is replaced across all pages
- Login image is updated
- Theme colors are applied

### 2. Theme Management
- Save up to 3 different theme configurations
- Switch between saved themes instantly
- Create new themes based on current settings
- Only one theme can be active at a time

### 3. Color Theme System
The primary color automatically generates:
- Hover states (10% darker)
- Active states (20% darker)
- Focus ring colors (25% opacity)
- Background variants
- Bootstrap color variables
- All button states
- Sidebar colors
- Link colors
- Pagination colors

### 4. File Upload System
Secure image upload with:
- File type validation (JPG, PNG, GIF, WEBP)
- Size limit (5MB max)
- Unique filename generation
- Preview before saving

## Access Control

**IMPORTANT**: Only users with the "Administrador" role can:
- Access the configuration page (`/includes/web_main.html`)
- Use the Web Configuration API
- Upload images

All API endpoints check session and role before processing requests.

## Usage

### For Administrators

1. **Access Configuration Page**
   - Navigate to: Administrador → Configuración Web
   - Or directly: `/includes/web_main.html`

2. **Update Site Settings**
   - Modify any field in the form
   - Upload new images if desired
   - Choose a new primary color
   - Click "Guardar Configuración"

3. **Manage Themes**
   - View saved themes at the bottom
   - Click "Guardar como Nuevo Tema" to save current settings
   - Click "Aplicar" on any theme card to activate it

4. **Upload Images**
   - Click the file input to select an image
   - Click "Subir" to upload
   - The path will be automatically filled
   - Preview appears below the input

### For Developers

#### Including in New Pages
Add this script tag before `</body>`:
```html
<script src="../assets/js/web_config.js"></script>
```

Adjust path based on directory depth:
- Root level: `src="assets/js/web_config.js"`
- One level deep: `src="../assets/js/web_config.js"`
- Two levels deep: `src="../../assets/js/web_config.js"`

#### Manual Configuration Loading
```javascript
// Load configuration manually
await WebConfig.load();

// Get current configuration
const config = WebConfig.get();

// Apply configuration manually
WebConfig.apply(configObject);
```

## API Endpoints

### GET /php/web_main_api.php
**Query Parameters:**
- `action=get_active`: Get active configuration
- `action=get_all`: Get all saved themes (max 3)
- `action=get_by_id&id={id}`: Get specific configuration

**Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "site_title": "OSM",
    "footer_text": "© OSM 2025",
    "favicon_path": "assets/img/Sin título-2.png",
    "login_image_path": "assets/img/ico.jpg",
    "primary_color": "#772e22",
    "is_active": true,
    "theme_name": "Default"
  }
}
```

### POST /php/web_main_api.php
Create new theme configuration.

**Request Body:**
```json
{
  "site_title": "OSM",
  "footer_text": "© OSM 2025",
  "favicon_path": "assets/img/favicon.png",
  "login_image_path": "assets/img/login.jpg",
  "primary_color": "#772e22",
  "is_active": false,
  "theme_name": "Summer Theme"
}
```

### PUT /php/web_main_api.php
Update existing configuration.

**Request Body:**
```json
{
  "id": 1,
  "site_title": "OSM Platform",
  "footer_text": "© OSM 2025",
  "favicon_path": "assets/img/favicon.png",
  "login_image_path": "assets/img/login.jpg",
  "primary_color": "#8b3a2c",
  "is_active": true,
  "theme_name": "Updated Theme"
}
```

### POST /php/web_main_upload.php
Upload image file.

**Form Data:**
- `file`: Image file (JPG, PNG, GIF, WEBP)
- `upload_type`: "favicon" or "login_image"

**Response:**
```json
{
  "success": true,
  "message": "Archivo subido exitosamente",
  "path": "assets/img/uploads/favicon_1698345678.png",
  "filename": "favicon_1698345678.png"
}
```

## File Structure

```
/home/runner/work/osm-WEB/osm-WEB/
├── db/
│   └── migration_adm_webmain.sql       # Database migration
├── php/
│   ├── web_main_api.php                # API for configuration CRUD
│   └── web_main_upload.php             # File upload handler
├── assets/
│   ├── js/
│   │   ├── web_config.js               # Dynamic config loader
│   │   └── web_main_manager.js         # Admin interface logic
│   └── img/
│       └── uploads/                    # Uploaded images directory
│           ├── .gitignore              # Ignore uploaded files
│           └── .gitkeep                # Keep directory in git
└── includes/
    └── web_main.html                   # Admin configuration page
```

## Security Considerations

1. **Role-Based Access**: Only administrators can access configuration
2. **File Upload Validation**: 
   - Type checking (MIME type)
   - Size limits (5MB)
   - Secure filename generation
3. **SQL Injection Prevention**: All queries use prepared statements
4. **Session Validation**: All requests verify active session
5. **XSS Prevention**: Output is properly escaped

## Troubleshooting

### Configuration Not Loading
1. Check browser console for errors
2. Verify `/php/web_main_api.php` is accessible
3. Check database connection in `/php/db_postgres.php`
4. Ensure `adm_webmain` table exists

### Images Not Displaying
1. Verify file was uploaded successfully
2. Check path in database matches actual file location
3. Ensure proper file permissions on uploads directory
4. Check browser console for 404 errors

### Color Changes Not Applying
1. Clear browser cache
2. Check if custom CSS is overriding dynamic styles
3. Verify `primary_color` field has valid hex color

### Cannot Access Configuration Page
1. Verify logged in as administrator
2. Check session is active
3. Verify role name matches "Administrador" exactly

## Default Configuration

The system includes a default configuration:
- **Site Title**: OSM
- **Footer Text**: © OSM 2025
- **Favicon**: assets/img/Sin título-2.png
- **Login Image**: assets/img/ico.jpg
- **Primary Color**: #772e22

This configuration is automatically created during migration and used as fallback if database is unavailable.

## Testing Checklist

- [ ] Database migration runs successfully
- [ ] Configuration page accessible by admin only
- [ ] Non-admin users cannot access configuration
- [ ] Current configuration loads on page
- [ ] Form updates configuration correctly
- [ ] File upload works for both icon and login image
- [ ] Color picker updates theme colors
- [ ] Theme presets can be saved (max 3)
- [ ] Saved themes can be activated
- [ ] Active theme applies across all pages
- [ ] Footer text updates on all pages
- [ ] Page titles update correctly
- [ ] Favicon changes in browser tab
- [ ] Login page image updates
- [ ] No visual breaks or layout issues
- [ ] Configuration persists after page reload

## Support

For issues or questions, contact the development team or create an issue in the repository.
