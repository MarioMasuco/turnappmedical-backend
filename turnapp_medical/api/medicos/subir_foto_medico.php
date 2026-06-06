<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

$medico_id = isset($data['medico_id']) ? intval($data['medico_id']) : 0;
$foto      = $data['foto']      ?? '';
$extension = $data['extension'] ?? 'jpg';

if ($medico_id === 0 || empty($foto)) {
    echo json_encode(["error" => "Datos incompletos"]);
    exit;
}

// Decodificar base64
$imagen = base64_decode($foto);
if (!$imagen) {
    echo json_encode(["error" => "Imagen inválida"]);
    exit;
}

// Crear carpeta si no existe
$dir = __DIR__ . '/uploads/medicos/';
if (!is_dir($dir)) mkdir($dir, 0755, true);

// Guardar archivo
$nombre_archivo = 'medico_' . $medico_id . '_' . time() . '.' . $extension;
$ruta           = $dir . $nombre_archivo;

if (file_put_contents($ruta, $imagen) === false) {
    echo json_encode(["error" => "Error al guardar la imagen"]);
    exit;
}

$url_relativa = 'uploads/medicos/' . $nombre_archivo;

// Actualizar en base de datos
$stmt = $pdo->prepare("UPDATE medicos SET foto_url = ? WHERE id = ?");
$stmt->execute([$url_relativa, $medico_id]);

echo json_encode([
    "mensaje"  => "Foto actualizada correctamente",
    "foto_url" => $url_relativa
]);
