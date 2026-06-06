<?php
// ============================================================
//  TurnApp Medical — Listar documentos del paciente
//  GET /api/documentos/listar.php?usuario_id=1
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

if (empty($_GET['usuario_id'])) {
    respuestaError("El parámetro usuario_id es obligatorio");
}

$usuario_id = (int) $_GET['usuario_id'];
$conn       = getConexion();

$sql = "
    SELECT d.id, d.nombre, d.ruta_pdf, d.created_at,
           h.diagnostico,
           m.nombre AS medico_nombre, m.apellidos AS medico_apellidos,
           e.nombre AS especialidad
    FROM documentos d
    JOIN historial_clinico h ON d.historial_id = h.id
    JOIN medicos m ON h.medico_id = m.id
    JOIN especialidades e ON m.especialidad_id = e.id
    WHERE d.usuario_id = $usuario_id
    ORDER BY d.created_at DESC
";

$resultado   = mysqli_query($conn, $sql);
$documentos  = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $documentos[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"      => count($documentos),
    "documentos" => $documentos
]);
