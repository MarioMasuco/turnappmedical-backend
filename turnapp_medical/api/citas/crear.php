<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';
require_once '../../config/fcm_helper.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['usuario_id']) || empty($datos['medico_id']) ||
    empty($datos['fecha'])      || empty($datos['hora'])) {
    respuestaError("Faltan campos obligatorios: usuario_id, medico_id, fecha y hora");
}

$usuario_id = (int) $datos['usuario_id'];
$medico_id  = (int) $datos['medico_id'];
$fecha      = $datos['fecha'];
$hora       = $datos['hora'];
$motivo     = $datos['motivo'] ?? null;

if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $fecha)) {
    respuestaError("Formato de fecha incorrecto. Usa YYYY-MM-DD");
}

if (strtotime($fecha) < strtotime(date('Y-m-d'))) {
    respuestaError("No puedes reservar una cita en el pasado");
}

$conn = getConexion();

$medicoCheck = mysqli_query($conn, "SELECT id, nombre, apellidos, fcm_token FROM medicos WHERE id = $medico_id AND activo = 1");
if (mysqli_num_rows($medicoCheck) === 0) {
    respuestaError("El médico no existe o no está disponible", 404);
}
$medico = mysqli_fetch_assoc($medicoCheck);

$usuarioCheck = mysqli_query($conn, "SELECT id, nombre FROM usuarios WHERE id = $usuario_id AND activo = 1");
if (mysqli_num_rows($usuarioCheck) === 0) {
    respuestaError("El usuario no existe", 404);
}
$usuario = mysqli_fetch_assoc($usuarioCheck);

$horaEsc  = mysqli_real_escape_string($conn, $hora);
$fechaEsc = mysqli_real_escape_string($conn, $fecha);

$solapamiento = mysqli_query($conn,
    "SELECT id FROM citas WHERE medico_id = $medico_id AND fecha = '$fechaEsc'
     AND hora = '$horaEsc' AND estado != 'cancelada'"
);
if (mysqli_num_rows($solapamiento) > 0) {
    respuestaError("Esa franja horaria ya está ocupada", 409);
}

$citaPaciente = mysqli_query($conn,
    "SELECT id FROM citas WHERE usuario_id = $usuario_id AND medico_id = $medico_id
     AND fecha = '$fechaEsc' AND estado != 'cancelada'"
);
if (mysqli_num_rows($citaPaciente) > 0) {
    respuestaError("Ya tienes una cita con este médico ese día", 409);
}

$motivoEsc = $motivo ? "'" . mysqli_real_escape_string($conn, $motivo) . "'" : "NULL";

$sql = "INSERT INTO citas (usuario_id, medico_id, fecha, hora, motivo, estado)
        VALUES ($usuario_id, $medico_id, '$fechaEsc', '$horaEsc', $motivoEsc, 'pendiente')";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al crear la cita: " . mysqli_error($conn), 500);
}

$nuevaCitaId = mysqli_insert_id($conn);

// Notificación push al médico
if (!empty($medico['fcm_token'])) {
    enviarNotificacion(
        $medico['fcm_token'],
        "Nueva cita solicitada",
        "El paciente {$usuario['nombre']} ha solicitado cita para el $fecha a las $hora"
    );
}

// Notificación interna al paciente
$tituloP  = mysqli_real_escape_string($conn, "Cita solicitada");
$mensajeP = mysqli_real_escape_string($conn, "Tu cita para el $fecha a las $hora ha sido solicitada.");
mysqli_query($conn,
    "INSERT INTO notificaciones (usuario_id, titulo, mensaje, tipo)
     VALUES ($usuario_id, '$tituloP', '$mensajeP', 'confirmacion')"
);

// Notificación interna al médico ← NUEVO
$tituloM  = mysqli_real_escape_string($conn, "Nueva cita solicitada");
$mensajeM = mysqli_real_escape_string($conn,
    "El paciente {$usuario['nombre']} ha solicitado cita para el $fecha a las $hora");
mysqli_query($conn,
    "INSERT INTO notificaciones (medico_id, titulo, mensaje, tipo)
     VALUES ($medico_id, '$tituloM', '$mensajeM', 'confirmacion')"
);

mysqli_close($conn);

respuesta([
    "mensaje" => "Cita creada correctamente",
    "cita_id" => $nuevaCitaId,
    "fecha"   => $fecha,
    "hora"    => $hora,
    "estado"  => "pendiente"
], 201);