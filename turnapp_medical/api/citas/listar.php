<?php
// ============================================================
//  TurnApp Medical — Listar citas de un paciente
//  GET /api/citas/listar.php?usuario_id=1
//  Opcional: &estado=pendiente|confirmada|cancelada|completada
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

if (empty($_GET['usuario_id'])) {
    respuestaError("El parámetro usuario_id es obligatorio");
}

$usuario_id = (int) $_GET['usuario_id'];
$conn       = getConexion();
$where      = "WHERE c.usuario_id = $usuario_id";

if (!empty($_GET['estado'])) {
    $estado  = mysqli_real_escape_string($conn, $_GET['estado']);
    $where  .= " AND c.estado = '$estado'";
}

$sql = "
    SELECT c.id, c.medico_id, c.fecha, c.hora, c.motivo, c.estado, c.created_at,
           m.nombre AS medico_nombre, m.apellidos AS medico_apellidos,
           e.nombre AS especialidad,
           cl.nombre AS clinica, cl.direccion AS clinica_direccion
    FROM citas c
    JOIN medicos m        ON c.medico_id = m.id
    JOIN especialidades e ON m.especialidad_id = e.id
    JOIN clinicas cl      ON m.clinica_id = cl.id
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
