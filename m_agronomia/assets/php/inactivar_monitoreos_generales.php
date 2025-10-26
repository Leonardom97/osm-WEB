<?php
// Configura la respuesta como JSON
header('Content-Type: application/json');
// Incluye la conexión a la base de datos principal
require_once 'db_postgres_prueba.php';

// Decodifica el cuerpo recibido en JSON
$data = json_decode(file_get_contents("php://input"), true);
// Obtiene el ID del registro
$id = $data['monitoreos_generales_id'] ?? null;

if ($id) {
    // Marca el registro como inactivo usando el campo error_registro
    $stmt = $pg->prepare("UPDATE monitoreos_generales SET error_registro = 'inactivo' WHERE monitoreos_generales_id = ?");
    $ok = $stmt->execute([$id]);
    if ($ok) {
        echo json_encode([ "success" => true ]);
    } else {
        // Error en la consulta SQL
        echo json_encode([ "success" => false, "error" => "Error en la consulta SQL" ]);
    }
} else {
    // No se recibió un ID válido
    echo json_encode([ "success" => false, "error" => "ID no válido" ]);
}