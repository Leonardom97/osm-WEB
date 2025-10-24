<?php
session_start();
header('Content-Type: application/json');

require_once __DIR__ . '/db_postgres.php';
require_once __DIR__ . '/session_manager.php';

// Si no hay sesión activa
if (!isset($_SESSION['usuario_id'])) {
    echo json_encode(['success' => false, 'message' => 'Sesión no iniciada']);
    exit;
}

// Initialize session manager
$sessionManager = new SessionManager($pg);

// Check if session is still valid in database
if (isset($_SESSION['sesion_db_id'])) {
    if (!$sessionManager->isSessionValid($_SESSION['sesion_db_id'])) {
        // Session was closed (possibly by admin or concurrent login)
        session_unset();
        session_destroy();
        
        // Delete the session cookie
        if (isset($_COOKIE[session_name()])) {
            setcookie(session_name(), '', time() - 3600, '/');
        }
        
        echo json_encode([
            'success' => false, 
            'message' => 'Tu sesión ha sido cerrada',
            'session_closed' => true
        ]);
        exit;
    }
    
    // Update activity timestamp to keep session alive
    $sessionManager->updateActivity($_SESSION['sesion_db_id']);
} else {
    // If sesion_db_id is missing but PHP session exists, this could be an old session
    // Try to find or create the database session record
    $tipo_usuario = $_SESSION['tipo_usuario'] ?? 'admin';
    $usuario_id = $_SESSION['usuario_id'];
    $cedula = $_SESSION['usuario'] ?? '';
    
    // Check if there's an active session in the database
    $stmt = $pg->prepare("
        SELECT id FROM adm_sesiones
        WHERE usuario_id = :usuario_id 
        AND tipo_usuario = :tipo_usuario
        AND activa = TRUE
        AND session_id = :session_id
        ORDER BY fecha_actividad DESC
        LIMIT 1
    ");
    $stmt->execute([
        ':usuario_id' => $usuario_id,
        ':tipo_usuario' => $tipo_usuario,
        ':session_id' => session_id()
    ]);
    $existingSession = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($existingSession) {
        // Found existing session, link it to PHP session
        $_SESSION['sesion_db_id'] = $existingSession['id'];
        $sessionManager->updateActivity($existingSession['id']);
    } else {
        // No matching session found - close any active sessions and create new one
        $sessionResult = $sessionManager->forceLogin($usuario_id, $tipo_usuario, $cedula);
        if ($sessionResult['success']) {
            $_SESSION['sesion_db_id'] = $sessionResult['session_db_id'];
        } else {
            // Failed to create session, logout
            session_unset();
            session_destroy();
            echo json_encode(['success' => false, 'message' => 'Error al validar sesión']);
            exit;
        }
    }
}

try {
    // Usuarios NO colaboradores (administradores u otros con roles en adm_usuario_roles)
    if (($_SESSION['tipo_usuario'] ?? '') !== 'colaborador') {
        $id_usuario = $_SESSION['usuario_id'];

        // Obtener roles desde la tabla intermedia
        $stmtRoles = $pg->prepare("
            SELECT r.id, r.nombre
            FROM adm_usuario_roles ur
            JOIN adm_roles r ON ur.rol_id = r.id
            WHERE ur.usuario_id = :id
        ");
        $stmtRoles->execute([':id' => $id_usuario]);
        $roles = $stmtRoles->fetchAll(PDO::FETCH_ASSOC);

        // Guardar roles en la sesión (por seguridad)
        $_SESSION['roles'] = $roles;
        $rolPrincipal = $_SESSION['rol'] ?? ($roles[0]['nombre'] ?? 'admin');

        echo json_encode([
            'success' => true,
            'usuario' => $_SESSION['usuario'],
            'nombre'  => $_SESSION['nombre'],
            'roles'   => $roles,
            'rol'     => $rolPrincipal
        ]);
    }
    // Colaborador
    else {
        // Usa el rol real que tengas en la sesión (p.ej. 'aux_agronomico' o 'auxiliar agronomico').
        // Si no existe, caerá en 'usuario'.
        $rolPrincipal = $_SESSION['rol'] ?? 'usuario';

        // Estandariza la estructura para el frontend: siempre enviar 'roles' como arreglo de objetos {id, nombre}
        $roles = [
            [
                'id'     => 0,
                'nombre' => $rolPrincipal
            ]
        ];

        // Opcional: guarda roles en sesión para consistencia
        $_SESSION['roles'] = $roles;

        echo json_encode([
            'success' => true,
            'usuario' => $_SESSION['usuario'],
            'nombre'  => $_SESSION['nombre'],
            'roles'   => $roles,
            'rol'     => $rolPrincipal
        ]);
    }
} catch (PDOException $e) {
    error_log("Session verification error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Error del servidor: ' . $e->getMessage()]);
}