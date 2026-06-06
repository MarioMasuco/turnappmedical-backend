<?php
// ============================================================
//  TurnApp Medical — Subir documento PDF
//  POST /api/documentos/subir.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['historial_id']) || empty($datos['usuario_id']) ||
    empty($datos['nombre'])       || empty($datos['contenido'])) {
    respuestaError("Faltan campos obligatorios");
}

$historial_id = (int) $datos['historial_id'];
$usuario_id   = (int) $datos['usuario_id'];
$nombre       = $datos['nombre'];
$contenido    = $datos['contenido']; // base64

// Crear carpeta si no existe
$carpeta = __DIR__ . '/../../archivos/pdfs/';
if (!is_dir($carpeta)) {
    mkdir($carpeta, 0777, true);
}

// Decodificar y guardar el PDF
$nombreArchivo = time() . '_' . preg_replace('/[^a-zA-Z0-9_\-.]/', '_', $nombre);
$rutaCompleta  = $carpeta . $nombreArchivo;
$pdfDecodificado = base64_decode($contenido);

if (!file_put_contents($rutaCompleta, $pdfDecodificado)) {
    respuestaError("Error al guardar el archivo", 500);
}

$rutaRelativa = 'archivos/pdfs/' . $nombreArchivo;

// Guardar en base de datos
$conn      = getConexion();
$nombreEsc = mysqli_real_escape_string($conn, $nombre);
$rutaEsc   = mysqli_real_escape_string($conn, $rutaRelativa);

$sql = "INSERT INTO documentos (historial_id, usuario_id, nombre, ruta_pdf)
        VALUES ($historial_id, $usuario_id, '$nombreEsc', '$rutaEsc')";

if (!mysqli_query($conn, $sql)) {
    respuestaError("Error al guardar en BD: " . mysqli_error($conn), 500);
}

$nuevoId = mysqli_insert_id($conn);
mysqli_close($conn);

respuesta([
    "mensaje"    => "Documento subido correctamente",
    "id"         => $nuevoId,
    "ruta"       => $rutaRelativa,
    "nombre"     => $nombre
], 201);
