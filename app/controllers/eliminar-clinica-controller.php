<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../config/database.php'; // Ajusta a tu conexión

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Método no permitido.']);
    exit;
}

$id = $_POST['id'] ?? null;

if (!$id) {
    echo json_encode(['status' => 'error', 'message' => 'ID de clínica no proporcionado.']);
    exit;
}

try {
    // Nota: Al eliminar la clínica, MySQL automáticamente borrará las sedes y los teléfonos 
    // asociados gracias a los constraints "ON DELETE CASCADE" que definiste en tus tablas.
    $stmt = $pdo->prepare("DELETE FROM clinicas WHERE id = ?");
    $stmt->execute([$id]);

    if ($stmt->rowCount() > 0) {
        echo json_encode(['status' => 'success', 'message' => 'Clínica y todas sus sedes asociadas eliminadas.']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'La clínica no existe o ya fue eliminada.']);
    }

} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => 'Error al eliminar: ' . $e->getMessage()]);
}