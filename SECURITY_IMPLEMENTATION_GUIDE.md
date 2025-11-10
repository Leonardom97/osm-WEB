# Security Implementation Guide for Developers

Quick reference guide for implementing security features in the osm-WEB application.

## Table of Contents
1. [Environment Variables](#environment-variables)
2. [Security Headers](#security-headers)
3. [CSRF Protection](#csrf-protection)
4. [File Uploads](#file-uploads)
5. [Database Queries](#database-queries)
6. [Error Handling](#error-handling)
7. [Common Pitfalls](#common-pitfalls)

---

## Environment Variables

### Using Configuration Values

**Always use environment variables for sensitive data:**

```php
// ✅ CORRECT - Use config.php
require_once __DIR__ . '/config.php';

$host = DB_PG_HOST;
$dbname = DB_PG_NAME;
$user = DB_PG_USER;
$password = DB_PG_PASSWORD;

// ❌ WRONG - Never hardcode credentials
$host = 'localhost';
$password = 'mysecretpassword';
```

### Available Configuration Constants

```php
// Database - PostgreSQL
DB_PG_HOST
DB_PG_PORT
DB_PG_NAME
DB_PG_USER
DB_PG_PASSWORD

// Database - SQL Server
DB_SQLSRV_HOST
DB_SQLSRV_PORT
DB_SQLSRV_NAME
DB_SQLSRV_USER
DB_SQLSRV_PASSWORD

// Application
SESSION_TIMEOUT
UPLOAD_MAX_SIZE
ENABLE_DEBUG
```

### Custom Configuration Values

Add to `php/config.php`:

```php
define('MY_CONFIG', env('MY_CONFIG', 'default_value'));
```

Add to `.env`:
```
MY_CONFIG=production_value
```

---

## Security Headers

### Applying Security Headers to PHP Files

**Include at the top of every PHP endpoint:**

```php
<?php
// Apply security headers first
require_once __DIR__ . '/path/to/php/security_headers.php';

// Then your code
session_start();
// ... rest of code
```

### What This Provides

- **X-Frame-Options**: Prevents clickjacking
- **X-Content-Type-Options**: Prevents MIME sniffing
- **X-XSS-Protection**: Browser XSS protection
- **Referrer-Policy**: Controls referrer information
- **Content-Security-Policy**: Restricts resource loading
- **Permissions-Policy**: Controls browser features
- **Error handling**: Automatic production/development mode

### Customizing CSP

If you need to allow additional sources, edit `php/security_headers.php`:

```php
$csp = "default-src 'self'; " .
       "script-src 'self' https://trusted-cdn.com; " .
       "style-src 'self' https://trusted-cdn.com;";
```

---

## CSRF Protection

### Adding CSRF to Forms

**HTML Forms:**

```html
<form method="POST" action="submit.php">
    <?php
    require_once 'php/csrf_protection.php';
    echo CSRFProtection::getTokenField();
    ?>
    
    <input type="text" name="data">
    <button type="submit">Submit</button>
</form>
```

**JavaScript/AJAX:**

```html
<!-- In HTML head -->
<head>
    <?php
    require_once 'php/csrf_protection.php';
    echo CSRFProtection::getTokenMeta();
    ?>
</head>
```

```javascript
// In JavaScript
const token = document.querySelector('meta[name="csrf-token"]').content;

fetch('/api/endpoint', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': token
    },
    body: JSON.stringify(data)
});
```

### Validating CSRF Tokens

**In your PHP endpoint:**

```php
<?php
require_once __DIR__ . '/csrf_protection.php';

// Require valid token or terminate with 403
CSRFProtection::requireToken();

// Continue with your logic
// ...
```

**Or manual validation:**

```php
<?php
require_once __DIR__ . '/csrf_protection.php';

if (!CSRFProtection::validateToken()) {
    http_response_code(403);
    echo json_encode(['error' => 'Invalid CSRF token']);
    exit;
}

// Continue with your logic
```

### When to Use CSRF Protection

✅ **Always protect:**
- POST requests that modify data
- PUT/DELETE requests
- File uploads
- Administrative actions
- User account changes

❌ **Not needed for:**
- GET requests (if properly implemented as read-only)
- Public APIs with API key authentication
- Webhook endpoints

---

## File Uploads

### Secure File Upload Implementation

**Complete example:**

```php
<?php
require_once __DIR__ . '/security_headers.php';
require_once __DIR__ . '/config.php';

session_start();

// Check authentication
if (!isset($_SESSION['usuario_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'No autorizado']);
    exit;
}

// Configuration
$uploadDir = __DIR__ . '/../uploads/';
$allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];
$allowedMimeTypes = [
    'image/jpeg',
    'image/png',
    'application/pdf'
];
$maxSize = UPLOAD_MAX_SIZE; // From config

try {
    if (!isset($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
        throw new Exception('Error al subir archivo');
    }
    
    $file = $_FILES['file'];
    
    // 1. Check file size
    if ($file['size'] > $maxSize) {
        throw new Exception('Archivo demasiado grande');
    }
    
    // 2. Validate extension
    $extension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($extension, $allowedExtensions)) {
        throw new Exception('Tipo de archivo no permitido');
    }
    
    // 3. Validate MIME type (using finfo, not $_FILES['type'])
    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $file['tmp_name']);
    finfo_close($finfo);
    
    if (!in_array($mimeType, $allowedMimeTypes)) {
        throw new Exception('Tipo de archivo inválido');
    }
    
    // 4. Additional validation for images
    if (in_array($extension, ['jpg', 'jpeg', 'png'])) {
        $imageInfo = @getimagesize($file['tmp_name']);
        if ($imageInfo === false) {
            throw new Exception('Archivo no es una imagen válida');
        }
    }
    
    // 5. Generate secure filename
    $timestamp = time();
    $randomString = bin2hex(random_bytes(8));
    $filename = 'upload_' . $timestamp . '_' . $randomString . '.' . $extension;
    $targetPath = $uploadDir . $filename;
    
    // 6. Create directory if needed
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }
    
    // 7. Ensure .htaccess exists
    $htaccessPath = $uploadDir . '.htaccess';
    if (!file_exists($htaccessPath)) {
        $htaccessContent = "# Prevent script execution\n" .
                           "<FilesMatch \"\\.(php|php3|php4|php5|phtml)$\">\n" .
                           "    Order Allow,Deny\n" .
                           "    Deny from all\n" .
                           "</FilesMatch>\n";
        file_put_contents($htaccessPath, $htaccessContent);
    }
    
    // 8. Move uploaded file
    if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
        throw new Exception('Error al guardar archivo');
    }
    
    // 9. Set restrictive permissions
    chmod($targetPath, 0644);
    
    // 10. Log success
    error_log("File uploaded by user {$_SESSION['usuario_id']}: $filename");
    
    echo json_encode([
        'success' => true,
        'filename' => $filename
    ]);
    
} catch (Exception $e) {
    error_log("File upload error: " . $e->getMessage());
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
```

### Upload Directory Security

**Always include .htaccess in upload directories:**

```apache
# Prevent script execution
<FilesMatch "\.(php|php3|php4|php5|phtml|pl|py|jsp|asp|htm|shtml|sh|cgi)$">
    Order Allow,Deny
    Deny from all
</FilesMatch>

# Prevent access to hidden files
<FilesMatch "^\.">
    Order Allow,Deny
    Deny from all
</FilesMatch>

# Only allow specific file types
<FilesMatch "\.(jpg|jpeg|png|gif|pdf)$">
    Order Allow,Deny
    Allow from all
</FilesMatch>
```

---

## Database Queries

### Always Use Parameterized Queries

**✅ CORRECT - Parameterized query:**

```php
$stmt = $pg->prepare("SELECT * FROM users WHERE id = :id");
$stmt->execute([':id' => $user_id]);
$result = $stmt->fetch();
```

**❌ WRONG - String concatenation:**

```php
// NEVER DO THIS - SQL Injection vulnerability!
$stmt = $pg->query("SELECT * FROM users WHERE id = $user_id");
```

### Dynamic Table/Column Names

**If you must use dynamic table/column names, use a whitelist:**

```php
// ✅ CORRECT - Whitelist validation
$allowedTables = ['users', 'products', 'orders'];
$allowedColumns = ['id', 'name', 'email'];

$table = $_GET['table'];
$column = $_GET['column'];

if (!in_array($table, $allowedTables)) {
    http_response_code(400);
    die(json_encode(['error' => 'Invalid table']));
}

if (!in_array($column, $allowedColumns)) {
    http_response_code(400);
    die(json_encode(['error' => 'Invalid column']));
}

// Now safe to use in query
$stmt = $pg->prepare("SELECT $column FROM $table WHERE id = :id");
$stmt->execute([':id' => $id]);
```

**❌ WRONG - No validation:**

```php
// SQL Injection vulnerability!
$table = $_GET['table'];
$stmt = $pg->query("SELECT * FROM $table");
```

### Complex Queries

**Use named parameters for clarity:**

```php
$stmt = $pg->prepare("
    SELECT * FROM users 
    WHERE email = :email 
    AND created_at > :start_date 
    AND status = :status
");

$stmt->execute([
    ':email' => $email,
    ':start_date' => $startDate,
    ':status' => $status
]);
```

---

## Error Handling

### Production vs Development

The `security_headers.php` file automatically configures error handling based on `ENABLE_DEBUG`.

**Development (.env):**
```
ENABLE_DEBUG=true
```
- Errors displayed on screen
- Detailed error messages
- Stack traces visible

**Production (.env):**
```
ENABLE_DEBUG=false
```
- Errors hidden from users
- Generic error messages
- Errors logged to `logs/php_errors.log`

### Secure Error Messages

**✅ CORRECT - Generic user message, detailed log:**

```php
try {
    // Database operation
    $stmt = $pg->prepare("SELECT * FROM users WHERE id = :id");
    $stmt->execute([':id' => $id]);
} catch (PDOException $e) {
    // Log detailed error
    error_log("Database error in " . __FILE__ . ": " . $e->getMessage());
    
    // Show generic message to user
    http_response_code(500);
    echo json_encode(['error' => 'Error del servidor']);
    exit;
}
```

**❌ WRONG - Exposing details:**

```php
catch (PDOException $e) {
    // Never expose database details!
    echo "Database error: " . $e->getMessage();
}
```

### Logging Best Practices

```php
// Log with context
error_log(sprintf(
    "User %s attempted action %s with result: %s",
    $_SESSION['usuario_id'],
    $action,
    $result
));

// Log security events
error_log("SECURITY: Failed login attempt for user: " . $username);

// Log file operations
error_log("File uploaded: $filename by user " . $_SESSION['usuario_id']);
```

---

## Common Pitfalls

### 1. Trusting User Input

**❌ NEVER trust user input directly:**

```php
// WRONG - Trusting file extension from filename
$ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);

// WRONG - Trusting MIME type from browser
$mime = $_FILES['file']['type'];

// WRONG - Using user input in file paths
$path = '/uploads/' . $_GET['filename'];
```

**✅ Always validate and sanitize:**

```php
// Check actual file content
$finfo = finfo_open(FILEINFO_MIME_TYPE);
$mime = finfo_file($finfo, $_FILES['file']['tmp_name']);

// Validate against whitelist
if (!in_array($mime, $allowedTypes)) {
    reject();
}

// Generate secure filename
$filename = bin2hex(random_bytes(16)) . '.' . $extension;
```

### 2. Information Disclosure

**❌ Revealing too much:**

```php
echo "Error: Failed to connect to database 'production_db' on host '192.168.1.100'";
```

**✅ Generic messages:**

```php
error_log("Database connection error: " . $e->getMessage());
echo "Error del servidor. Contacte al administrador.";
```

### 3. Weak File Upload Validation

**❌ Checking only extension:**

```php
$ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
if ($ext === 'jpg') {
    move_uploaded_file(...);  // Dangerous!
}
```

**✅ Multiple validation layers:**

1. Extension check
2. MIME type check (using finfo)
3. Content validation (getimagesize for images)
4. File size check
5. Filename sanitization
6. Execution prevention (.htaccess)

### 4. SQL Injection via Dynamic Queries

**❌ Building queries with string concatenation:**

```php
$query = "SELECT * FROM " . $_GET['table'] . " WHERE id = " . $_GET['id'];
$pg->query($query);  // SQL Injection!
```

**✅ Whitelist + Parameterization:**

```php
$allowedTables = ['users', 'products'];
$table = $_GET['table'];

if (!in_array($table, $allowedTables)) {
    die('Invalid table');
}

$stmt = $pg->prepare("SELECT * FROM $table WHERE id = :id");
$stmt->execute([':id' => $_GET['id']]);
```

### 5. Missing Authorization Checks

**❌ Only checking authentication:**

```php
if (!isset($_SESSION['usuario_id'])) {
    die('Not authenticated');
}
// Anyone authenticated can access!
```

**✅ Check both authentication and authorization:**

```php
if (!isset($_SESSION['usuario_id'])) {
    die('Not authenticated');
}

if ($_SESSION['rol_nombre'] !== 'Administrador') {
    die('Not authorized');
}
// Only administrators can access
```

### 6. Session Fixation

**✅ Regenerate session ID after login:**

```php
// After successful login
session_regenerate_id(true);
$_SESSION['usuario_id'] = $user_id;
$_SESSION['rol_nombre'] = $rol;
```

---

## Quick Security Checklist for New Code

Before submitting a pull request, verify:

- [ ] No hardcoded credentials or secrets
- [ ] All database queries use parameterized statements
- [ ] User input is validated against whitelists
- [ ] File uploads have multiple validation layers
- [ ] Error messages don't expose sensitive information
- [ ] Security headers are included
- [ ] CSRF protection is implemented (for state-changing operations)
- [ ] Authentication and authorization checks are in place
- [ ] Sensitive operations are logged
- [ ] Production mode (`ENABLE_DEBUG=false`) has been tested

---

## Resources

- **Security Audit Report:** `SECURITY_AUDIT_REPORT.md`
- **Deployment Checklist:** `SECURITY_DEPLOYMENT_CHECKLIST.md`
- **Configuration Example:** `.env.example`
- **OWASP Top 10:** https://owasp.org/www-project-top-ten/
- **PHP Security Cheatsheet:** https://cheatsheetseries.owasp.org/cheatsheets/PHP_Configuration_Cheat_Sheet.html

---

## Getting Help

If you're unsure about security implications:

1. Refer to this guide and the security audit report
2. Check OWASP guidelines
3. Ask for security review before merging
4. When in doubt, be more restrictive

**Remember:** Security is not optional. Every developer is responsible for writing secure code.
