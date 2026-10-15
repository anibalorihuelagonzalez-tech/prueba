<?php
session_start();

header('Content-Type: application/json; charset=utf-8');

// Ruta corregida para subir desde app/controllers/ hasta app/config/
require_once __DIR__ . '/../config/database.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'status' => 'error',
        'message' => 'Método no permitido.'
    ]);
    exit();
}

$inputData = json_decode(file_get_contents('php://input'), true);

// Mapeamos 'email' y 'password' que envía tu JavaScript
$correo = trim($inputData['email'] ?? $_POST['correo_electronico'] ?? '');
$contrasena = $inputData['password'] ?? $_POST['contrasena'] ?? '';

if (empty($correo) || empty($contrasena)) {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => 'Por favor, completa todos los campos.'
    ]);
    exit();
}

try {
    $db = conexion();

    // Buscamos al usuario por su correo electrónico junto a su rol
    $stmt = $db->prepare("
        SELECT u.id, u.primer_nombre, u.primer_apellido, u.correo_electronico, u.contrasena, u.rol_id, r.rol AS rol_nombre 
        FROM usuarios u 
        LEFT JOIN roles_usuarios r ON u.rol_id = r.id 
        WHERE u.correo_electronico = ?
    ");
    $stmt->execute([$correo]);
    $usuario = $stmt->fetch();

    if ($usuario && password_verify($contrasena, $usuario['contrasena'])) {
        
        require_once __DIR__ . '/../helpers/auth.php';
        Auth::login($usuario);

        http_response_code(200);
        echo json_encode([
            'status' => 'success',
            'message' => 'Inicio de sesión exitoso.',
            'redirect' => '/laboratorio/clinicas-sedes',
            'data' => [
                'id' => $usuario['id'],
                'nombre' => $usuario['primer_nombre'] . ' ' . $usuario['primer_apellido'],
                'correo' => $usuario['correo_electronico'],
                'rol_id' => $usuario['rol_id'],
                'rol' => $usuario['rol_nombre'] ?? ''
            ]
        ]);
        exit();

    } else {
        http_response_code(401);
        echo json_encode([
            'status' => 'error',
            'message' => 'Correo electrónico o contraseña incorrectos.'
        ]);
        exit();
    }

} catch (\Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => 'Ocurrió un error inesperado en el servidor.'
    ]);
    exit();
}