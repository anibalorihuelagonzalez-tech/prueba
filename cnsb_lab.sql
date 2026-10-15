-- =========================================================================
-- BASE DE DATOS DENTAL LAB: cnsb_lab (Producción Completa y Verificada)
-- Motor: MariaDB 10.4+ / MySQL 8.0+
-- Generado automáticamente desde el esquema activo verificado en producción
-- =========================================================================

-- Descomenta si deseas que el script cree la base de datos automáticamente:
-- CREATE DATABASE IF NOT EXISTS `cnsb_lab` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE `cnsb_lab`;

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- =========================================================
-- 1. DEFINICIÓN DE TABLAS (ESTRUCTURA DDL)
-- =========================================================

-- Estructura para la tabla: `roles_usuarios`
DROP TABLE IF EXISTS `roles_usuarios`;
CREATE TABLE IF NOT EXISTS `roles_usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol` varchar(100) NOT NULL,
  `fecha_hora_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `estatus_empleado`
DROP TABLE IF EXISTS `estatus_empleado`;
CREATE TABLE IF NOT EXISTS `estatus_empleado` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `contratos`
DROP TABLE IF EXISTS `contratos`;
CREATE TABLE IF NOT EXISTS `contratos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_contrato` enum('INDETERMINADO','DETERMINADO') NOT NULL DEFAULT 'INDETERMINADO',
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `departamentos`
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `monedas`
DROP TABLE IF EXISTS `monedas`;
CREATE TABLE IF NOT EXISTS `monedas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` char(3) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `simbolo` char(5) NOT NULL,
  `decimales` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `es_base` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_codigo` (`codigo`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_es_base` (`es_base`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `categorias_servicios`
DROP TABLE IF EXISTS `categorias_servicios`;
CREATE TABLE IF NOT EXISTS `categorias_servicios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_hora_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `clinicas`
DROP TABLE IF EXISTS `clinicas`;
CREATE TABLE IF NOT EXISTS `clinicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(100) NOT NULL,
  `tipo_documento` enum('E','V','J') NOT NULL,
  `numero_documento` varchar(10) NOT NULL,
  `direccion_fiscal` varchar(255) NOT NULL,
  `telefono` varchar(11) NOT NULL,
  `estatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_clinica_documento` (`numero_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `repartidores`
DROP TABLE IF EXISTS `repartidores`;
CREATE TABLE IF NOT EXISTS `repartidores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) NOT NULL,
  `placa_vehiculo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `historial_envios_estatus`
DROP TABLE IF EXISTS `historial_envios_estatus`;
CREATE TABLE IF NOT EXISTS `historial_envios_estatus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `etapas_produccion`
DROP TABLE IF EXISTS `etapas_produccion`;
CREATE TABLE IF NOT EXISTS `etapas_produccion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `orden` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `usuarios`
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol_id` int(10) unsigned NOT NULL,
  `primer_nombre` varchar(45) NOT NULL,
  `primer_apellido` varchar(45) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `correo_electronico` varchar(150) NOT NULL,
  `contrasena` varchar(130) NOT NULL,
  `fecha_hora_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles_usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `cargos`
DROP TABLE IF EXISTS `cargos`;
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `departamento` varchar(100) NOT NULL,
  `departamento_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `servicios`
DROP TABLE IF EXISTS `servicios`;
CREATE TABLE IF NOT EXISTS `servicios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `categoria_id` int(10) unsigned NOT NULL,
  `correlativo` tinyint(3) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rango_min_piezas` tinyint(3) unsigned NOT NULL,
  `rango_max_piezas` tinyint(3) unsigned NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_hora_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_actualizacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_servicio_categoria` (`categoria_id`),
  CONSTRAINT `fk_servicio_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `sedes`
DROP TABLE IF EXISTS `sedes`;
CREATE TABLE IF NOT EXISTS `sedes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinica_id` int(10) unsigned NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion_fisica` varchar(255) NOT NULL,
  `latitud` varchar(45) DEFAULT NULL,
  `longitud` varchar(45) DEFAULT NULL,
  `principal` tinyint(1) NOT NULL DEFAULT 0,
  `estatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sede_clinica` (`clinica_id`),
  CONSTRAINT `fk_sede_clinica` FOREIGN KEY (`clinica_id`) REFERENCES `clinicas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `tasas_cambio`
DROP TABLE IF EXISTS `tasas_cambio`;
CREATE TABLE IF NOT EXISTS `tasas_cambio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `moneda_origen_id` int(10) unsigned NOT NULL,
  `moneda_destino_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned DEFAULT NULL,
  `tasa` decimal(20,8) unsigned NOT NULL,
  `fuente` varchar(45) DEFAULT NULL,
  `vigente_desde` datetime NOT NULL,
  `vigente_hasta` datetime DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_par_monedas` (`moneda_origen_id`,`moneda_destino_id`),
  KEY `idx_moneda_destino_id` (`moneda_destino_id`),
  KEY `idx_vigencia` (`vigente_desde`,`vigente_hasta`),
  KEY `idx_is_active` (`is_active`),
  KEY `idx_fuente` (`fuente`),
  KEY `fk_tasa_usuario` (`usuario_id`),
  CONSTRAINT `fk_tasa_destino` FOREIGN KEY (`moneda_destino_id`) REFERENCES `monedas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tasa_origen` FOREIGN KEY (`moneda_origen_id`) REFERENCES `monedas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_tasa_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `empleados`
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE IF NOT EXISTS `empleados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned DEFAULT NULL,
  `cargo_id` int(10) unsigned DEFAULT NULL,
  `estatus_empleado_id` int(10) unsigned NOT NULL DEFAULT 1,
  `contrato_id` int(10) unsigned DEFAULT NULL,
  `primer_nombre` varchar(45) NOT NULL,
  `segundo_nombre` varchar(45) DEFAULT NULL,
  `primer_apellido` varchar(45) NOT NULL,
  `segundo_apellido` varchar(45) DEFAULT NULL,
  `tipo_documento` enum('V','E','J','P') NOT NULL DEFAULT 'V',
  `numero_documento` varchar(15) NOT NULL,
  `correo_electronico` varchar(150) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_ingreso` date NOT NULL,
  `salario_base_ves` decimal(15,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_emp_usuario` (`usuario_id`),
  KEY `idx_emp_cargo` (`cargo_id`),
  KEY `idx_emp_estatus` (`estatus_empleado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estructura para la tabla: `numeros_telefono`
DROP TABLE IF EXISTS `numeros_telefono`;
CREATE TABLE IF NOT EXISTS `numeros_telefono` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sede_id` int(10) unsigned NOT NULL,
  `numero_telefono` varchar(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_telefono_sede` (`sede_id`),
  CONSTRAINT `fk_telefono_sede` FOREIGN KEY (`sede_id`) REFERENCES `sedes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `pacientes`
DROP TABLE IF EXISTS `pacientes`;
CREATE TABLE IF NOT EXISTS `pacientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(45) NOT NULL,
  `segundo_nombre` varchar(45) DEFAULT NULL,
  `primer_apellido` varchar(45) NOT NULL,
  `segundo_apellido` varchar(45) DEFAULT NULL,
  `tipo_documento` enum('V','E') NOT NULL,
  `numero_documento` varchar(8) NOT NULL,
  `sexo` enum('H','M') NOT NULL,
  `clinica_id` int(10) unsigned DEFAULT NULL,
  `sede_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_paciente_documento` (`numero_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `envios`
DROP TABLE IF EXISTS `envios`;
CREATE TABLE IF NOT EXISTS `envios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sede_id` int(10) unsigned NOT NULL,
  `repartidor_id` int(10) unsigned NOT NULL,
  `estatus_envio` enum('PREPARADO','TRANSITO','RECIBIDO') NOT NULL,
  `cantidad_casos` int(11) NOT NULL,
  `codigo_qr` varchar(45) NOT NULL,
  `direccion_movimiento` enum('ENTRADA','SALIDA') NOT NULL,
  `fecha_hora_recepcion` timestamp NULL DEFAULT NULL,
  `fecha_hora_despacho` timestamp NULL DEFAULT NULL,
  `fecha_hora_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_programada` datetime DEFAULT NULL,
  `notas_cancelacion` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_envio_qr` (`codigo_qr`),
  KEY `idx_envio_sede` (`sede_id`),
  KEY `idx_envio_repartidor` (`repartidor_id`),
  CONSTRAINT `fk_envio_repartidor` FOREIGN KEY (`repartidor_id`) REFERENCES `repartidores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_envio_sede` FOREIGN KEY (`sede_id`) REFERENCES `sedes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `pacientes_odontogramas`
DROP TABLE IF EXISTS `pacientes_odontogramas`;
CREATE TABLE IF NOT EXISTS `pacientes_odontogramas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paciente_id` int(10) unsigned NOT NULL,
  `diente_numero` tinyint(2) NOT NULL,
  `estado_diente` enum('AUSENTE','CON CARIE','A EXTRAER','SANO') NOT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_odontograma_paciente` (`paciente_id`),
  CONSTRAINT `fk_odontograma_paciente` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `historial_envios`
DROP TABLE IF EXISTS `historial_envios`;
CREATE TABLE IF NOT EXISTS `historial_envios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envio_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `historial_envios_estatus_id` int(10) unsigned NOT NULL,
  `notas` text DEFAULT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_historial_usuario` (`usuario_id`),
  KEY `idx_historial_envio` (`envio_id`),
  KEY `idx_historial_estatus` (`historial_envios_estatus_id`),
  CONSTRAINT `fk_historial_envio` FOREIGN KEY (`envio_id`) REFERENCES `envios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_historial_estatus` FOREIGN KEY (`historial_envios_estatus_id`) REFERENCES `historial_envios_estatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_historial_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `ordenes_trabajo`
DROP TABLE IF EXISTS `ordenes_trabajo`;
CREATE TABLE IF NOT EXISTS `ordenes_trabajo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clinica_id` int(10) unsigned NOT NULL,
  `servicio_id` int(10) unsigned NOT NULL,
  `paciente_id` int(10) unsigned NOT NULL,
  `envio_id` int(10) unsigned DEFAULT NULL,
  `codigo_qr` varchar(45) NOT NULL,
  `cantidad_piezas_exacta` tinyint(3) unsigned NOT NULL,
  `estatus_actual` varchar(45) NOT NULL,
  `fecha_ingreso` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_hora_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `sede_id` int(10) unsigned DEFAULT NULL,
  `cantidad_protesis` int(10) unsigned NOT NULL DEFAULT 1,
  `protesista_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_orden_trabajo_qr` (`codigo_qr`),
  KEY `idx_orden_clinica` (`clinica_id`),
  KEY `idx_orden_servicio` (`servicio_id`),
  KEY `idx_orden_paciente` (`paciente_id`),
  KEY `idx_orden_envio` (`envio_id`),
  CONSTRAINT `fk_orden_clinica` FOREIGN KEY (`clinica_id`) REFERENCES `clinicas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orden_envio` FOREIGN KEY (`envio_id`) REFERENCES `envios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_orden_paciente` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orden_servicio` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `ordenes_detalle`
DROP TABLE IF EXISTS `ordenes_detalle`;
CREATE TABLE IF NOT EXISTS `ordenes_detalle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orden_trabajo_id` int(10) unsigned NOT NULL,
  `servicio_id` int(10) unsigned NOT NULL,
  `etapa_produccion_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_detalle_orden` (`orden_trabajo_id`),
  KEY `idx_detalle_servicio` (`servicio_id`),
  KEY `idx_detalle_etapa` (`etapa_produccion_id`),
  CONSTRAINT `fk_detalle_etapa` FOREIGN KEY (`etapa_produccion_id`) REFERENCES `etapas_produccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_orden` FOREIGN KEY (`orden_trabajo_id`) REFERENCES `ordenes_trabajo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_servicio` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `historial_trazabilidad`
DROP TABLE IF EXISTS `historial_trazabilidad`;
CREATE TABLE IF NOT EXISTS `historial_trazabilidad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orden_trabajo_id` int(10) unsigned NOT NULL,
  `orden_detalle_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `estatus` varchar(45) NOT NULL,
  `ubicacion` varchar(45) NOT NULL,
  `notas` varchar(255) DEFAULT NULL,
  `fecha_cambio` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_trazabilidad_orden` (`orden_trabajo_id`),
  KEY `idx_trazabilidad_detalle` (`orden_detalle_id`),
  KEY `idx_trazabilidad_usuario` (`usuario_id`),
  CONSTRAINT `fk_trazabilidad_detalle` FOREIGN KEY (`orden_detalle_id`) REFERENCES `ordenes_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_trazabilidad_orden` FOREIGN KEY (`orden_trabajo_id`) REFERENCES `ordenes_trabajo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_trazabilidad_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Estructura para la tabla: `documentos_administrativos`
DROP TABLE IF EXISTS `documentos_administrativos`;
CREATE TABLE IF NOT EXISTS `documentos_administrativos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `numero_documento` varchar(45) NOT NULL,
  `tipo_documento` enum('FACTURA','ORDEN_TRABAJO','PRESUPUESTO','GARANTIA','GUIA_ENTREGA') NOT NULL,
  `clinica_id` int(10) unsigned NOT NULL,
  `sede_id` int(10) unsigned DEFAULT NULL,
  `orden_trabajo_id` int(10) unsigned DEFAULT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `tasa_cambio` decimal(15,4) NOT NULL DEFAULT 1.0000,
  `monto_usd` decimal(12,2) NOT NULL DEFAULT 0.00,
  `monto_bs` decimal(15,2) NOT NULL DEFAULT 0.00,
  `estatus` enum('EMITIDO','PAGADO','ANULADO') NOT NULL DEFAULT 'EMITIDO',
  `observaciones` text DEFAULT NULL,
  `items_detalle` longtext DEFAULT NULL,
  `fecha_emision` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_doc_clinica` (`clinica_id`),
  KEY `idx_doc_orden` (`orden_trabajo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================
-- 2. DATOS INICIALES Y CATÁLOGOS BASE (SEED DATA)
-- =========================================================

-- Datos para la tabla: `roles_usuarios` (5 registros)
INSERT INTO `roles_usuarios` (`id`, `rol`, `fecha_hora_creacion`, `fecha_hora_actualizacion`) VALUES
  (1, 'SUPER USUARIO', '2026-10-12 00:00:00', '2026-10-12 00:00:00'),
  (2, 'ADMINISTRADOR', '2026-10-12 00:00:00', '2026-10-12 00:00:00'),
  (3, 'RECEPCIONISTA', '2026-10-12 00:00:00', '2026-10-12 00:00:00'),
  (4, 'PROTESISTA', '2026-10-12 00:00:00', '2026-10-12 00:00:00'),
  (5, 'CLINICA ADMIN', '2026-10-12 00:00:00', '2026-10-12 00:00:00');

-- Datos para la tabla: `estatus_empleado` (4 registros)
INSERT INTO `estatus_empleado` (`id`, `nombre`) VALUES
  (1, 'Activo'),
  (2, 'En Vacaciones'),
  (3, 'Licencia Médica'),
  (4, 'Inactivo / Egresado');

-- Datos para la tabla: `contratos` (3 registros)
INSERT INTO `contratos` (`id`, `tipo_contrato`, `fecha_inicio`, `fecha_fin`) VALUES
  (1, 'INDETERMINADO', '2025-01-15', NULL),
  (2, 'DETERMINADO', '2026-01-01', '2026-12-31'),
  (3, 'DETERMINADO', '2026-10-14', NULL);

-- Datos para la tabla: `departamentos` (5 registros)
INSERT INTO `departamentos` (`id`, `nombre`, `descripcion`, `is_active`, `created_at`, `updated_at`) VALUES
  (1, 'Laboratorio Dental', 'Área técnica de confección, modelado, cerámica y diseño de prótesis.', 1, '2026-10-14 13:53:38', '2026-10-14 13:53:38'),
  (2, 'Administración y Finanzas', 'Gestión administrativa, contabilidad, cobros y presupuestos.', 1, '2026-10-14 13:53:38', '2026-10-14 13:53:38'),
  (3, 'Atención y Recepción', 'Recepción de casos, atención a clínicas y odontólogos.', 1, '2026-10-14 13:53:38', '2026-10-14 13:53:38'),
  (4, 'Dirección General', 'Gerencia general y toma de decisiones estratégicas del laboratorio.', 1, '2026-10-14 13:53:38', '2026-10-14 13:53:38'),
  (5, 'Logística y Envíos', 'Distribución, tracking y despacho de cajas dentales a clínicas.', 1, '2026-10-14 13:53:38', '2026-10-14 13:53:38');

-- Datos para la tabla: `monedas` (5 registros)
INSERT INTO `monedas` (`id`, `codigo`, `nombre`, `simbolo`, `decimales`, `es_base`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
  (1, 'USD', 'Dólar Estadounidense', '$', 2, 1, 1, '2026-10-13 22:05:37', '2026-10-13 22:05:37', NULL),
  (2, 'VES', 'Bolívar Venezolano', 'Bs.', 2, '0', 1, '2026-10-13 22:05:37', '2026-10-13 22:05:37', NULL),
  (3, 'EUR', 'Euro', '€', 2, '0', 1, '2026-10-13 22:05:37', '2026-10-13 22:05:37', NULL),
  (4, 'COP', 'Peso Colombiano', 'Col$', 2, '0', '0', '2026-10-13 22:05:37', '2026-10-14 13:13:57', '2026-10-14 13:13:57'),
  (5, 'LIB', 'LIBRA', '%', 2, '0', 1, '2026-10-14 13:43:58', '2026-10-14 13:43:58', NULL);

-- Datos para la tabla: `categorias_servicios` (1 registros)
INSERT INTO `categorias_servicios` (`id`, `nombre`, `descripcion`, `fecha_hora_creacion`, `fecha_hora_actualizacion`) VALUES
  (1, 'PROTESIS DE ACRILICO CONVENCIONAL', 'ACRILICO', '2026-10-12 22:11:18', '2026-10-12 22:11:50');

-- Datos para la tabla: `clinicas` (4 registros)
INSERT INTO `clinicas` (`id`, `razon_social`, `tipo_documento`, `numero_documento`, `direccion_fiscal`, `telefono`, `estatus`) VALUES
  (1, 'CLINICAS CARACAS', 'J', 36926515, 'AVENIDA BOLIVAR SECTOR OLIVOS', '04129989473', 1),
  (2, 'SHEBORA', 'J', 147585252, 'asdasd', '04123698521', 1),
  (3, 'clinica de prueba', 'J', 123456, 'afdwefefw', '04123698521', 1),
  (4, 'CENTRO NACIONAL DE SALUD BUCAL', 'J', 507566498, 'AV FRANCISCO DE MIRANDA EDIF TORRE PLANINCO PISO\r\nMEZZANINA OF 2 URB CHACAO CARACAS (CHACAO) MIRANDA ZONA POSTAL 1060', '04244040117', 1);

-- Datos para la tabla: `repartidores` (1 registros)
INSERT INTO `repartidores` (`id`, `nombres`, `apellidos`, `foto`, `telefono`, `placa_vehiculo`) VALUES
  (1, 'DEIVER', 'MARTINEZ', NULL, '04129989473', 258369);

-- Datos para la tabla: `historial_envios_estatus` (4 registros)
INSERT INTO `historial_envios_estatus` (`id`, `nombre`) VALUES
  (1, 'CREADO'),
  (2, 'RECOLECTADO'),
  (3, 'EN TRANSITO'),
  (4, 'ENTREGADO');

-- Datos para la tabla: `etapas_produccion` (4 registros)
INSERT INTO `etapas_produccion` (`id`, `nombre`, `orden`) VALUES
  (1, 'TOMA DE IMPRESION', 1),
  (2, 'PRUEBA DE RODETE', 2),
  (3, 'ENFILADO', 3),
  (4, 'INSTALACION', 4);

-- Datos para la tabla: `usuarios` (3 registros)
INSERT INTO `usuarios` (`id`, `rol_id`, `primer_nombre`, `primer_apellido`, `foto`, `correo_electronico`, `contrasena`, `fecha_hora_creacion`, `fecha_hora_actualizacion`, `estatus`) VALUES
  (1, 4, 'DEIVER', 'MARTINEZ', '/uploads/personal/emp_1792005082_5a3810c7.jpg', 'crrpersonal90@gmail.com', '$2y$10$rExoAbhR5ajREMbpa.JtN.pV1q8JpqpZIY04vIim2qKBYBAwSnWLa', '2026-10-12 11:10:37', '2026-10-14 15:11:22', 1),
  (4, 1, 'holakk', 'smieth', NULL, 'hola@gmail.com', '$2y$10$rWH05H8hLyXxczbRCVKGPOZQPhGgNyO5//UNmP.wmet3HXhhYSZl6', '2026-10-12 17:41:30', '2026-10-13 13:58:54', 1),
  (5, 1, 'DOUGLAS', 'MAR', NULL, 'douglas@gmail.com', '$2y$10$ECBst5j.ZYmFcgKK3Ub8Nu.gA6Z.z.dTD594MPETSpkX4/l8tWdkG', '2026-10-14 13:44:50', NULL, 1);

-- Datos para la tabla: `cargos` (4 registros)
INSERT INTO `cargos` (`id`, `nombre`, `descripcion`, `departamento`, `departamento_id`, `is_active`, `created_at`) VALUES
  (10, 'Protesistas', NULL, 'Laboratorio Dental', 1, 1, '2026-10-14 13:53:38'),
  (11, 'Administrador', NULL, 'Administración y Finanzas', 2, 1, '2026-10-14 13:53:38'),
  (12, 'Recepcionista', NULL, 'Atención y Recepción', 3, 1, '2026-10-14 13:53:38'),
  (13, 'Director General', NULL, 'Dirección General', 4, 1, '2026-10-14 13:53:38');

-- Datos para la tabla: `servicios` (4 registros)
INSERT INTO `servicios` (`id`, `categoria_id`, `correlativo`, `nombre`, `rango_min_piezas`, `rango_max_piezas`, `precio`, `activo`, `fecha_hora_creacion`, `fecha_hora_actualizacion`) VALUES
  (1, 1, 100, 'Prótesis Acrílica (1-3 Piezas)', 1, 3, 20.00, 1, '2026-10-12 22:12:22', '2026-10-14 14:06:04'),
  (2, 1, 101, 'Prótesis Total Removible Superior/Inferior', 14, 28, 45.00, 1, '2026-10-14 14:06:04', NULL),
  (3, 1, 102, 'Corona Metal-Porcelana Ceramco', 1, 1, 35.00, 1, '2026-10-14 14:06:04', NULL),
  (4, 1, 103, 'Placa Miorelajante / Férula Bruxismo', 1, 1, 25.00, 1, '2026-10-14 14:06:04', NULL);

-- Datos para la tabla: `sedes` (9 registros)
INSERT INTO `sedes` (`id`, `clinica_id`, `nombre`, `direccion_fisica`, `latitud`, `longitud`, `principal`, `estatus`) VALUES
  (1, 1, 'asdasdasd', 'asdasd', NULL, NULL, '0', 1),
  (2, 1, 'LA URBINA', 'LA URBINA CALLE 3', NULL, NULL, '0', 1),
  (3, 1, 'chacao', 'chacao', 10258, 36258, '0', 1),
  (4, 3, 'clinica de prueba 1', 'wvfwefwefewf', NULL, NULL, 1, 1),
  (5, 3, 'clinica de preuba 1 sede 2', 'efwef', NULL, NULL, '0', 1),
  (6, 2, 'shebora princopal', 'sdfgerg', NULL, NULL, 1, 1),
  (7, 2, 'shebora 2 sede 2', 'zczxcxz', NULL, NULL, '0', 1),
  (8, 4, 'CENTRO NACIONAL DE SALUD BUCAL CHACAO', 'AV FRANCISCO DE MIRANDA EDIF TORRE PLANINCO PISO\r\nMEZZANINA OF 2 URB CHACAO CARACAS (CHACAO) MIRANDA ZONA POSTAL 1060', NULL, NULL, '0', 1),
  (9, 4, 'CENTRO NACIONAL DE SALUD BUCAL LA URBINA', 'Calle 3-A, Urbanización La Urbina, Caracas, Estado Miranda, código postal 1073', NULL, NULL, 1, 1);

-- Datos para la tabla: `tasas_cambio` (5 registros)
INSERT INTO `tasas_cambio` (`id`, `moneda_origen_id`, `moneda_destino_id`, `usuario_id`, `tasa`, `fuente`, `vigente_desde`, `vigente_hasta`, `observaciones`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
  (1, 1, 2, NULL, 815.63000000, 'BCV', '2026-10-12 00:00:00', NULL, NULL, '0', '2026-10-12 18:27:49', '2026-10-12 18:28:06', NULL),
  (2, 1, 2, NULL, 815.47000000, 'BCV', '2026-10-12 00:00:00', NULL, NULL, '0', '2026-10-12 18:30:15', '2026-10-14 13:14:59', NULL),
  (3, 1, 2, NULL, 876.79000000, 'BCV', '2026-10-13 00:00:00', NULL, NULL, '0', '2026-10-13 13:02:18', '2026-10-14 13:14:59', NULL),
  (4, 1, 3, NULL, '0.92500000', 'BCE', '2026-10-14 00:00:00', NULL, NULL, '0', '2026-10-13 22:16:11', '2026-10-13 22:16:28', '2026-10-13 22:16:28'),
  (5, 1, 2, 1, 900.20000000, 'BCV', '2026-10-14 00:00:00', '2026-10-14 23:59:59', NULL, 1, '2026-10-14 13:14:59', '2026-10-14 13:14:59', NULL);

-- Datos para la tabla: `empleados` (4 registros)
INSERT INTO `empleados` (`id`, `usuario_id`, `cargo_id`, `estatus_empleado_id`, `contrato_id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `tipo_documento`, `numero_documento`, `correo_electronico`, `telefono`, `direccion`, `foto`, `fecha_nacimiento`, `fecha_ingreso`, `salario_base_ves`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
  (1, 1, 10, 1, 1, 'DEIVER', 'ALEXANDER', 'MARTINEZ', 'ROSALES', 'V', 'V-21737106', 'crrpersonal90@gmail.com', '+58 412 1234567', NULL, '/uploads/personal/emp_1792005082_5a3810c7.jpg', NULL, '2025-02-01', 18500.00, 1, '2026-10-13 22:33:28', '2026-10-14 15:11:58', NULL),
  (2, 4, 11, 4, 1, 'holakk', NULL, 'smieth', NULL, 'V', 'V-12996927', 'hola@gmail.com', '+58 412 1234567', NULL, NULL, NULL, '2025-02-01', 18500.00, '0', '2026-10-13 22:33:28', '2026-10-14 14:53:49', NULL),
  (3, NULL, 12, 4, 2, 'DEIVER', NULL, 'MARTINEZ', NULL, 'V', 'V-23312392', 'reparto@cnsblab.com', '04129989473', NULL, NULL, NULL, '2025-06-15', 14200.00, '0', '2026-10-13 22:33:28', '2026-10-14 14:54:05', NULL),
  (4, NULL, 10, 4, 3, 'DOUGLAS', NULL, 'MARTINEZ', NULL, 'V', 5587534, 'douglas@gmail.com', '04120303100', NULL, NULL, NULL, '2026-10-14', 100.00, '0', '2026-10-14 13:16:03', '2026-10-14 14:53:46', NULL);

-- Datos para la tabla: `pacientes` (3 registros)
INSERT INTO `pacientes` (`id`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `tipo_documento`, `numero_documento`, `sexo`, `clinica_id`, `sede_id`) VALUES
  (1, 'DEIVER', 'ALEXANDER', 'MARTINEZ', 'ROSALES', 'V', 22798946, 'H', 4, 9),
  (2, 'rosa', 'teresa', 'rosales', 'de martinez', 'V', 5687949, 'M', 4, 8),
  (3, 'DOUGLAS', NULL, 'MARTINEEZ', NULL, 'V', 5547534, 'M', 4, 9);

-- Datos para la tabla: `envios` (2 registros)
INSERT INTO `envios` (`id`, `sede_id`, `repartidor_id`, `estatus_envio`, `cantidad_casos`, `codigo_qr`, `direccion_movimiento`, `fecha_hora_recepcion`, `fecha_hora_despacho`, `fecha_hora_creacion`, `fecha_hora_programada`, `notas_cancelacion`) VALUES
  (1, 8, 1, 'RECIBIDO', 1, 'ENV-0001', 'SALIDA', '2026-10-13 22:19:08', '2026-10-13 14:57:43', '2026-10-13 20:56:43', '2026-10-13 20:56:43', NULL),
  (2, 9, 1, 'RECIBIDO', 1, 'ENV-0002', 'SALIDA', '2026-10-14 13:21:19', '2026-10-14 13:21:03', '2026-10-14 19:20:47', '2026-10-14 19:20:47', NULL);

-- Datos para la tabla: `pacientes_odontogramas` (29 registros)
INSERT INTO `pacientes_odontogramas` (`id`, `paciente_id`, `diente_numero`, `estado_diente`, `observaciones`, `fecha_registro`) VALUES
  (25, 1, 46, 'AUSENTE', NULL, '2026-10-13 09:48:59'),
  (26, 2, 16, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (27, 2, 17, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (28, 2, 18, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (29, 2, 26, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (30, 2, 27, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (31, 2, 28, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (32, 2, 36, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (33, 2, 37, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (34, 2, 38, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (35, 2, 46, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (36, 2, 47, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (37, 2, 48, 'AUSENTE', NULL, '2026-10-13 14:53:33'),
  (50, 3, 15, 'CON CARIE', NULL, '2026-10-14 13:18:34'),
  (51, 3, 16, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (52, 3, 17, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (53, 3, 18, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (54, 3, 25, 'CON CARIE', NULL, '2026-10-14 13:18:34'),
  (55, 3, 26, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (56, 3, 27, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (57, 3, 28, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (58, 3, 35, 'CON CARIE', NULL, '2026-10-14 13:18:34'),
  (59, 3, 36, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (60, 3, 37, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (61, 3, 38, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (62, 3, 45, 'CON CARIE', NULL, '2026-10-14 13:18:34'),
  (63, 3, 46, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (64, 3, 47, 'AUSENTE', NULL, '2026-10-14 13:18:34'),
  (65, 3, 48, 'AUSENTE', NULL, '2026-10-14 13:18:34');

-- Datos para la tabla: `historial_envios` (7 registros)
INSERT INTO `historial_envios` (`id`, `envio_id`, `usuario_id`, `historial_envios_estatus_id`, `notas`, `fecha_hora`) VALUES
  (1, 1, 1, 1, 'Envío creado y empacado.', '2026-10-13 14:56:43'),
  (2, 1, 1, 4, 'Cambio rápido de estatus a: Entregado', '2026-10-13 14:57:38'),
  (3, 1, 1, 3, 'Cambio rápido de estatus a: En Ruta', '2026-10-13 14:57:43'),
  (4, 1, 1, 4, 'Cambio rápido de estatus a: Entregado', '2026-10-13 22:19:08'),
  (5, 2, 1, 1, 'Envío creado y empacado.', '2026-10-14 13:20:47'),
  (6, 2, 1, 3, 'Cambio rápido de estatus a: En Ruta', '2026-10-14 13:21:03'),
  (7, 2, 1, 4, 'Cambio rápido de estatus a: Entregado', '2026-10-14 13:21:19');

-- Datos para la tabla: `ordenes_trabajo` (2 registros)
INSERT INTO `ordenes_trabajo` (`id`, `clinica_id`, `servicio_id`, `paciente_id`, `envio_id`, `codigo_qr`, `cantidad_piezas_exacta`, `estatus_actual`, `fecha_ingreso`, `fecha_hora_creacion`, `sede_id`, `cantidad_protesis`, `protesista_id`) VALUES
  (1, 4, 1, 1, 1, 'ORD-0001', 1, 'DESPACHO: Entregado', '2026-10-13 14:55:15', '2026-10-13 14:55:15', 9, 1, 1),
  (2, 4, 1, 3, 2, 'ORD-0002', 1, 'DESPACHO: Entregado', '2026-10-14 13:20:22', '2026-10-14 13:20:22', 9, 1, 1);

-- Datos para la tabla: `ordenes_detalle` (2 registros)
INSERT INTO `ordenes_detalle` (`id`, `orden_trabajo_id`, `servicio_id`, `etapa_produccion_id`) VALUES
  (1, 1, 1, 2),
  (2, 2, 1, 1);

-- Datos para la tabla: `historial_trazabilidad` (2 registros)
INSERT INTO `historial_trazabilidad` (`id`, `orden_trabajo_id`, `orden_detalle_id`, `usuario_id`, `estatus`, `ubicacion`, `notas`, `fecha_cambio`) VALUES
  (1, 1, 1, 1, 'PRUEBA DE RODETE - RECIBIDO EN LAB', 'RECEPCIÓN LABORATORIO', 'Ingreso inicial del caso.', '2026-10-13 14:55:15'),
  (2, 2, 2, 1, 'TOMA DE IMPRESION - LISTO PARA DESPACHO', 'EN CLÍNICA / SEDE', 'Ingreso inicial del caso.', '2026-10-14 13:20:22');

-- Datos para la tabla: `documentos_administrativos` (1 registros)
INSERT INTO `documentos_administrativos` (`id`, `numero_documento`, `tipo_documento`, `clinica_id`, `sede_id`, `orden_trabajo_id`, `usuario_id`, `tasa_cambio`, `monto_usd`, `monto_bs`, `estatus`, `observaciones`, `items_detalle`, `fecha_emision`) VALUES
  (1, 'FAC-2026-0001', 'FACTURA', 4, 9, 1, 1, 900.2000, 20.00, 18004.00, 'EMITIDO', 'Caso: ORD-0001 | Paciente: DEIVER MARTINEZ | Servicio:  (1 piezas).', NULL, '2026-10-14 13:16:45');

SET FOREIGN_KEY_CHECKS = 1;
