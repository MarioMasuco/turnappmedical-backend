<?php
// ============================================================
//  TurnApp Medical — Crear / actualizar historial clínico
//  POST /api/historial/crear.php
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respuestaError("Método no permitido", 405);
}

$datos = getBodyJson();

if (empty($datos['cita_id']) || empty($datos['medico_id']) || empty($datos['usuario_id'])) {
    respuestaError("Faltan campos obligatorios: cita_id, medico_id y usuario_id");
}

if (empty($datos['diagnostico'])) {
    respuestaError("El diagnóstico es obligatorio");
}

$cita_id    = (int) $datos['cita_id'];
$medico_id  = (int) $datos['medico_id'];
$usuario_id = (int) $datos['usuario_id'];
$diagnostico   = trim($datos['diagnostico']);
$tratamiento   = isset($datos['tratamiento'])   ? trim($datos['tratamiento'])   : null;
$observaciones = isset($datos['observaciones']) ? trim($datos['observaciones']) : null;

$conn = getConexion();

// Verificar que la cita existe, pertenece al médico y está completada
$check = mysqli_query($conn,
    "SELECT id FROM citas
     WHERE id = $cita_id
       AND medico_id = $medico_id
       AND LOWER(estado) = 'completada'"
);

if (mysqli_num_rows($check) === 0) {
    respuestaError("La cita no existe, no te pertenece o no está completada. Marca la cita como completada antes de añadir el historial.", 404);
}

$diagEsc = "'" . mysqli_real_escape_string($conn, $diagnostico) . "'";
$tratEsc = $tratamiento   ? "'" . mysqli_real_escape_string($conn, $tratamiento)   . "'" : "NULL";
$obsEsc  = $observaciones ? "'" . mysqli_real_escape_string($conn, $observaciones) . "'" : "NULL";

// Comprobar si ya existe historial para esta cita
$existe = mysqli_query($conn, "SELECT id FROM historial_clinico WHERE cita_id = $cita_id");

if (mysqli_num_rows($existe) > 0) {
    // Ya existe → actualizar
    $fila = mysqli_fetch_assoc($existe);
    $historialId = (int) $fila['id'];

    $sqlUpdate = "UPDATE historial_clinico
                  SET diagnostico = $diagEsc,
                      tratamiento = $tratEsc,
                      observaciones = $obsEsc
                  WHERE cita_id = $cita_id";

    if (!mysqli_query($conn, $sqlUpdate)) {
        respuestaError("Error al actualizar el historial: " . mysqli_error($conn), 500);
    }

    mysqli_close($conn);
    respuesta([
        "mensaje" => "Historial actualizado correctamente",
        "id"      => $historialId
    ]);
}

// No existe → insertar nuevo
$sqlInsert = "INSERT INTO historial_clinico
                (cita_id, usuario_id, medico_id, diagnostico, tratamiento, observaciones)
              VALUES
                ($cita_id, $usuario_id, $medico_id, $diagEsc, $tratEsc, $obsEsc)";

if (!mysqli_query($conn, $sqlInsert)) {
    respuestaError("Error al guardar el historial: " . mysqli_error($conn), 500);
}

$nuevoId = mysqli_insert_id($conn);
mysqli_close($conn);

respuesta([
    "mensaje" => "Historial guardado correctamente",
    "id"      => $nuevoId
], 201);