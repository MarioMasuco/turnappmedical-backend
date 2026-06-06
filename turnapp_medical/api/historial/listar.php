<?php
// ============================================================
//  TurnApp Medical — Listar historial clínico de un paciente
//  GET /api/historial/listar.php?usuario_id=1
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

// Usamos LEFT JOIN para que el historial se muestre SIEMPRE,
// aunque falte el médico o la especialidad asociada
$sql = "
    SELECT h.id,
           h.diagnostico,
           h.tratamiento,
           h.observaciones,
           h.created_at,
           c.fecha    AS fecha_cita,
           c.hora     AS hora_cita,
           m.nombre   AS medico_nombre,
           m.apellidos AS medico_apellidos,
           e.nombre   AS especialidad
    FROM historial_clinico h
    LEFT JOIN citas c          ON h.cita_id = c.id
    LEFT JOIN medicos m        ON h.medico_id = m.id
    LEFT JOIN especialidades e ON m.especialidad_id = e.id
    WHERE h.usuario_id = $usuario_id
    ORDER BY h.created_at DESC
";

$resultado = mysqli_query($conn, $sql);

if (!$resultado) {
    respuestaError("Error al consultar el historial: " . mysqli_error($conn), 500);
}

$historial = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $historial[] = $fila;
}

mysqli_close($conn);

respuesta([
    "total"     => count($historial),
    "historial" => $historial
]);