<?php
// ============================================================
//  TurnApp Medical — Listar mensajes de una cita
//  GET /api/mensajes/listar.php?cita_id=1
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

if (empty($_GET['cita_id'])) {
    respuestaError("El parámetro cita_id es obligatorio");
}

$cita_id   = (int) $_GET['cita_id'];
$conn      = getConexion();
$resultado = mysqli_query($conn,
    "SELECT * FROM mensajes WHERE cita_id = $cita_id ORDER BY created_at ASC"
);

$mensajes = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $mensajes[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"    => count($mensajes),
    "mensajes" => $mensajes
]);
