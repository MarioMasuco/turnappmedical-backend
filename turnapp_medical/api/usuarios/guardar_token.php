<?php
// ============================================================
//  TurnApp Medical — Guardar token FCM del usuario
//  POST /api/usuarios/guardar_token.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['usuario_id']) || empty($datos['fcm_token'])) {
    respuestaError("Faltan campos obligatorios: usuario_id y fcm_token");
}

$usuario_id = (int) $datos['usuario_id'];
$fcm_token  = $datos['fcm_token'];
$conn       = getConexion();

$tokenEsc = mysqli_real_escape_string($conn, $fcm_token);
$sql      = "UPDATE usuarios SET fcm_token = '$tokenEsc' WHERE id = $usuario_id";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al guardar el token", 500);
}

mysqli_close($conn);
respuesta(["mensaje" => "Token guardado correctamente"]);
