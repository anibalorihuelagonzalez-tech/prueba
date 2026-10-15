<?php

// Subimos dos niveles ('../../') para salir de 'config' y de 'app', llegando a la raíz donde está 'vendor'
require_once __DIR__ . '/../../vendor/autoload.php';

// Cargamos Dotenv apuntando también a la raíz del proyecto
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../../');
$dotenv->safeLoad();

/**
 * Función para obtener la conexión PDO utilizando un patrón estático interno
 * para reutilizar la misma conexión durante toda la ejecución.
 */
function conexion(): PDO {
    static $pdo = null;

    if ($pdo === null) {
        try {
            $host     = $_ENV['DB_HOST'] ?? '127.0.0.1';
            $port     = $_ENV['DB_PORT'] ?? '3306';
            $dbname   = $_ENV['DB_NAME'] ?? '';
            $username = $_ENV['DB_USER'] ?? '';
            $password = $_ENV['DB_PASS'] ?? '';
            $charset  = $_ENV['DB_CHARSET'] ?? 'utf8mb4';

            $dsn = "mysql:host={$host};port=$port;dbname=$dbname;charset=$charset";
            
            $options = [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ];

            $pdo = new PDO($dsn, $username, $password, $options);
        } catch (\PDOException $e) {
            throw new \RuntimeException("Error de conexión a la base de datos: " . $e->getMessage());
        }
    }

    return $pdo;
}