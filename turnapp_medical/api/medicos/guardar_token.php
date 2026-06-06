<?php
// ============================================================
//  TurnApp Medical — Guardar token FCM del médico
//  POST /api/medicos/guardar_token.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['medico_id']) || empty($datos['fcm_token'])) {
    respuestaError("Faltan campos obligatorios: medico_id y fcm_token");
}

$medico_id = (int) $datos['medico_id'];
$fcm_token = $datos['fcm_token'];
$conn      = getConexion();

$tokenEsc = mysqli_real_escape_string($conn, $fcm_token);
$sql      = "UPDATE medicos SET fcm_token = '$tokenEsc' WHERE id = $medico_id";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al guardar el token", 500);
}

mysqli_close($conn);
respuesta(["mensaje" => "Token guardado correctamente"]);
