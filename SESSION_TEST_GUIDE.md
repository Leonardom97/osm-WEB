# Session Management Test Guide

This document provides step-by-step instructions for testing the session management functionality.

## Overview

The session management system has been updated to fix the following issues:
1. Sessions not being properly closed when logging out
2. Session cache not being cleared properly
3. Disconnect button in sesiones.html using wrong field
4. Duplicate logout handling in multiple JS files
5. Session validation issues when browser is closed and reopened

## Test Cases

### Test Case 1: Login and Session Creation

**Objective**: Verify that a session is properly created in the database when a user logs in.

**Steps**:
1. Open the application in a web browser
2. Navigate to `index.html`
3. Enter valid admin credentials
4. Click login button

**Expected Results**:
- User is redirected to `panel.html`
- User name appears in the navbar
- A new record is created in the `adm_sesiones` table with:
  - `activa = TRUE`
  - Valid `session_id`
  - Client IP address
  - Current timestamp in `fecha_inicio` and `fecha_actividad`

**SQL Verification**:
```sql
SELECT * FROM adm_sesiones WHERE activa = TRUE ORDER BY fecha_inicio DESC LIMIT 5;
```

### Test Case 2: Unique Session Enforcement

**Objective**: Verify that only one active session is allowed per user.

**Steps**:
1. Log in as a user (Browser A)
2. Without logging out, open a new browser (Browser B)
3. Try to log in with the same credentials

**Expected Results**:
- Browser B shows a modal/alert: "Ya existe una sesión activa para este usuario"
- Message includes IP address and host of the existing session
- Option to force login is presented
- If force login is clicked:
  - Previous session (Browser A) is marked as `activa = FALSE` with `razon_cierre = 'concurrent_login'`
  - New session is created for Browser B
  - Browser A is notified and redirected to login page on next activity

**SQL Verification**:
```sql
SELECT usuario_id, tipo_usuario, activa, razon_cierre, fecha_cierre 
FROM adm_sesiones 
WHERE usuario_id = [USER_ID] 
ORDER BY fecha_inicio DESC;
```

### Test Case 3: Logout Functionality

**Objective**: Verify that logout properly closes the session in both cache and database.

**Steps**:
1. Log in as a user
2. Verify session is active in database
3. Click "Cerrar sesión" in navbar dropdown
4. Verify redirection to login page

**Expected Results**:
- User is redirected to `index.html`
- Session record in `adm_sesiones` is updated:
  - `activa = FALSE`
  - `razon_cierre = 'logout'`
  - `fecha_cierre` set to current timestamp
- PHP session is destroyed
- Session cookie is deleted
- Attempting to access `panel.html` directly redirects to `index.html`

**SQL Verification**:
```sql
SELECT id, activa, razon_cierre, fecha_cierre 
FROM adm_sesiones 
WHERE id = [SESSION_DB_ID];
```

### Test Case 4: Browser Close/Reopen (Session Persistence)

**Objective**: Verify session handling when browser is closed and reopened.

**Steps**:
1. Log in as a user
2. Note the session ID from developer tools (Application > Cookies)
3. Close the browser completely
4. Reopen the browser
5. Navigate to `panel.html`

**Expected Results** (depends on session cookie lifetime):
- **If session cookie persists**: 
  - User remains logged in
  - Session is validated against database
  - If session is still active in DB, user accesses the page
  - Activity timestamp is updated
- **If session cookie is deleted**:
  - User is redirected to login page
  - Session remains in database but marked inactive after timeout

### Test Case 5: Session Validation on Activity

**Objective**: Verify that session validity is checked on each request.

**Steps**:
1. Log in as User A (Browser A)
2. Open Admin panel in Browser B
3. Navigate to "Gestión de Sesiones" (`sesiones.html`)
4. Find User A's session in the active sessions list
5. Click "Desconectar" button for User A's session
6. In Browser A, click on any menu item or refresh the page

**Expected Results**:
- Admin successfully disconnects User A's session
- Session in database is updated:
  - `activa = FALSE`
  - `razon_cierre = 'admin_disconnect'`
  - `cerrada_por` set to admin's user ID
- Browser A is redirected to login page with message "Tu sesión ha sido cerrada"

**SQL Verification**:
```sql
SELECT id, activa, razon_cierre, cerrada_por 
FROM adm_sesiones 
WHERE usuario_id = [USER_A_ID] 
ORDER BY fecha_inicio DESC LIMIT 1;
```

### Test Case 6: Session Activity Update

**Objective**: Verify that session activity timestamp is updated.

**Steps**:
1. Log in as a user
2. Note the `fecha_actividad` timestamp
3. Wait 1 minute
4. Navigate to a different page (e.g., from panel.html to Usuarios.html)
5. Check the `fecha_actividad` timestamp again

**Expected Results**:
- `fecha_actividad` is updated to the current timestamp
- Session remains `activa = TRUE`

**SQL Verification**:
```sql
SELECT id, fecha_inicio, fecha_actividad, activa 
FROM adm_sesiones 
WHERE id = [SESSION_DB_ID];
```

### Test Case 7: Login Attempt Logging

**Objective**: Verify that all login attempts are logged.

