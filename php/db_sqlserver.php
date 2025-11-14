<?php
if (basename(__FILE__) == basename($_SERVER['SCRIPT_FILENAME'])) {
    http_response_code(403);
    exit('Acceso prohibido');
}

// Load configuration
require_once __DIR__ . '/config.php';

$serverName = DB_SQLSRV_HOST;
$database   = DB_SQLSRV_NAME;
$username   = DB_SQLSRV_USER;
$password   = DB_SQLSRV_PASSWORD;
$port       = DB_SQLSRV_PORT;

try {
    // Agregamos TrustServerCertificate=true para evitar el error SSL
    $dsn = "sqlsrv:Server=$serverName,$port;Database=$database;TrustServerCertificate=true";

    $sqlsrv = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    if (ENABLE_DEBUG) {
        echo "✅ Conexión exitosa a SQL Server.";
    }

} catch (PDOException $e) {
    // Log error securely without exposing details
    error_log("SQL Server connection error: " . $e->getMessage());
    
    // Don't expose database details in error message
    if (ENABLE_DEBUG) {
        die("❌ Error al conectar a SQL Server: " . $e->getMessage());
    } else {
        die("❌ Error al conectar a la base de datos. Contacte al administrador.");
    }
}
?>
