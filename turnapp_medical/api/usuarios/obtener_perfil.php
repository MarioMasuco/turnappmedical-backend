<?php
// ============================================================
//  TurnApp Medical — Obtener perfil del paciente
//  GET /api/usuarios/obtener_perfil.php?usuario_id=1
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

$resultado = mysqli_query($conn,
    "SELECT id, nombre, apellidos, email, telefono, tarjeta_sanitaria, created_at
     FROM usuarios WHERE id = $usuario_id AND activo = 1"
);

$usuario = mysqli_fetch_assoc($resultado);

if (!$usuario) {
    respuestaError("Usuario no encontrado", 404);
}

mysqli_close($conn);
respuesta(["usuario" => $usuario]);
