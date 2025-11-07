<?php
header('Content-Type: application/json');
session_start();
require_once(__DIR__ . '/../../../php/db_postgres.php');

$sql = "
WITH capacitaciones_realizadas AS (
  SELECT 
    fa.cedula,
    COUNT(DISTINCT fa.id_formulario) as total_realizadas
  FROM cap_formulario_asistente fa
  WHERE fa.cedula IS NOT NULL
  GROUP BY fa.cedula
),
capacitaciones_programadas AS (
  SELECT 
    ac.cedula,
    COUNT(DISTINCT cp.id) as total_programadas
  FROM adm_colaboradores ac
  LEFT JOIN cap_programacion cp ON ac.id_cargo = cp.id_cargo 
    AND (cp.id_sub_area = ac.sub_area OR cp.id_sub_area IS NULL)
  WHERE ac.situacion = 'A'
  GROUP BY ac.cedula
)
SELECT
  ac.id,
  ac.cedula,
  TRIM(ac.nombre1 || ' ' || COALESCE(ac.nombre2 || ' ','') || ac.apellido1 || ' ' || COALESCE(ac.apellido2,'')) AS nombres_apellidos,
  ac.situacion,
  c.cargo,
  ar.sub_area,
  COALESCE(cr.total_realizadas, 0) as capacitaciones_realizadas,
  COALESCE(cp.total_programadas, 0) as capacitaciones_pendientes,
  COALESCE(cr.total_realizadas, 0) + COALESCE(cp.total_programadas, 0) as total_esperadas
FROM adm_colaboradores ac
LEFT JOIN adm_cargo c ON ac.id_cargo = c.id
LEFT JOIN adm_area ar ON ac.sub_area = ar.id_area
LEFT JOIN capacitaciones_realizadas cr ON ac.cedula = cr.cedula
LEFT JOIN capacitaciones_programadas cp ON ac.cedula = cp.cedula
WHERE ac.situacion = 'A'
ORDER BY ac.cedula
";

try {
    $stmt = $pg->prepare($sql);
    $stmt->execute();
    $personas = $stmt->fetchAll();
    echo json_encode($personas);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
      'error' => 'Error al consultar datos por persona',
      'detalle' => $e->getMessage()
    ]);
}
