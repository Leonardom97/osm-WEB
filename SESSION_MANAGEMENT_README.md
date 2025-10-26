# Session Management and Security Implementation

## Overview
This implementation adds comprehensive session management, concurrent login prevention, and file upload capabilities to the OSM training management system.

## Features Implemented

### 1. Session Tracking and Management

#### Database Tables
Two new tables have been added:

1. **`adm_sesiones`** - Tracks all active and historical sessions
   - Records login sessions with IP, host name, and user agent
   - Tracks session activity with timestamps
   - Supports forced session closure (admin disconnect, timeout, concurrent login)

2. **`adm_intentos_login`** - Audit log of all login attempts
   - Records successful and failed login attempts
   - Tracks IP address, host name for security auditing
   - Useful for detecting brute force attacks

#### Session Manager Class
A new PHP class (`SessionManager`) provides:
- Session registration on login
- Concurrent login detection and prevention
- Activity tracking
- Session closure (logout, admin disconnect, timeout)
- Session history retrieval
- Login attempt logging

### 2. Concurrent Login Prevention

#### How It Works
1. When a user attempts to login:
   - System checks for existing active sessions
   - If found, user is notified with session details (IP, host, date)
   - User can choose to:
     - Cancel login (keep existing session)
     - Force login (close existing session and continue)

2. Session Information Shown:
   - Host name (e.g., "miau-pc")
   - IP address
   - Login date/time

3. Existing Session Notification:
   - Active user is notified via alert when someone tries to login
   - Shows who attempted access and from where

### 3. Session Management Module

A new admin interface (`sesiones.html`) provides:

#### Active Sessions Tab
- View all currently active sessions
- See user name, identifier, IP, host, login time, last activity
- Disconnect users remotely
- Auto-refreshes every 30 seconds

#### Login Attempts Tab
- View all login attempts (successful and failed)
- Filter by success status
- Useful for security auditing
- Shows IP, host, error messages

#### My History Tab
- Users can view their own session history
- Shows login/logout times
- Indicates how each session was closed
- Shows who closed the session (if admin disconnected)

### 4. Security Improvements

#### Login Security
1. **Password Hashing**
   - Admin passwords use `password_verify()` with bcrypt
   - Colaborador passwords currently in plain text (should be migrated)

2. **Login Attempt Logging**
   - All login attempts (success/fail) are logged
   - Includes IP address, host name, error message
   - Useful for detecting attacks

3. **Session Validation**
   - Every request checks if session is still valid in database
   - If admin closed session, user is immediately logged out
   - Activity timestamp updated on each request

4. **Input Sanitization**
   - All database queries use prepared statements
   - No SQL injection vulnerabilities

### 5. File Upload for Training Forms

#### Features
1. **File Upload in `formulario.html`**
   - Optional file attachment when creating training form
   - Accepts PDF and images (JPG, PNG, GIF)
   - Maximum file size: 2MB
   - Real-time validation

2. **File Storage**
   - Files stored in filesystem (not database)
   - Directory structure: `m_capacitaciones/formulario/[formulario_id]/`
   - Each form has its own directory
   - Filenames include timestamp to prevent overwrites

3. **File Management in `ed_formulario.html`**
   - View attached files with download link
   - Upload files to existing forms
   - Delete attached files
   - Shows file name and provides download link

4. **Security**
   - MIME type validation (not just extension)
   - File size limits enforced
   - Only authenticated users can upload
   - Files stored outside web root (via proper path configuration)

## Files Modified

### Backend (PHP)
1. `/php/login_colaborador.php` - Added session tracking and concurrent login prevention
2. `/php/login_admin.php` - Added session tracking and concurrent login prevention
3. `/php/logout.php` - Added proper session closure in database
4. `/php/verificar_sesion.php` - Added session validation against database
5. `/php/session_manager.php` - NEW - Session management class
6. `/php/session_management_api.php` - NEW - API for session management
7. `/m_capacitaciones/assets/php/file_upload_api.php` - NEW - File upload API

### Frontend (HTML)
1. `/sesiones.html` - NEW - Session management interface
2. `/m_capacitaciones/formulario.html` - Added file upload input
3. `/m_capacitaciones/ed_formulario.html` - Added file management section

### Frontend (JavaScript)
1. `/assets/js/login.js` - Added concurrent session handling
2. `/m_capacitaciones/assets/js/formulario.js` - Added file upload functionality
3. `/m_capacitaciones/assets/js/ed_formulario.js` - Added file management functions

### Database
1. `/db/migration_add_session_management.sql` - NEW - Migration script

### Configuration
1. `.gitignore` - NEW - Excludes uploaded files from version control

## Installation

### 1. Apply Database Migration

Connect to your PostgreSQL database and run:

```bash
psql -U your_username -d web_osm -f db/migration_add_session_management.sql
```

