<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

$paciente_id = isset($_GET['paciente_id']) ? intval($_GET['paciente_id']) : 0;
$medico_id   = isset($_GET['medico_id'])   ? intval($_GET['medico_id'])   : 0;

if ($paciente_id === 0 || $medico_id === 0) {
    respuesta(["citas" => []]);
    exit;
}

$conn = getConexion();

$sql = "SELECT c.id, c.fecha, c.hora, c.estado, c.motivo,
               u.id AS usuario_id,
               u.nombre AS paciente_nombre, u.apellidos AS paciente_apellidos,
               u.email AS paciente_email, u.telefono AS paciente_telefono
        FROM citas c
        JOIN usuarios u ON c.usuario_id = u.id
        WHERE c.usuario_id = $paciente_id AND c.medico_id = $medico_id
        ORDER BY c.fecha DESC, c.hora DESC";

$resultado = mysqli_query($conn, $sql);
$citas = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $citas[] = $fila;
}

mysqli_close($conn);
respuesta(["citas" => $citas]);