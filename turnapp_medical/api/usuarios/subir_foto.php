<?php
require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['usuario_id']) || empty($datos['foto'])) {
    respuestaError("Faltan campos obligatorios");
}

$usuario_id = (int) $datos['usuario_id'];
$fotoBase64 = $datos['foto'];
$extension  = $datos['extension'] ?? 'jpg';

$carpeta = __DIR__ . '/../../archivos/fotos/';
if (!is_dir($carpeta)) mkdir($carpeta, 0777, true);

$conn = getConexion();
$res  = mysqli_query($conn, "SELECT foto_url FROM usuarios WHERE id = $usuario_id");
$user = mysqli_fetch_assoc($res);
if ($user && $user['foto_url']) {
    $fotoAnterior = __DIR__ . '/../../' . $user['foto_url'];
    if (file_exists($fotoAnterior)) unlink($fotoAnterior);
}

$nombreArchivo   = 'foto_' . $usuario_id . '_' . time() . '.' . $extension;
$rutaCompleta    = $carpeta . $nombreArchivo;
$fotoDecodificada = base64_decode($fotoBase64);

if (!file_put_contents($rutaCompleta, $fotoDecodificada)) {
    respuestaError("Error al guardar la foto", 500);
}

$rutaRelativa = 'archivos/fotos/' . $nombreArchivo;
$rutaEsc      = mysqli_real_escape_string($conn, $rutaRelativa);

if (!mysqli_query($conn, "UPDATE usuarios SET foto_url = '$rutaEsc' WHERE id = $usuario_id")) {
    respuestaError("Error al actualizar: " . mysqli_error($conn), 500);
}

mysqli_close($conn);
respuesta([
    "mensaje"  => "Foto actualizada correctamente",
    "foto_url" => $rutaRelativa
]);
