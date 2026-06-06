<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';
require_once '../../config/fcm_helper.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['cita_id']) || empty($datos['medico_id']) || empty($datos['estado'])) {
    respuestaError("Faltan campos obligatorios: cita_id, medico_id y estado");
}

$cita_id   = (int) $datos['cita_id'];
$medico_id = (int) $datos['medico_id'];
$estado    = $datos['estado'];

$estadosValidos = ['confirmada', 'cancelada', 'completada'];
if (!in_array($estado, $estadosValidos)) {
    respuestaError("Estado no válido");
}

$conn = getConexion();

$check = mysqli_query($conn,
    "SELECT c.id, c.usuario_id, c.fecha, c.hora,
            u.nombre AS paciente_nombre, u.fcm_token AS paciente_token
     FROM citas c
     JOIN usuarios u ON c.usuario_id = u.id
     WHERE c.id = $cita_id AND c.medico_id = $medico_id"
);

if (mysqli_num_rows($check) === 0) {
    respuestaError("La cita no existe o no te pertenece", 404);
}

$cita = mysqli_fetch_assoc($check);

$estadoEsc = mysqli_real_escape_string($conn, $estado);
if (!mysqli_query($conn, "UPDATE citas SET estado = '$estadoEsc' WHERE id = $cita_id")) {
    respuestaError("Error al actualizar: " . mysqli_error($conn), 500);
}

$mensajesPaciente = [
    'confirmada' => "Tu cita del {$cita['fecha']} a las {$cita['hora']} ha sido confirmada ✅",
    'cancelada'  => "Tu cita del {$cita['fecha']} a las {$cita['hora']} ha sido cancelada ❌",
    'completada' => "Tu cita del {$cita['fecha']} ha sido completada. ¡Gracias por tu visita! 🏥"
];

// Notificación push al paciente
if (!empty($cita['paciente_token'])) {
    enviarNotificacion(
        $cita['paciente_token'],
        "TurnApp Medical",
        $mensajesPaciente[$estado]
    );
}

// Tipos para el ENUM
$tipos = [
    'confirmada' => 'confirmacion',
    'cancelada'  => 'cancelacion',
    'completada' => 'confirmacion'
];
$tipo = $tipos[$estado];

// Notificación interna al paciente
$usuarioId    = $cita['usuario_id'];
$tituloP      = mysqli_real_escape_string($conn, "Cita $estado");
$mensajeP     = mysqli_real_escape_string($conn, $mensajesPaciente[$estado]);
mysqli_query($conn,
    "INSERT INTO notificaciones (usuario_id, titulo, mensaje, tipo)
     VALUES ($usuarioId, '$tituloP', '$mensajeP', '$tipo')"
);

// Notificación interna al médico cuando el paciente cancela ← NUEVO
// (cuando el médico cambia el estado no necesita notificarse a sí mismo,
//  pero si la cancelación viene del paciente sí. Aquí añadimos aviso
//  al médico de que completó/canceló para su bandeja)
$mensajesMedico = [
    'confirmada' => "Has confirmado la cita de {$cita['paciente_nombre']} para el {$cita['fecha']}",
    'cancelada'  => "Has cancelado la cita de {$cita['paciente_nombre']} del {$cita['fecha']}",
    'completada' => "Has completado la consulta de {$cita['paciente_nombre']} del {$cita['fecha']}"
];

$tituloM  = mysqli_real_escape_string($conn, "Cita $estado");
$mensajeM = mysqli_real_escape_string($conn, $mensajesMedico[$estado]);
mysqli_query($conn,
    "INSERT INTO notificaciones (usuario_id, medico_id, titulo, mensaje, tipo)
     VALUES (NULL, $medico_id, '$tituloM', '$mensajeM', '$tipo')"
);

mysqli_close($conn);

respuesta([
    "mensaje" => "Estado actualizado a '$estado' correctamente",
    "cita_id" => $cita_id,
    "estado"  => $estado
]);