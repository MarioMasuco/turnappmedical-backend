<?php
// ============================================================
//  TurnApp Medical — Editar perfil del paciente
//  POST /api/usuarios/editar_perfil.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['usuario_id'])) {
    respuestaError("El campo usuario_id es obligatorio");
}

$usuario_id = (int) $datos['usuario_id'];
$conn       = getConexion();

$campos = [];

if (!empty($datos['nombre'])) {
    $campos[] = "nombre = '" . mysqli_real_escape_string($conn, $datos['nombre']) . "'";
}
if (!empty($datos['apellidos'])) {
    $campos[] = "apellidos = '" . mysqli_real_escape_string($conn, $datos['apellidos']) . "'";
}
if (isset($datos['telefono'])) {
    $campos[] = "telefono = '" . mysqli_real_escape_string($conn, $datos['telefono']) . "'";
}
if (isset($datos['tarjeta_sanitaria'])) {
    $campos[] = "tarjeta_sanitaria = '" . mysqli_real_escape_string($conn, $datos['tarjeta_sanitaria']) . "'";
}

if (empty($campos)) {
    respuestaError("No hay campos para actualizar");
}

$sql = "UPDATE usuarios SET " . implode(", ", $campos) . " WHERE id = $usuario_id";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al actualizar el perfil: " . mysqli_error($conn), 500);
}

// Devolver datos actualizados
$resultado = mysqli_query($conn, "SELECT id, nombre, apellidos, email, telefono, tarjeta_sanitaria FROM usuarios WHERE id = $usuario_id");
$usuario   = mysqli_fetch_assoc($resultado);

mysqli_close($conn);

respuesta([
    "mensaje" => "Perfil actualizado correctamente",
    "usuario" => $usuario
]);
