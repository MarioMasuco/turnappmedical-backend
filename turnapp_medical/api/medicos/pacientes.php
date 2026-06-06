<?php
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

$sql = "
    SELECT DISTINCT u.id, u.nombre, u.apellidos, u.email, u.telefono,
           COUNT(c.id) as total_citas,
           MAX(c.fecha) as ultima_cita
    FROM usuarios u
    JOIN citas c ON c.usuario_id = u.id
    WHERE c.medico_id = $medico_id
    GROUP BY u.id
    ORDER BY ultima_cita DESC
";

$resultado = mysqli_query($conn, $sql);
$pacientes = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $pacientes[] = $fila;
}

mysqli_close($conn);
respuesta([
    "total"     => count($pacientes),
    "pacientes" => $pacientes
]);
