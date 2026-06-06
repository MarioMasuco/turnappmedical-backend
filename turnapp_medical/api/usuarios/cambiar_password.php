<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos           = getBodyJson();
$usuario_id      = intval($datos['usuario_id']      ?? 0);
$password_actual = trim($datos['password_actual']   ?? '');
$password_nueva  = trim($datos['password_nueva']    ?? '');

if ($usuario_id === 0 || empty($password_actual) || empty($password_nueva)) {
    respuestaError("Datos incompletos");
}

if (strlen($password_nueva) < 6) {
    respuestaError("La contraseña debe tener al menos 6 caracteres");
}

$conn = getConexion();

// Obtener contraseña actual
$resultado = mysqli_query($conn, "SELECT password FROM usuarios WHERE id = $usuario_id");

if (mysqli_num_rows($resultado) === 0) {
    mysqli_close($conn);
    respuestaError("Usuario no encontrado", 404);
}

$usuario = mysqli_fetch_assoc($resultado);

// Verificar contraseña actual
if (!password_verify($password_actual, $usuario['password'])) {
    mysqli_close($conn);
    respuestaError("Contraseña actual incorrecta", 401);
}

// Actualizar con la nueva contraseña
$hash = password_hash($password_nueva, PASSWORD_BCRYPT);
$hash = mysqli_real_escape_string($conn, $hash);

mysqli_query($conn, "UPDATE usuarios SET password = '$hash' WHERE id = $usuario_id");
mysqli_close($conn);

respuesta(["mensaje" => "Contraseña actualizada correctamente"]);