<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require_once 'db.php';

$medico_id = isset($_GET['medico_id']) ? intval($_GET['medico_id']) : 0;

if ($medico_id === 0) {
    echo json_encode(["error" => "medico_id requerido"]);
    exit;
}

$stmt = $pdo->prepare("
    SELECT m.id, m.nombre, m.apellidos, m.email,
           e.nombre AS especialidad,
           c.nombre AS clinica,
           m.foto_url, m.created_at
    FROM medicos m
    LEFT JOIN especialidades e ON m.especialidad_id = e.id
    LEFT JOIN clinicas c ON m.clinica_id = c.id
    WHERE m.id = ?
");
$stmt->execute([$medico_id]);
$medico = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$medico) {
    echo json_encode(["error" => "Médico no encontrado"]);
    exit;
}

echo json_encode(["medico" => $medico]);
