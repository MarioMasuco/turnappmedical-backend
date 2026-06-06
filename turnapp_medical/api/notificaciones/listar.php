<?php
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

$sql = "SELECT id, titulo, mensaje, leida, created_at
        FROM notificaciones
        WHERE usuario_id = $usuario_id
        ORDER BY created_at DESC
        LIMIT 50";

$resultado      = mysqli_query($conn, $sql);
$notificaciones = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $notificaciones[] = $fila;
}

// Total no leídas
$resNoLeidas = mysqli_query($conn,
    "SELECT COUNT(*) as total FROM notificaciones WHERE usuario_id = $usuario_id AND leida = 0");
$noLeidas = mysqli_fetch_assoc($resNoLeidas)['total'];

mysqli_close($conn);

respuesta([
    "total"          => count($notificaciones),
    "no_leidas"      => (int) $noLeidas,
    "notificaciones" => $notificaciones
]);
