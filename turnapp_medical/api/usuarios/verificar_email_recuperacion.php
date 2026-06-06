<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();
$email = trim($datos['email'] ?? '');

if (empty($email)) {
    respuestaError("Email requerido");
}

$conn  = getConexion();
$email = mysqli_real_escape_string($conn, $email);

$resultado = mysqli_query($conn, "SELECT id FROM usuarios WHERE email = '$email'");

if (mysqli_num_rows($resultado) === 0) {
    mysqli_close($conn);
    respuestaError("Email no encontrado", 404);
}

mysqli_close($conn);
respuesta(["mensaje" => "Email verificado"]);