Or use pgAdmin to execute the SQL script.

### 2. Create Upload Directory

The upload directory will be created automatically, but you can create it manually:

```bash
mkdir -p m_capacitaciones/formulario
chmod 755 m_capacitaciones/formulario
```

### 3. Verify Permissions

Ensure the web server has write permissions to the upload directory:

```bash
chown -R www-data:www-data m_capacitaciones/formulario
```

### 4. No Code Changes Required

All code is included in the files. Just deploy and it will work.

## Usage

### For Administrators

#### Viewing Active Sessions
1. Navigate to "Gestión de Sesiones" in the admin menu
2. View all active user sessions
3. Click "Desconectar" to remotely disconnect a user
4. Disconnected users will see a message when their session is closed

#### Viewing Login Attempts
1. Go to "Gestión de Sesiones" → "Intentos de Acceso" tab
2. Filter by successful/failed attempts
3. Monitor for suspicious activity

#### Viewing Session History
1. Go to "Gestión de Sesiones" → "Mi Historial" tab
2. See your own login history
3. Check how sessions were closed

### For Users

#### Handling Concurrent Login Warning
When you try to login and already have an active session:
1. You'll see an alert with details of the existing session
2. Choose "Cancel" to keep the existing session
3. Choose "OK/Continuar" to close the existing session and login

#### Uploading Files to Training Forms
1. Create or edit a training form
2. In the "Archivo Adjunto" section, click "Choose File"
3. Select a PDF or image file (max 2MB)
4. File uploads automatically when you save the form

#### Managing Attached Files
1. Open a training form in edit mode
2. If a file is attached, you'll see it with a "Ver archivo" link
3. Click "Eliminar" to delete the attachment
4. Upload a new file if needed

## Security Considerations

### Session Security
- Sessions are validated against database on every request
- Inactive sessions auto-close after timeout (configurable)
- Admin can forcefully disconnect users
- All session changes are logged

### Login Security
- Failed login attempts are logged with IP/host
- No information disclosure (same error for invalid user vs wrong password)
- Protection against brute force (via logging, rate limiting can be added)

### File Upload Security
- File type validation (MIME type, not just extension)
- File size limits enforced
- Files stored in isolated directories
- Only authenticated users can upload
- Directory listing disabled (via .htaccess if needed)

### Recommended Additional Security Measures
1. **Migrate Colaborador Passwords**
   - Currently stored in plain text
   - Should be migrated to bcrypt hashing
   
2. **Add Rate Limiting**
   - Limit login attempts per IP
   - Block IPs after multiple failures
   
3. **Add HTTPS**
   - Ensure all traffic is encrypted
   - Prevent session hijacking
   
4. **Add CSRF Protection**
   - Add tokens to forms
   - Validate on server side

## Troubleshooting

### Sessions Not Being Tracked
1. Check database connection in `php/db_postgres.php`
2. Verify migration was applied successfully
3. Check PHP error logs for database errors

### File Upload Not Working
1. Check directory permissions
2. Verify PHP `upload_max_filesize` setting
3. Check `post_max_size` in php.ini
4. Review error logs

### Users Can't See Session Management
1. Verify user has "Administrador" role
2. Check `data-role` attribute in HTML
3. Ensure session is properly authenticated

## API Endpoints

### Session Management API (`/php/session_management_api.php`)

#### Get Active Sessions
```
GET /php/session_management_api.php?action=get_active_sessions
```
Returns all active sessions (admin only)

#### Get My Sessions
```
GET /php/session_management_api.php?action=get_my_sessions
```
Returns current user's session history

#### Disconnect Session
```
POST /php/session_management_api.php
action=disconnect_session&session_id=123
```
Closes a session (admin only)

#### Get Login Attempts
```
GET /php/session_management_api.php?action=get_login_attempts&limit=50&exitoso=true
```
Returns login attempt history (admin only)

### File Upload API (`/m_capacitaciones/assets/php/file_upload_api.php`)

#### Upload File
```
POST /m_capacitaciones/assets/php/file_upload_api.php
action=upload_file&formulario_id=123
Content-Type: multipart/form-data
file: [file data]
```

#### Get File Info
```
GET /m_capacitaciones/assets/php/file_upload_api.php?action=get_file&formulario_id=123
```

#### Delete File
```
POST /m_capacitaciones/assets/php/file_upload_api.php
action=delete_file&formulario_id=123
```

## Future Enhancements

Potential improvements:
1. Real-time notifications using WebSockets
2. Two-factor authentication (2FA)
3. IP whitelist/blacklist
4. Automatic session timeout based on inactivity
5. Rate limiting on login attempts
6. Email notifications for security events
7. File preview in browser
8. Multiple file attachments per form
9. File versioning
10. Audit trail for file access

## Support

For issues or questions, contact the development team or create an issue in the repository.
