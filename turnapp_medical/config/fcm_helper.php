<?php
// ============================================================
//  TurnApp Medical — Helper para enviar notificaciones FCM
// ============================================================

define('FCM_SERVER_KEY', 'BO0Exiyx3OUlKrC-UfbqDt8QPsihL31j52EawXCCoPalOlm7a9POkuAhm7JHiXTpqAyN_kajTr8VX2QvfMg_gA0');
define('FCM_URL', 'https://fcm.googleapis.com/fcm/send');

function enviarNotificacion($fcmToken, $titulo, $mensaje) {
    if (empty($fcmToken)) return false;

    $datos = [
        'to' => $fcmToken,
        'notification' => [
            'title' => $titulo,
            'body'  => $mensaje,
            'sound' => 'default'
        ],
        'data' => [
            'titulo'  => $titulo,
            'mensaje' => $mensaje
        ]
    ];

    $headers = [
        'Authorization: key=' . FCM_SERVER_KEY,
        'Content-Type: application/json'
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, FCM_URL);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($datos));
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $resultado = curl_exec($ch);
    curl_close($ch);

    return $resultado;
}
