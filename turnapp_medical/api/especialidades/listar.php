<?php
// ============================================================
//  TurnApp Medical — Listar especialidades
//  GET /api/especialidades/listar.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

$conn      = getConexion();
$resultado = mysqli_query($conn, "SELECT * FROM especialidades ORDER BY nombre ASC");

$especialidades = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $especialidades[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"          => count($especialidades),
    "especialidades" => $especialidades
]);
