<?php
// ============================================================
//  TurnApp Medical — Helpers comunes para la API
// ============================================================

function setCabeceras() {
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(200);
        exit();
    }
}

function respuesta($datos, $codigo = 200) {
    http_response_code($codigo);
    echo json_encode($datos, JSON_UNESCAPED_UNICODE);
    exit();
}

function respuestaError($mensaje, $codigo = 400) {
    http_response_code($codigo);
    echo json_encode(["error" => $mensaje], JSON_UNESCAPED_UNICODE);
    exit();
}

function getBodyJson() {
    $body = file_get_contents("php://input");
    return json_decode($body, true);
}
