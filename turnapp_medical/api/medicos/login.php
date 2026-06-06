<?php
// ============================================================
//  TurnApp Medical — Login de médico
//  POST /api/medicos/login.php
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
$resultado = mysqli_query($conn,
    "SELECT m.*, e.nombre AS especialidad_nombre, c.nombre AS clinica_nombre
     FROM medicos m
     JOIN especialidades e ON m.especialidad_id = e.id
     JOIN clinicas c ON m.clinica_id = c.id
     WHERE m.email = '$emailEsc' AND m.activo = 1"
);
$medico = mysqli_fetch_assoc($resultado);

// Comprobamos contraseña (con password_hash o texto plano para pruebas)
$passwordOk = false;
if ($medico) {
    if (password_verify($password, $medico['password'])) {
        $passwordOk = true;
    } elseif ($password === $medico['password']) {
        // Para datos de prueba insertados en texto plano
        $passwordOk = true;
    }
}

if (!$medico || !$passwordOk) {
    respuestaError("Email o contraseña incorrectos", 401);
}

$token = bin2hex(random_bytes(32));
unset($medico['password']);

mysqli_close($conn);

respuesta([
    "mensaje" => "Login correcto",
    "token"   => $token,
    "rol"     => "medico",
    "medico"  => $medico
]);
