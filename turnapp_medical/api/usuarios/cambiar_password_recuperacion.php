<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos    = getBodyJson();
$email    = trim($datos['email']    ?? '');
$password = trim($datos['password'] ?? '');

if (empty($email) || empty($password)) {
    respuestaError("Datos incompletos");
}

if (strlen($password) < 6) {
    respuestaError("La contraseña debe tener al menos 6 caracteres");
}

$conn  = getConexion();
$email = mysqli_real_escape_string($conn, $email);

// Verificar que el email existe
$resultado = mysqli_query($conn, "SELECT id FROM usuarios WHERE email = '$email'");

if (mysqli_num_rows($resultado) === 0) {
    mysqli_close($conn);
    respuestaError("Usuario no encontrado", 404);
}

// Actualizar contraseña
$hash = password_hash($password, PASSWORD_BCRYPT);
$hash = mysqli_real_escape_string($conn, $hash);

mysqli_query($conn, "UPDATE usuarios SET password = '$hash' WHERE email = '$email'");
mysqli_close($conn);

respuesta(["mensaje" => "Contraseña actualizada correctamente"]);