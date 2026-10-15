<?php
// app/controllers/dashboard-financiero-controller.php
session_start();
header('Content-Type: application/json; charset=utf-8');

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../helpers/auth.php';

if (!Auth::check()) {
    http_response_code(401);
    echo json_encode(['status' => 'error', 'message' => 'No autorizado.']);
    exit;
}

$pdo = conexion();
$action = $_POST['action'] ?? $_GET['action'] ?? '';

try {
    switch ($action) {

        // =========================================================================
        // 1. OBTENER MÉTRICAS FINANCIERAS COMPLETAS
        // =========================================================================
        case 'obtener_metricas':
            // Tasa de cambio actual
            $stmtTasa = $pdo->query("SELECT tasa FROM tasas_cambio WHERE is_active = 1 AND deleted_at IS NULL ORDER BY vigente_desde DESC, id DESC LIMIT 1");
            $tasaActual = (float)($stmtTasa->fetchColumn() ?: 1.00);

            // Resumen de Documentos Administrativos
            $stmtDocs = $pdo->query("
                SELECT 
                    id, 
                    numero_documento, 
                    tipo_documento, 
                    clinica_id, 
                    monto_usd, 
                    monto_bs, 
                    estatus, 
                    fecha_emision 
                FROM documentos_administrativos
            ");
            $docs = $stmtDocs->fetchAll(\PDO::FETCH_ASSOC);

            $facturadoUsd = 0.0;
            $facturadoBs  = 0.0;
            $cobradoUsd   = 0.0;
            $cobradoBs    = 0.0;
            $porCobrarUsd = 0.0;
            $porCobrarBs  = 0.0;
            $anuladoUsd   = 0.0;

            foreach ($docs as $d) {
                $usd = (float)$d['monto_usd'];
                $bs  = (float)$d['monto_bs'];

                if ($d['estatus'] === 'PAGADO') {
                    $cobradoUsd   += $usd;
                    $cobradoBs    += $bs;
                    $facturadoUsd += $usd;
                    $facturadoBs  += $bs;
                } elseif ($d['estatus'] === 'EMITIDO') {
                    $porCobrarUsd += $usd;
                    $porCobrarBs  += $bs;
                    $facturadoUsd += $usd;
                    $facturadoBs  += $bs;
                } elseif ($d['estatus'] === 'ANULADO') {
                    $anuladoUsd += $usd;
                }
            }

            // Resumen por Clínica
            $sqlClinicas = "
                SELECT 
                    c.id,
                    c.razon_social,
                    c.tipo_documento,
                    c.numero_documento,
                    c.telefono,
                    COALESCE(SUM(CASE WHEN d.estatus != 'ANULADO' THEN d.monto_usd ELSE 0 END), 0) AS total_facturado,
                    COALESCE(SUM(CASE WHEN d.estatus = 'PAGADO' THEN d.monto_usd ELSE 0 END), 0) AS total_cobrado,
                    COALESCE(SUM(CASE WHEN d.estatus = 'EMITIDO' THEN d.monto_usd ELSE 0 END), 0) AS saldo_pendiente,
                    COUNT(d.id) AS total_documentos
                FROM clinicas c
                LEFT JOIN documentos_administrativos d ON c.id = d.clinica_id
                GROUP BY c.id
                ORDER BY saldo_pendiente DESC, total_facturado DESC
            ";
            $resumenClinicas = $pdo->query($sqlClinicas)->fetchAll(\PDO::FETCH_ASSOC);

            // Resumen por Categorías de Servicios Dentales
            $sqlCat = "
                SELECT 
                    COALESCE(cs.nombre, 'General / Varios') AS categoria_nombre,
                    COUNT(ot.id) AS total_casos,
                    COALESCE(SUM(sv.precio), 0) AS subtotal_usd
                FROM ordenes_trabajo ot
                LEFT JOIN servicios sv ON ot.servicio_id = sv.id
                LEFT JOIN categorias_servicios cs ON sv.categoria_id = cs.id
                GROUP BY cs.id
                ORDER BY subtotal_usd DESC
            ";
            $distribucionServicios = $pdo->query($sqlCat)->fetchAll(\PDO::FETCH_ASSOC);

            // Cuentas por Cobrar Pendientes Recientes
            $sqlPendientes = "
                SELECT 
                    d.id,
                    d.numero_documento,
                    d.tipo_documento,
                    c.razon_social AS clinica_nombre,
                    d.monto_usd,
                    d.monto_bs,
                    DATE_FORMAT(d.fecha_emision, '%d/%m/%Y') AS fecha_emision_fmt,
                    DATEDIFF(NOW(), d.fecha_emision) AS dias_antiguedad
                FROM documentos_administrativos d
                INNER JOIN clinicas c ON d.clinica_id = c.id
                WHERE d.estatus = 'EMITIDO'
                ORDER BY d.fecha_emision ASC
                LIMIT 15
            ";
            $cuentasPendientes = $pdo->query($sqlPendientes)->fetchAll(\PDO::FETCH_ASSOC);

            echo json_encode([
                'status' => 'success',
                'resumen' => [
                    'facturado_usd'  => round($facturadoUsd, 2),
                    'facturado_bs'   => round($facturadoBs, 2),
                    'cobrado_usd'    => round($cobradoUsd, 2),
                    'cobrado_bs'     => round($cobradoBs, 2),
                    'por_cobrar_usd' => round($porCobrarUsd, 2),
                    'por_cobrar_bs'  => round($porCobrarBs, 2),
                    'anulado_usd'    => round($anuladoUsd, 2),
                    'tasa_bcv'       => $tasaActual
                ],
                'clinicas'              => $resumenClinicas,
                'distribucion_servicios' => $distribucionServicios,
                'cuentas_pendientes'    => $cuentasPendientes
            ]);
            break;

        // =========================================================================
        // 2. REGISTRAR COBRO RÁPIDO DESDE EL DASHBOARD
        // =========================================================================
        case 'marcar_cobrado':
            $docId = (int)($_POST['id'] ?? 0);
            if ($docId <= 0) {
                echo json_encode(['status' => 'error', 'message' => 'ID inválido.']);
                exit;
            }

            $stmt = $pdo->prepare("UPDATE documentos_administrativos SET estatus = 'PAGADO' WHERE id = ?");
            $stmt->execute([$docId]);

            echo json_encode([
                'status'  => 'success',
                'message' => 'Pago confirmado. La cuenta por cobrar ha sido saldada.'
            ]);
            break;

        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no permitida.']);
            break;
    }

} catch (\Exception $e) {
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => 'Error en el servidor: ' . $e->getMessage()]);
}
