<?php
// ============================================================
//  TurnApp Medical — Cancelar cita
//  POST /api/citas/cancelar.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['cita_id']) || empty($datos['usuario_id'])) {
    respuestaError("Faltan campos obligatorios: cita_id y usuario_id");
}

$cita_id    = (int) $datos['cita_id'];
$usuario_id = (int) $datos['usuario_id'];
$motivo     = $datos['motivo_cancelacion'] ?? null;
$conn       = getConexion();

$check = mysqli_query($conn,
    "SELECT id, estado, fecha FROM citas WHERE id = $cita_id AND usuario_id = $usuario_id"
);

if (mysqli_num_rows($check) === 0) {
    respuestaError("La cita no existe o no te pertenece", 404);
}

$cita = mysqli_fetch_assoc($check);

if ($cita['estado'] === 'cancelada') {
    respuestaError("La cita ya está cancelada");
}
if ($cita['estado'] === 'completada') {
    respuestaError("No puedes cancelar una cita ya completada");
}
if (strtotime($cita['fecha']) < strtotime(date('Y-m-d'))) {
    respuestaError("No puedes cancelar una cita pasada");
}

$motivoEsc = $motivo ? "'" . mysqli_real_escape_string($conn, $motivo) . "'" : "NULL";

if (!mysqli_query($conn,
    "UPDATE citas SET estado = 'cancelada', cancelada_por = 'paciente',
     motivo_cancelacion = $motivoEsc WHERE id = $cita_id")) {
    respuestaError("Error al cancelar: " . mysqli_error($conn), 500);
}

$tituloNotif  = mysqli_real_escape_string($conn, "Cita cancelada");
$mensajeNotif = mysqli_real_escape_string($conn, "Tu cita del {$cita['fecha']} ha sido cancelada.");
mysqli_query($conn,
    "INSERT INTO notificaciones (usuario_id, titulo, mensaje, tipo)
     VALUES ($usuario_id, '$tituloNotif', '$mensajeNotif', 'cancelacion')"
);

mysqli_close($conn);

respuesta([
    "mensaje" => "Cita cancelada correctamente",
    "cita_id" => $cita_id
]);
