<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();
$conn  = getConexion();

if (!empty($datos['medico_id'])) {
    $medico_id = (int) $datos['medico_id'];
    mysqli_query($conn, "UPDATE notificaciones SET leida = 1 WHERE medico_id = $medico_id");
} elseif (!empty($datos['notificacion_id'])) {
    $id = (int) $datos['notificacion_id'];
    mysqli_query($conn, "UPDATE notificaciones SET leida = 1 WHERE id = $id");
}

mysqli_close($conn);
respuesta(["mensaje" => "Notificaciones marcadas como leídas"]);
