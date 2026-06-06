<?php
// ============================================================
//  TurnApp Medical — Listar clínicas
//  GET /api/clinicas/listar.php
//  Parámetro opcional: ?especialidad_id=1
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

$conn  = getConexion();
$where = "WHERE c.activa = 1";

if (!empty($_GET['especialidad_id'])) {
    $espId  = (int) $_GET['especialidad_id'];
    $where .= " AND EXISTS (
        SELECT 1 FROM medicos m
        WHERE m.clinica_id = c.id
        AND m.especialidad_id = $espId
        AND m.activo = 1
    )";
}

$sql = "
    SELECT c.id, c.nombre, c.direccion, c.telefono, c.email,
           c.latitud, c.longitud, c.imagen_url,
           COUNT(DISTINCT m.id) AS total_medicos
    FROM clinicas c
    LEFT JOIN medicos m ON m.clinica_id = c.id AND m.activo = 1
    $where
    GROUP BY c.id
    ORDER BY c.nombre ASC
";

$resultado = mysqli_query($conn, $sql);
$clinicas  = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $clinicas[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"    => count($clinicas),
    "clinicas" => $clinicas
]);
