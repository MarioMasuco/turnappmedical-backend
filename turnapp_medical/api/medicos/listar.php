<?php
// ============================================================
//  TurnApp Medical — Listar médicos
//  GET /api/medicos/listar.php
//  Parámetros opcionales: ?especialidad_id=1 | ?clinica_id=1
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

$conn  = getConexion();
$where = "WHERE m.activo = 1";

if (!empty($_GET['especialidad_id'])) {
    $espId  = (int) $_GET['especialidad_id'];
    $where .= " AND m.especialidad_id = $espId";
}

if (!empty($_GET['clinica_id'])) {
    $clinId = (int) $_GET['clinica_id'];
    $where .= " AND m.clinica_id = $clinId";
}

$sql = "
    SELECT m.id, m.nombre, m.apellidos, m.foto_url, m.descripcion, m.num_colegiado,
           e.nombre AS especialidad,
           c.nombre AS clinica, c.direccion,
           IFNULL(ROUND(AVG(v.puntuacion), 1), 0) AS valoracion_media,
           COUNT(v.id) AS total_valoraciones
    FROM medicos m
    JOIN especialidades e  ON m.especialidad_id = e.id
    JOIN clinicas c        ON m.clinica_id = c.id
    LEFT JOIN valoraciones v ON v.medico_id = m.id
    $where
    GROUP BY m.id
    ORDER BY valoracion_media DESC
";

$resultado = mysqli_query($conn, $sql);
$medicos   = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $medicos[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"   => count($medicos),
    "medicos" => $medicos
]);
