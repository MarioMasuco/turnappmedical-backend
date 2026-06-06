<?php
// ============================================================
//  TurnApp Medical — Crear valoración
//  POST /api/valoraciones/crear.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['cita_id']) || empty($datos['usuario_id']) ||
    empty($datos['medico_id']) || empty($datos['puntuacion'])) {
    respuestaError("Faltan campos obligatorios: cita_id, usuario_id, medico_id y puntuacion");
}

$cita_id    = (int) $datos['cita_id'];
$usuario_id = (int) $datos['usuario_id'];
$medico_id  = (int) $datos['medico_id'];
$puntuacion = (int) $datos['puntuacion'];
$comentario = $datos['comentario'] ?? null;

if ($puntuacion < 1 || $puntuacion > 5) {
    respuestaError("La puntuación debe estar entre 1 y 5");
}

$conn = getConexion();

$check = mysqli_query($conn,
    "SELECT id, estado FROM citas WHERE id = $cita_id AND usuario_id = $usuario_id"
);
if (mysqli_num_rows($check) === 0) {
    respuestaError("La cita no existe o no te pertenece", 404);
}
$cita = mysqli_fetch_assoc($check);
if ($cita['estado'] !== 'completada') {
    respuestaError("Solo puedes valorar citas completadas");
}

$yaValorada = mysqli_query($conn, "SELECT id FROM valoraciones WHERE cita_id = $cita_id");
if (mysqli_num_rows($yaValorada) > 0) {
    respuestaError("Ya has valorado esta cita", 409);
}

$comentarioEsc = $comentario ? "'" . mysqli_real_escape_string($conn, $comentario) . "'" : "NULL";

$sql = "INSERT INTO valoraciones (cita_id, usuario_id, medico_id, puntuacion, comentario)
        VALUES ($cita_id, $usuario_id, $medico_id, $puntuacion, $comentarioEsc)";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al guardar la valoración: " . mysqli_error($conn), 500);
}

mysqli_close($conn);

respuesta([
    "mensaje"    => "Valoración enviada correctamente",
    "puntuacion" => $puntuacion
], 201);
