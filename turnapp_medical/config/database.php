<?php
function getConexion() {
    $host     = 'fdb1032.awardspace.net';
    $dbname   = '4741065_turnappmedical';
    $usuario  = '4741065_turnappmedical';
    $password = 'Masuco04.';
    $puerto   = 3306;

    $conn = mysqli_connect($host, $usuario, $password, $dbname, $puerto);

    if (!$conn) {
        die(json_encode(['error' => 'Error de conexión: ' . mysqli_connect_error()]));
    }
    mysqli_set_charset($conn, 'utf8mb4');
    return $conn;
}