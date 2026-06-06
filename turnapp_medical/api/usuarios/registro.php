<?php
// ============================================================
//  TurnApp Medical — Registro de usuario
//  POST /api/usuarios/registro.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['nombre']) || empty($datos['apellidos']) ||
    empty($datos['email'])  || empty($datos['password'])) {
    respuestaError("Faltan campos obligatorios: nombre, apellidos, email y password");
}

$nombre    = trim($datos['nombre']);
$apellidos = trim($datos['apellidos']);
$email     = trim($datos['email']);
$password  = $datos['password'];
$telefono  = $datos['telefono']          ?? null;
$fechaNac  = $datos['fecha_nacimiento']  ?? null;
$tarjeta   = $datos['tarjeta_sanitaria'] ?? null;

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    respuestaError("El email no tiene un formato válido");
}

if (strlen($password) < 6) {
    respuestaError("La contraseña debe tener al menos 6 caracteres");
}

$conn = getConexion();

$emailEsc = mysqli_real_escape_string($conn, $email);
$check    = mysqli_query($conn, "SELECT id FROM usuarios WHERE email = '$emailEsc'");
if (mysqli_num_rows($check) > 0) {
    respuestaError("Ya existe una cuenta con ese email", 409);
}

$passwordHash = password_hash($password, PASSWORD_BCRYPT);
$nombreEsc    = mysqli_real_escape_string($conn, $nombre);
$apellidosEsc = mysqli_real_escape_string($conn, $apellidos);
$telefonoEsc  = $telefono ? "'" . mysqli_real_escape_string($conn, $telefono) . "'" : "NULL";
$fechaNacEsc  = $fechaNac ? "'" . mysqli_real_escape_string($conn, $fechaNac) . "'" : "NULL";
$tarjetaEsc   = $tarjeta  ? "'" . mysqli_real_escape_string($conn, $tarjeta)  . "'" : "NULL";

$sql = "INSERT INTO usuarios (nombre, apellidos, email, password, telefono, fecha_nacimiento, tarjeta_sanitaria)
        VALUES ('$nombreEsc', '$apellidosEsc', '$emailEsc', '$passwordHash', $telefonoEsc, $fechaNacEsc, $tarjetaEsc)";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al registrar el usuario: " . mysqli_error($conn), 500);
}

$nuevoId = mysqli_insert_id($conn);
mysqli_close($conn);

respuesta([
    "mensaje" => "Usuario registrado correctamente",
    "id"      => $nuevoId,
    "nombre"  => $nombre,
    "email"   => $email
], 201);
