<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-chart-line text-primary"></i> Contabilidad y Reportes Financieros</h2>
        <button class="btn btn-success" onclick="window.print()"><i class="fas fa-print"></i> Imprimir</button>
    </div>

    <div class="card shadow-sm p-4 bg-white">
        <h4 class="mb-3">Gestión de Cobranza y WhatsApp</h4>
        <p class="text-muted">Haz clic en el botón para enviar un recordatorio de pago directamente al WhatsApp de tu cliente sin usar APIs de pago.</p>
        
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>Cliente / Empresa</th>
                        <th>Teléfono</th>
                        <th>Deuda Pendiente</th>
                        <th>Acción Rápida</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Clínicas Caracas C.A.</td>
                        <td>+584129989473</td>
                        <td class="font-weight-bold text-danger">$150.00</td>
                        <td>
                            <button class="btn btn-success btn-sm" onclick="enviarWhatsApp('584129989473', 'Clínicas Caracas', '150.00', 'FAC-001')">
                                <i class="fab fa-whatsapp"></i> Cobrar por WhatsApp
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function enviarWhatsApp(telefono, cliente, monto, factura) {
    let mensaje = `Estimado(a) *${cliente}*, le escribimos de la administración para recordarle que mantiene pendiente la factura *${factura}* por un monto de *$${monto}*. Agradecemos su pronto pago. ¡Gracias!`;
    let url = `https://wa.me/${telefono}?text=${encodeURIComponent(mensaje)}`;
    window.open(url, '_blank');
}
</script>