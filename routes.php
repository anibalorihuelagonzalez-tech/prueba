<?php

require_once __DIR__ . '/router.php';

// =========================================================================
// 1. VISTAS (GET)
// =========================================================================

// Inicio / Auth
get('/', 'app/views/index.php');
any('/clave', 'app/views/clave.php');

// Módulo: Ventas
get('/ventas/prefacturas', 'app/views/ventas/prefacturas.php');
get('/ventas/metodos-de-pago', 'app/views/ventas/metodos-de-pago.php');

// Módulo: Laboratorio
get('/laboratorio/clinicas-sedes', 'app/views/laboratorio/clinicas-sedes.php');
get('/laboratorio/pacientes', 'app/views/laboratorio/pacientes.php');
get('/laboratorio/casos', 'app/views/laboratorio/casos.php');

// Módulo: Logística / Envíos
get('/logistica/despachos', 'app/views/logistica/despachos.php');
get('/logistica/tracking', 'app/views/logistica/tracking.php');
get('/envios/tracking', 'app/views/logistica/tracking.php'); // Alias solicitado
get('/logistica/recepcion', 'app/views/logistica/recepcion.php');
get('/envios/recepcion', 'app/views/logistica/recepcion.php'); // Alias solicitado

// Módulo: Administración
get('/administracion/dashboard-financiero', 'app/views/administracion/dashboard-financiero.php');
get('/administracion/documentos', 'app/views/administracion/documentos.php');

// Módulo: Recursos Humanos
get('/recursos-humanos/personal', 'app/views/recursos-humanos/personal.php');
get('/recursos-humanos/cargos', 'app/views/recursos-humanos/cargos.php');
get('/recursos-humanos/departamentos', 'app/views/recursos-humanos/departamentos.php');

// Módulo: Configuraciones
get('/configuraciones/gestion-usuarios', 'app/views/configuraciones/gestion-usuarios.php');
get('/configuraciones/tasa-de-cambio', 'app/views/configuraciones/tasa-de-cambio.php');
get('/configuraciones/monedas', 'app/views/configuraciones/monedas.php');


// =========================================================================
// 2. CONTROLADORES (API / AJAX ENDPOINTS)
// =========================================================================

// --- Autenticación y Sesiones ---
any('/iniciar-sesion-controller', 'app/controllers/iniciar-sesion-controller.php');
any('/cerrar-sesion-controller', 'app/controllers/cerrar-sesion-controller.php');

// --- Gestión de Usuarios ---
any('/obtener-usuarios-controller', 'app/controllers/obtener-usuarios-controller.php');
any('/crear-usuario-controller', 'app/controllers/crear-usuario-controller.php');
any('/editar-usuario-controller', 'app/controllers/editar-usuario-controller.php');
any('/baja-usuario-controller', 'app/controllers/baja-usuario-controller.php');

// --- Tasas de Cambio y Monedas ---
any('/obtener-tasas-de-cambio-controller', 'app/controllers/obtener-tasas-de-cambio-controller.php');
any('/agregar-tasa-de-cambio-controller', 'app/controllers/agregar-tasa-de-cambio-controller.php');
post('/editar-tasa-de-cambio-controller', 'app/controllers/editar-tasa-de-cambio-controller.php');
any('/eliminar-tasa-de-cambio-controller', 'app/controllers/eliminar-tasa-de-cambio-controller.php');
any('/monedas-controller', 'app/controllers/monedas-controller.php');

// --- Clínicas ---
any('/obtener-clinicas-controller', 'app/controllers/obtener-clinicas-controller.php');
any('/agregar-clinica-controller', 'app/controllers/agregar-clinica-controller.php');
any('/editar-clinica-controller', 'app/controllers/editar-clinica-controller.php');
any('/eliminar-clinica-controller', 'app/controllers/eliminar-clinica-controller.php');

// --- Sedes / Sucursales ---
any('/obtener-sedes-controller', 'app/controllers/obtener-sedes-controller.php');
any('/agregar-sede-controller', 'app/controllers/agregar-sede-controller.php');
any('/editar-sede-controller', 'app/controllers/editar-sede-controller.php');
any('/eliminar-sede-controller', 'app/controllers/eliminar-sede-controller.php');

// --- Pacientes y Odontogramas ---
any('/obtener-pacientes-controller', 'app/controllers/obtener-pacientes-controller.php');
any('/agregar-paciente-controller', 'app/controllers/agregar-paciente-controller.php');
any('/editar-paciente-controller', 'app/controllers/editar-paciente-controller.php');
any('/eliminar-paciente-controller', 'app/controllers/eliminar-paciente-controller.php');
any('/obtener-odontograma-paciente-controller', 'app/controllers/obtener-odontograma-paciente-controller.php');
any('/editar-odontograma-paciente-controller', 'app/controllers/editar-odontograma-paciente-controller.php');

// --- Laboratorio: Gestión de Casos, Prótesis y Trazabilidad ---
any('/obtener-casos-controller', 'app/controllers/obtener-casos-controller.php');
any('/agregar-caso-controller', 'app/controllers/agregar-caso-controller.php');
any('/procesar-caso-controller', 'app/controllers/procesar-caso-controller.php');

// --- Logística: Despachos / Envíos (Cajas Grandes y Pequeñas) ---
any('/obtener-despachos-controller', 'app/controllers/obtener-despachos-controller.php');
any('/agregar-despacho-controller', 'app/controllers/agregar-despacho-controller.php');
any('/agregar-despachos-controller', 'app/controllers/agregar-despacho-controller.php'); // Alias plural por seguridad
any('/editar-despacho-controller', 'app/controllers/editar-despacho-controller.php');
any('/eliminar-despacho-controller', 'app/controllers/eliminar-despacho-controller.php');

// --- Logística: Flota de Repartidores, Tracking y Recepción ---
any('/repartidores-controller', 'app/controllers/repartidores-controller.php');
any('/tracking-controller', 'app/controllers/tracking-controller.php');
any('/recepcion-controller', 'app/controllers/recepcion-controller.php');

// --- Administración: Documentos, Facturación y Dashboard Financiero ---
any('/documentos-controller', 'app/controllers/documentos-controller.php');
any('/dashboard-financiero-controller', 'app/controllers/dashboard-financiero-controller.php');

// --- Recursos Humanos: Personal, Cargos y Departamentos ---
any('/recursos-humanos-controller', 'app/controllers/recursos-humanos-controller.php');
any('/cargos-controller', 'app/controllers/cargos-controller.php');
any('/departamentos-controller', 'app/controllers/departamentos-controller.php');


// =========================================================================
// 3. FALLBACK 404 (SIEMPRE AL FINAL DEL ARCHIVO)
// =========================================================================
any('/404', 'app/views/404.php');