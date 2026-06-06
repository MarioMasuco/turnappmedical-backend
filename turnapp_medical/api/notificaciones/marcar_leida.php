<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();
$conn  = getConexion();

if (!empty($datos['usuario_id'])) {
    // Marcar todas como leídas
    $usuario_id = (int) $datos['usuario_id'];
    mysqli_query($conn, "UPDATE notificaciones SET leida = 1 WHERE usuario_id = $usuario_id");
} elseif (!empty($datos['notificacion_id'])) {
    // Marcar una como leída
    $id = (int) $datos['notificacion_id'];
    mysqli_query($conn, "UPDATE notificaciones SET leida = 1 WHERE id = $id");
}

mysqli_close($conn);
respuesta(["mensaje" => "Notificaciones marcadas como leídas"]);
