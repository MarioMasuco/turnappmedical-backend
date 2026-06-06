<?php
// ============================================================
//  TurnApp Medical — Enviar mensaje
//  POST /api/mensajes/enviar.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['cita_id']) || empty($datos['remitente']) || empty($datos['mensaje'])) {
    respuestaError("Faltan campos obligatorios: cita_id, remitente y mensaje");
}

$cita_id   = (int) $datos['cita_id'];
$remitente = $datos['remitente'];
$mensaje   = trim($datos['mensaje']);

if (!in_array($remitente, ['paciente', 'clinica'])) {
    respuestaError("El remitente debe ser 'paciente' o 'clinica'");
}

if (empty($mensaje)) {
    respuestaError("El mensaje no puede estar vacío");
}

$conn = getConexion();

$citaCheck = mysqli_query($conn, "SELECT id FROM citas WHERE id = $cita_id");
if (mysqli_num_rows($citaCheck) === 0) {
    respuestaError("La cita no existe", 404);
}

$remitenteEsc = mysqli_real_escape_string($conn, $remitente);
$mensajeEsc   = mysqli_real_escape_string($conn, $mensaje);

$sql = "INSERT INTO mensajes (cita_id, remitente, mensaje)
        VALUES ($cita_id, '$remitenteEsc', '$mensajeEsc')";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al enviar el mensaje: " . mysqli_error($conn), 500);
}

$nuevoId = mysqli_insert_id($conn);
mysqli_close($conn);

respuesta([
    "mensaje"    => "Mensaje enviado correctamente",
    "mensaje_id" => $nuevoId
], 201);
