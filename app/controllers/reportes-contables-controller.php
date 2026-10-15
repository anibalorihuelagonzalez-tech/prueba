<?php
class ReportesContablesController {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function obtenerBalanceComprobacion() {
        $sql = "SELECT pc.codigo, pc.nombre, pc.tipo, pc.naturaleza,
                    COALESCE(SUM(acd.debe), 0.00) as total_debe,
                    COALESCE(SUM(acd.haber), 0.00) as total_haber
                FROM plan_cuentas pc
                LEFT JOIN asientos_contables_detalles acd ON pc.id = acd.cuenta_id
                WHERE pc.permite_movimiento = 1
                GROUP BY pc.id, pc.codigo, pc.nombre, pc.tipo, pc.naturaleza
                ORDER BY pc.codigo ASC";
        $stmt = $this->pdo->query($sql);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}