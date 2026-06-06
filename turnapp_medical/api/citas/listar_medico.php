<?php
// ============================================================
//  TurnApp Medical — Listar citas de un médico
//  GET /api/citas/listar_medico.php?medico_id=1
//  Opcional: &estado=pendiente|confirmada|cancelada|completada
//  Opcional: &fecha=2026-05-10
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

if (empty($_GET['medico_id'])) {
    respuestaError("El parámetro medico_id es obligatorio");
}

$medico_id = (int) $_GET['medico_id'];
$conn      = getConexion();
$where     = "WHERE c.medico_id = $medico_id";

if (!empty($_GET['estado'])) {
    $estado  = mysqli_real_escape_string($conn, $_GET['estado']);
    $where  .= " AND c.estado = '$estado'";
}

if (!empty($_GET['fecha'])) {
    $fecha  = mysqli_real_escape_string($conn, $_GET['fecha']);
    $where .= " AND c.fecha = '$fecha'";
}

$sql = "
    SELECT c.id, c.usuario_id, c.medico_id, c.fecha, c.hora, c.motivo, c.estado, c.created_at,
           u.nombre AS paciente_nombre, u.apellidos AS paciente_apellidos,
           u.telefono AS paciente_telefono, u.email AS paciente_email
    FROM citas c
    JOIN usuarios u ON c.usuario_id = u.id
    $where
    ORDER BY c.fecha ASC, c.hora ASC
";

$resultado = mysqli_query($conn, $sql);
$citas     = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $citas[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total" => count($citas),
    "citas" => $citas
]);