<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos           = getBodyJson();
$medico_id       = intval($datos['medico_id']       ?? 0);
$password_actual = trim($datos['password_actual']   ?? '');
$password_nueva  = trim($datos['password_nueva']    ?? '');

if ($medico_id === 0 || empty($password_actual) || empty($password_nueva)) {
    respuestaError("Datos incompletos");
}

if (strlen($password_nueva) < 6) {
    respuestaError("La contraseña debe tener al menos 6 caracteres");
}

$conn = getConexion();

$resultado = mysqli_query($conn, "SELECT password FROM medicos WHERE id = $medico_id");

if (mysqli_num_rows($resultado) === 0) {
    mysqli_close($conn);
    respuestaError("Médico no encontrado", 404);
}

$medico = mysqli_fetch_assoc($resultado);

if (!password_verify($password_actual, $medico['password'])) {
    mysqli_close($conn);
    respuestaError("Contraseña actual incorrecta", 401);
}

$hash = password_hash($password_nueva, PASSWORD_BCRYPT);
$hash = mysqli_real_escape_string($conn, $hash);

mysqli_query($conn, "UPDATE medicos SET password = '$hash' WHERE id = $medico_id");
mysqli_close($conn);

respuesta(["mensaje" => "Contraseña actualizada correctamente"]);