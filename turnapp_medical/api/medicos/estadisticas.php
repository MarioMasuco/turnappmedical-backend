<?php
// ============================================================
//  TurnApp Medical — Estadísticas del médico
//  GET /api/medicos/estadisticas.php?medico_id=1
// ============================================================

require_once '../../config/database.php';
require_once '../../config/helpers.php';

setCabeceras();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    respuestaError("Método no permitido", 405);
}

if (empty($_GET['medico_id'])) {
    respuestaError("El parámetro medico_id es obligatorio");
}

$medico_id = (int) $_GET['medico_id'];
$conn      = getConexion();

// Total citas por estado
$estados = ['pendiente', 'confirmada', 'completada', 'cancelada'];
$citasPorEstado = [];
foreach ($estados as $estado) {
    $res = mysqli_query($conn,
        "SELECT COUNT(*) as total FROM citas WHERE medico_id = $medico_id AND estado = '$estado'"
    );
    $row = mysqli_fetch_assoc($res);
    $citasPorEstado[$estado] = (int) $row['total'];
}

// Citas por mes (últimos 6 meses)
$citasPorMes = [];
for ($i = 5; $i >= 0; $i--) {
    $mes   = date('Y-m', strtotime("-$i months"));
    $label = date('M', strtotime("-$i months"));
    $res   = mysqli_query($conn,
        "SELECT COUNT(*) as total FROM citas
         WHERE medico_id = $medico_id AND DATE_FORMAT(fecha, '%Y-%m') = '$mes'"
    );
    $row = mysqli_fetch_assoc($res);
    $citasPorMes[] = [
        "mes"   => $label,
        "total" => (int) $row['total']
    ];
}

// Valoración media
$resVal = mysqli_query($conn,
    "SELECT IFNULL(ROUND(AVG(puntuacion), 1), 0) as media,
            COUNT(*) as total
     FROM valoraciones WHERE medico_id = $medico_id"
);
$valoracion = mysqli_fetch_assoc($resVal);

// Total pacientes únicos
$resPacientes = mysqli_query($conn,
    "SELECT COUNT(DISTINCT usuario_id) as total FROM citas WHERE medico_id = $medico_id"
);
$pacientes = mysqli_fetch_assoc($resPacientes);

mysqli_close($conn);

respuesta([
    "citas_por_estado" => $citasPorEstado,
    "citas_por_mes"    => $citasPorMes,
    "valoracion_media" => (float) $valoracion['media'],
    "total_valoraciones" => (int) $valoracion['total'],
    "total_pacientes"  => (int) $pacientes['total']
]);
