<?php
// Controlador para edición de tasa de cambio (alias de compatibilidad)
$_POST['action'] = $_POST['action'] ?? 'update';
require_once __DIR__ . '/agregar-tasa-de-cambio-controller.php';