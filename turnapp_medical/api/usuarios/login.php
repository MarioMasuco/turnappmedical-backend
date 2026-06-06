<?php
// ============================================================
//  TurnApp Medical — Login de usuario
//  POST /api/usuarios/login.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['email']) || empty($datos['password'])) {
    respuestaError("El email y la contraseña son obligatorios");
}

$email    = trim($datos['email']);
$password = $datos['password'];
$conn     = getConexion();

$emailEsc  = mysqli_real_escape_string($conn, $email);
$resultado = mysqli_query($conn, "SELECT * FROM usuarios WHERE email = '$emailEsc' AND activo = 1");
$usuario   = mysqli_fetch_assoc($resultado);

if (!$usuario || !password_verify($password, $usuario['password'])) {
    respuestaError("Email o contraseña incorrectos", 401);
}

$token = bin2hex(random_bytes(32));
unset($usuario['password']);
mysqli_close($conn);

respuesta([
    "mensaje" => "Login correcto",
    "token"   => $token,
    "usuario" => $usuario
]);