**Steps**:
1. Attempt to log in with incorrect password
2. Attempt to log in with non-existent user
3. Successfully log in with correct credentials

**Expected Results**:
- All three attempts are recorded in `adm_intentos_login` table
- Failed attempts have `exitoso = FALSE` and appropriate `mensaje_error`
- Successful attempt has `exitoso = TRUE`
- Each record includes IP address, user agent, and timestamp

**SQL Verification**:
```sql
SELECT usuario_identificador, tipo_usuario, exitoso, mensaje_error, fecha 
FROM adm_intentos_login 
ORDER BY fecha DESC 
LIMIT 10;
```

### Test Case 8: Admin Session Management Panel

**Objective**: Verify the session management interface works correctly.

**Steps**:
1. Log in as an admin user
2. Navigate to "Gestión de Sesiones" (`sesiones.html`)
3. Verify all three tabs load correctly:
   - Sesiones Activas
   - Intentos de Acceso
   - Mi Historial

**Expected Results**:
- **Sesiones Activas tab**:
  - Shows all active sessions with correct user names, IPs, and timestamps
  - Disconnect button is available for each session
- **Intentos de Acceso tab**:
  - Shows login attempts with filter working (Todos/Exitosos/Fallidos)
  - Failed attempts are highlighted in red
- **Mi Historial tab**:
  - Shows current user's session history
  - Displays session status and closure reason

### Test Case 9: Navbar Integration

**Objective**: Verify navbar.js loads correctly across all pages.

**Steps**:
1. Log in and navigate to different pages:
   - panel.html
   - Usuarios.html
   - sesiones.html
   - m_admin/ed_usuario.html
   - m_capacitaciones/formulario.html
2. On each page, verify:
   - User name appears in navbar
   - Logout button is clickable
   - Clicking logout properly logs out the user

**Expected Results**:
- User name displays correctly on all pages
- Logout functionality works identically on all pages
- No JavaScript errors in browser console

## Manual Testing Checklist

- [ ] Login creates session in database
- [ ] Only one active session per user is enforced
- [ ] Logout closes session in database and clears cache
- [ ] Session cookie is deleted on logout
- [ ] Browser close/reopen handles session correctly
- [ ] Session validation works on page navigation
- [ ] Session activity timestamp updates
- [ ] Login attempts are logged
- [ ] Admin can view and disconnect active sessions
- [ ] Navbar logout works on all pages
- [ ] No JavaScript console errors
- [ ] No PHP errors in server logs

## Database Queries for Troubleshooting

### Check Active Sessions
```sql
SELECT s.*, 
       CASE 
         WHEN s.tipo_usuario = 'admin' THEN u.nombre1 || ' ' || u.apellido1
         WHEN s.tipo_usuario = 'colaborador' THEN c.ac_nombre1 || ' ' || c.ac_apellido1
       END as nombre_usuario
FROM adm_sesiones s
LEFT JOIN adm_usuarios u ON s.usuario_id = u.id AND s.tipo_usuario = 'admin'
LEFT JOIN adm_colaboradores c ON s.usuario_id = c.ac_id AND s.tipo_usuario = 'colaborador'
WHERE s.activa = TRUE;
```

### Check Recent Login Attempts
```sql
SELECT * FROM adm_intentos_login 
ORDER BY fecha DESC 
LIMIT 20;
```

### Check Session History for User
```sql
SELECT * FROM adm_sesiones 
WHERE usuario_id = [USER_ID] AND tipo_usuario = '[admin|colaborador]'
ORDER BY fecha_inicio DESC 
LIMIT 10;
```

### Check Sessions by IP Address
```sql
SELECT * FROM adm_sesiones 
WHERE ip_address = '[IP_ADDRESS]'
ORDER BY fecha_inicio DESC;
```

## Common Issues and Solutions

### Issue: Session not found in database
**Solution**: Check that `sesion_db_id` is stored in PHP session during login. Verify `registerLogin()` is called in login_admin.php and login_colaborador.php.

### Issue: Logout doesn't clear session
**Solution**: Verify logout.php is properly destroying PHP session and updating database. Check that session_destroy() and cookie deletion are executed.

### Issue: User can log in multiple times
**Solution**: Check that `registerLogin()` in session_manager.php properly detects existing active sessions. Verify the query checks for `activa = TRUE`.

### Issue: Session persists after browser close
**Solution**: This may be intentional if session cookies are persistent. Check session configuration in PHP (session.cookie_lifetime).

### Issue: "Desconectar" button doesn't work
**Solution**: Check that button uses `data-session-id="${s.id}"` (not s.session_id) in sesiones.js. Verify session_management_api.php receives correct session ID.

## Security Considerations

1. **Session Fixation**: Session IDs are regenerated on login
2. **Concurrent Sessions**: Only one active session per user is enforced
3. **Session Hijacking**: Session validity is checked on each request
4. **Audit Trail**: All login attempts and session closures are logged
5. **Admin Oversight**: Administrators can view and terminate any active session

## Notes

- Session timeout is set to 120 minutes by default (configurable in closeInactiveSessions())
- Failed login attempts are logged but currently no account lockout mechanism exists
- Session activity is updated on every page load via verificar_sesion.php
- Navbar.js is automatically loaded with navbar.html on all pages
