-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: fdb1032.awardspace.net
-- Tiempo de generación: 06-06-2026 a las 14:51:37
-- Versión del servidor: 8.0.32
-- Versión de PHP: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `4741065_turnappmedical`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `medico_id` int NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('pendiente','confirmada','cancelada','completada') COLLATE utf8mb4_unicode_ci DEFAULT 'pendiente',
  `cancelada_por` enum('paciente','medico') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `motivo_cancelacion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`id`, `usuario_id`, `medico_id`, `fecha`, `hora`, `motivo`, `estado`, `cancelada_por`, `motivo_cancelacion`, `created_at`, `updated_at`) VALUES
(1, 16, 1, '2026-04-10', '09:00:00', 'Revisión cardiológica anual', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(2, 16, 1, '2026-04-29', '10:15:00', 'Dolor abdominal', 'cancelada', NULL, NULL, '2026-05-05 09:27:42', '2026-06-03 15:02:25'),
(3, 16, 2, '2026-05-10', '10:00:00', 'Revisión general piel', 'cancelada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(4, 16, 3, '2026-05-15', '11:30:00', 'Control glucemia', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(5, 16, 5, '2026-05-20', '09:30:00', 'Dolor rodilla izquierda', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(6, 16, 6, '2026-05-25', '16:00:00', 'Cefalea persistente', 'cancelada', 'paciente', NULL, '2026-05-05 09:27:42', '2026-05-21 15:04:18'),
(7, 16, 4, '2026-06-01', '10:30:00', 'Revisión pediatría', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(8, 16, 7, '2026-06-05', '12:00:00', 'Revisión ginecológica', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(9, 17, 1, '2026-03-15', '10:00:00', 'Dolor en el pecho', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(10, 17, 3, '2026-04-01', '11:00:00', 'Revisión anual', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(11, 17, 2, '2026-04-20', '09:00:00', 'Eccema en brazo', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(12, 17, 5, '2026-05-10', '10:30:00', 'Revisión traumatología', 'cancelada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(13, 17, 8, '2026-05-18', '17:00:00', 'Problemas visión', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(14, 17, 9, '2026-05-22', '11:00:00', 'Ansiedad', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(15, 17, 10, '2026-06-03', '09:30:00', 'Control tiroides', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(16, 1, 1, '2026-02-10', '10:30:00', 'Arritmia cardiaca', 'cancelada', NULL, NULL, '2026-05-05 09:27:42', '2026-06-03 08:17:48'),
(17, 1, 6, '2026-03-05', '09:00:00', 'Migraña crónica', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(18, 1, 3, '2026-04-15', '11:00:00', 'Revisión general', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(19, 1, 5, '2026-05-12', '10:00:00', 'Esguince tobillo', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(20, 1, 11, '2026-05-28', '16:30:00', 'Artritis', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(21, 2, 7, '2026-03-20', '10:00:00', 'Control embarazo', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(22, 2, 4, '2026-04-10', '09:30:00', 'Pediatría para hijo', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(23, 2, 2, '2026-05-05', '11:00:00', 'Revisión dermatológica', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(24, 2, 8, '2026-05-19', '12:00:00', 'Graduación ocular', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(25, 2, 12, '2026-06-10', '10:00:00', 'Revisión oncológica', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(26, 3, 14, '2026-03-01', '09:00:00', 'Asma bronquial', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(27, 3, 15, '2026-03-25', '10:30:00', 'Dolor abdominal crónico', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(28, 3, 13, '2026-04-18', '11:00:00', 'Revisión urológica', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(29, 3, 1, '2026-05-08', '09:00:00', 'Control tensión arterial', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-25 08:03:13'),
(30, 3, 6, '2026-06-02', '16:00:00', 'Esclerosis múltiple', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(31, 4, 10, '2026-02-15', '10:00:00', 'Hipotiroidismo control', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(32, 4, 9, '2026-03-10', '11:30:00', 'Depresión leve', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(33, 4, 7, '2026-04-05', '09:00:00', 'Revisión ginecológica', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(34, 4, 3, '2026-05-14', '10:30:00', 'Revisión general', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(35, 4, 2, '2026-05-30', '11:00:00', 'Acné severo', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(36, 5, 5, '2026-02-20', '09:30:00', 'Fractura muñeca seguimiento', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(37, 5, 1, '2026-03-15', '11:00:00', 'Hipertensión', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(38, 5, 15, '2026-04-22', '11:00:00', 'Gastritis crónica', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(39, 5, 8, '2026-05-16', '12:00:00', 'Cataratas', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(40, 5, 14, '2026-06-08', '09:00:00', 'EPOC control', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(41, 6, 12, '2026-01-15', '10:00:00', 'Seguimiento oncológico', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(42, 6, 6, '2026-02-28', '11:00:00', 'Epilepsia control', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(43, 6, 3, '2026-04-08', '09:30:00', 'Revisión general', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(44, 6, 11, '2026-05-13', '10:00:00', 'Lupus seguimiento', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(45, 6, 9, '2026-06-15', '16:00:00', 'Trastorno bipolar', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(46, 7, 13, '2026-02-05', '09:00:00', 'Cálculos renales', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(47, 7, 5, '2026-03-18', '10:30:00', 'Hernia discal', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(48, 7, 1, '2026-04-25', '11:00:00', 'Insuficiencia cardíaca', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(49, 7, 14, '2026-05-17', '09:30:00', 'Bronquitis crónica', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(50, 7, 15, '2026-06-20', '10:00:00', 'Colon irritable', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(51, 8, 4, '2026-03-12', '10:00:00', 'Revisión niño 2 años', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(52, 8, 7, '2026-04-14', '11:30:00', 'Control anticonceptivos', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(53, 8, 2, '2026-05-06', '09:00:00', 'Psoriasis tratamiento', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(54, 8, 10, '2026-05-21', '10:30:00', 'Diabetes tipo 2', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(55, 8, 8, '2026-06-18', '12:00:00', 'Glaucoma revisión', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(56, 9, 6, '2026-02-08', '09:00:00', 'Parkinson seguimiento', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(57, 9, 1, '2026-03-22', '10:00:00', 'Angina de pecho', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(58, 9, 5, '2026-04-30', '11:00:00', 'Prótesis cadera revisión', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(59, 9, 3, '2026-05-11', '09:30:00', 'Revisión general', 'confirmada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(60, 9, 13, '2026-06-25', '10:00:00', 'Próstata revisión', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(61, 10, 9, '2026-01-20', '10:30:00', 'Esquizofrenia control', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(62, 10, 12, '2026-02-25', '11:00:00', 'Seguimiento oncológico mama', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(63, 10, 7, '2026-04-02', '09:00:00', 'Menopausia tratamiento', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(64, 10, 10, '2026-05-09', '10:00:00', 'Hipotiroidismo', 'completada', NULL, NULL, '2026-05-05 09:27:42', '2026-05-19 15:39:57'),
(65, 10, 6, '2026-06-12', '16:30:00', 'Neuropatía diabética', 'pendiente', NULL, NULL, '2026-05-05 09:27:42', '2026-05-05 09:27:42'),
(66, 2, 12, '2026-05-20', '09:00:00', 'j', 'pendiente', NULL, NULL, '2026-05-19 15:26:16', '2026-05-19 15:26:16'),
(67, 2, 1, '2026-05-20', '09:00:00', NULL, 'confirmada', NULL, NULL, '2026-05-19 15:26:35', '2026-06-06 14:09:27'),
(68, 19, 1, '2026-05-21', '09:00:00', 'ttttt', 'completada', NULL, NULL, '2026-05-19 16:08:17', '2026-05-19 16:08:58'),
(69, 20, 1, '2026-05-31', '11:11:00', 'Me duele el pecho', 'cancelada', NULL, NULL, '2026-05-30 18:33:21', '2026-06-03 14:54:22'),
(70, 16, 1, '2026-05-31', '11:00:00', 'Dolor de tripa', 'confirmada', NULL, NULL, '2026-05-30 18:55:00', '2026-06-03 14:53:11'),
(71, 16, 1, '2026-06-12', '11:00:00', 'Dolor de cabeza', 'completada', NULL, NULL, '2026-06-03 08:11:34', '2026-06-03 15:02:18'),
(72, 16, 1, '2026-06-10', '11:00:00', 'Dolor de cabeza', 'cancelada', NULL, NULL, '2026-06-03 14:46:58', '2026-06-03 14:52:20'),
(73, 16, 1, '2026-06-16', '11:11:00', 'Dolor de cabeza', 'cancelada', 'paciente', NULL, '2026-06-03 15:26:26', '2026-06-03 15:41:32'),
(74, 16, 1, '2026-06-21', '11:00:00', 'Dolor de garganta', 'pendiente', NULL, NULL, '2026-06-03 15:36:38', '2026-06-03 15:36:38'),
(75, 16, 1, '2026-06-30', '11:00:00', 'Dolor de cabeza', 'pendiente', NULL, NULL, '2026-06-06 13:45:32', '2026-06-06 13:45:32'),
(76, 16, 1, '2026-06-29', '11:00:00', 'Garganta', 'pendiente', NULL, NULL, '2026-06-06 14:05:14', '2026-06-06 14:05:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clinicas`
--

CREATE TABLE `clinicas` (
  `id` int NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(11,8) NOT NULL,
  `imagen_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activa` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clinicas`
--

INSERT INTO `clinicas` (`id`, `nombre`, `direccion`, `telefono`, `email`, `latitud`, `longitud`, `imagen_url`, `activa`, `created_at`) VALUES
(1, 'Clínica San Juan', 'Av. de la Constitución 15, Sevilla', '954111222', NULL, 37.38610000, -5.99200000, NULL, 1, '2026-05-05 09:27:42'),
(2, 'Centro Médico Nervión', 'C/ Luis de Morales 2, Sevilla', '954333444', NULL, 37.37890000, -5.97120000, NULL, 1, '2026-05-05 09:27:42'),
(3, 'Hospital Virgen del Rocío', 'Av. Manuel Siurot s/n, Sevilla', '955012000', NULL, 37.36170000, -5.98760000, NULL, 1, '2026-05-05 09:27:42'),
(4, 'Clínica Sagrado Corazón', 'C/ Jesús del Gran Poder 40, Sevilla', '954555666', NULL, 37.39340000, -5.99870000, NULL, 1, '2026-05-05 09:27:42'),
(5, 'Centro Médico Triana', 'C/ Betis 22, Sevilla', '954777888', NULL, 37.38140000, -6.00420000, NULL, 1, '2026-05-05 09:27:42'),
(6, 'Policlínico Sur', 'Av. de la Palmera 30, Sevilla', '954999000', NULL, 37.37010000, -5.98450000, NULL, 1, '2026-05-05 09:27:42'),
(7, 'Clínica Macarena', 'Av. Doctor Fedriani 3, Sevilla', '955008000', NULL, 37.40230000, -5.98010000, NULL, 1, '2026-05-05 09:27:42'),
(8, 'Centro Médico Aljarafe', 'C/ Resolana 1, Camas, Sevilla', '954214567', NULL, 37.39560000, -6.03120000, NULL, 1, '2026-05-05 09:27:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` int NOT NULL,
  `historial_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruta_pdf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `historial_id`, `usuario_id`, `nombre`, `ruta_pdf`, `created_at`) VALUES
(1, 35, 19, 'Informe medico 1779212475552.pdf', 'archivos/pdfs/1779226967_Informe_medico_1779212475552.pdf', '2026-05-19 21:42:47'),
(2, 1, 16, 'Informe medico 1779376168721.pdf', 'archivos/pdfs/1779376169_Informe_medico_1779376168721.pdf', '2026-05-21 15:09:29'),
(3, 19, 5, 'Informe medico 1779696283113.pdf', 'archivos/pdfs/1779696285_Informe_medico_1779696283113.pdf', '2026-05-25 08:04:45'),
(4, 3, 17, 'Informe medico 1780474741596.pdf', 'archivos/pdfs/1780474742_Informe_medico_1780474741596.pdf', '2026-06-03 08:19:02'),
(5, 3, 17, 'Informe medico 1780475351551.pdf', 'archivos/pdfs/1780475352_Informe_medico_1780475351551.pdf', '2026-06-03 08:29:12'),
(6, 19, 5, 'Informe medico 1780496540897.pdf', 'archivos/pdfs/1780496542_Informe_medico_1780496540897.pdf', '2026-06-03 14:22:22'),
(7, 3, 17, 'Informe medico 1780497229043.pdf', 'archivos/pdfs/1780497230_Informe_medico_1780497229043.pdf', '2026-06-03 14:33:50'),
(8, 3, 17, 'Informe medico 1780755006595.pdf', 'archivos/pdfs/1780755009_Informe_medico_1780755006595.pdf', '2026-06-06 14:10:09'),
(9, 1, 16, 'Informe medico 1780755245995.pdf', 'archivos/pdfs/1780755248_Informe_medico_1780755245995.pdf', '2026-06-06 14:14:08'),
(10, 1, 16, 'Informe medico 1780755345898.pdf', 'archivos/pdfs/1780755348_Informe_medico_1780755345898.pdf', '2026-06-06 14:15:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `icono` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `nombre`, `descripcion`, `icono`, `created_at`) VALUES
(1, 'Cardiología', 'Enfermedades del corazón y sistema cardiovascular', NULL, '2026-05-05 09:27:42'),
(2, 'Dermatología', 'Enfermedades de la piel, cabello y uñas', NULL, '2026-05-05 09:27:42'),
(3, 'Medicina General', 'Atención primaria y medicina general', NULL, '2026-05-05 09:27:42'),
(4, 'Pediatría', 'Medicina infantil y adolescente', NULL, '2026-05-05 09:27:42'),
(5, 'Traumatología', 'Lesiones del aparato locomotor', NULL, '2026-05-05 09:27:42'),
(6, 'Neurología', 'Enfermedades del sistema nervioso', NULL, '2026-05-05 09:27:42'),
(7, 'Ginecología', 'Salud femenina y reproductiva', NULL, '2026-05-05 09:27:42'),
(8, 'Oftalmología', 'Enfermedades de los ojos', NULL, '2026-05-05 09:27:42'),
(9, 'Psiquiatría', 'Salud mental y trastornos psiquiátricos', NULL, '2026-05-05 09:27:42'),
(10, 'Endocrinología', 'Trastornos hormonales y metabólicos', NULL, '2026-05-05 09:27:42'),
(11, 'Reumatología', 'Enfermedades articulares y autoinmunes', NULL, '2026-05-05 09:27:42'),
(12, 'Oncología', 'Diagnóstico y tratamiento del cáncer', NULL, '2026-05-05 09:27:42'),
(13, 'Urología', 'Sistema urinario y reproductor masculino', NULL, '2026-05-05 09:27:42'),
(14, 'Neumología', 'Enfermedades respiratorias', NULL, '2026-05-05 09:27:42'),
(15, 'Gastroenterología', 'Enfermedades del aparato digestivo', NULL, '2026-05-05 09:27:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_clinico`
--

CREATE TABLE `historial_clinico` (
  `id` int NOT NULL,
  `cita_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `medico_id` int NOT NULL,
  `diagnostico` text COLLATE utf8mb4_unicode_ci,
  `tratamiento` text COLLATE utf8mb4_unicode_ci,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `especialidad` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_clinico`
--

INSERT INTO `historial_clinico` (`id`, `cita_id`, `usuario_id`, `medico_id`, `diagnostico`, `tratamiento`, `observaciones`, `created_at`, `especialidad`) VALUES
(1, 1, 16, 1, 'hgh', 'hghg', 'ghghh', '2026-05-05 09:27:42', 'Cardiología'),
(2, 2, 16, 1, 'Dolor abdominal inespecífico', 'Omeprazol 20mg. Dieta blanda', 'Posible gastritis. Derivar a digestivo si persiste', '2026-05-05 09:27:42', 'Cardiología'),
(3, 9, 17, 1, 'Dolor', 'Pastillas', 'No hacer ejercicio', '2026-05-05 09:27:42', 'Cardiología'),
(4, 10, 17, 3, 'Hipercolesterolemia', 'Atorvastatina 10mg/día. Dieta hipocolesterolémica', 'Colesterol total 240. Control analítica en 3 meses', '2026-05-05 09:27:42', 'Medicina General'),
(5, 11, 17, 2, 'Dermatitis atópica', 'Hidrocortisona 1% crema. Emolientes diarios', 'Brotes frecuentes en invierno', '2026-05-05 09:27:42', 'Dermatología'),
(6, 16, 1, 1, 'Fibrilación auricular paroxística', 'Flecainida 100mg/12h. Anticoagulación con Eliquis', 'Holter 24h. Ecocardiograma normal', '2026-05-05 09:27:42', 'Cardiología'),
(7, 17, 1, 6, 'Migraña con aura', 'Sumatriptán 50mg en crisis. Topiramato 25mg preventivo', 'Crisis 3-4 veces al mes. Buen control con tratamiento', '2026-05-05 09:27:42', 'Neurología'),
(8, 18, 1, 3, 'Síndrome metabólico', 'Metformina 850mg/12h. Dieta mediterránea', 'IMC 28. HbA1c 6.2%. Prediabetes', '2026-05-05 09:27:42', 'Medicina General'),
(9, 21, 2, 7, 'Embarazo 12 semanas. Normal', 'Ácido fólico 5mg. Hierro 325mg. Vitamina D', 'Ecografía normal. Próximo control semana 20', '2026-05-05 09:27:42', 'Ginecología'),
(10, 22, 2, 4, 'Bronquitis infantil', 'Amoxicilina 250mg/8h 7 días. Ibuprofeno si fiebre', 'Niño de 4 años. Temperatura 38.5°C', '2026-05-05 09:27:42', 'Pediatría'),
(11, 23, 2, 2, 'Queratosis seborreica múltiple', 'Crioterapia en consulta. Fotoprotector 50+', 'Lesiones benignas. No tratamiento urgente', '2026-05-05 09:27:42', 'Dermatología'),
(12, 26, 3, 14, 'Asma bronquial persistente', 'Budesonida/Formoterol inhalado. Salbutamol rescate', 'Espirometría: FEV1 72%. Buen cumplimiento', '2026-05-05 09:27:42', 'Neumología'),
(13, 27, 3, 15, 'Úlcera gástrica H. pylori', 'Triple terapia: Omeprazol+Claritromicina+Amoxicilina', 'Control endoscópico en 8 semanas', '2026-05-05 09:27:42', 'Gastroenterología'),
(14, 28, 3, 13, 'Hiperplasia benigna de próstata', 'Tamsulosina 0.4mg/día', 'PSA normal. IPSS 14. Ecografía: próstata 35cc', '2026-05-05 09:27:42', 'Urología'),
(15, 31, 4, 10, 'Hipotiroidismo primario', 'Levotiroxina 75mcg en ayunas', 'TSH 8.2. T4 libre baja. Control analítica 6 semanas', '2026-05-05 09:27:42', 'Endocrinología'),
(16, 32, 4, 9, 'Trastorno depresivo mayor', 'Sertralina 50mg/día. Psicoterapia cognitivo-conductual', 'Sin ideación autolítica. Apoyo familiar bueno', '2026-05-05 09:27:42', 'Psiquiatría'),
(17, 33, 4, 7, 'Síndrome premenstrual severo', 'Anticonceptivos orales. Vitamina B6', 'Ciclos irregulares. Ecografía normal', '2026-05-05 09:27:42', 'Ginecología'),
(18, 36, 5, 5, 'Fractura radio distal consolidada', 'Fisioterapia 20 sesiones. Antiinflamatorios si dolor', 'Radiografía: consolidación completa. Alta funcional', '2026-05-05 09:27:42', 'Traumatología'),
(19, 37, 5, 1, 'fddfdf', 'ffdfdfdf', 'fdfdfdf', '2026-05-05 09:27:42', 'Cardiología'),
(20, 38, 5, 15, 'Gastroenteritis aguda', 'Sueroterapia oral. Dieta astringente 48h', 'Coprocultivo negativo. Resolución espontánea', '2026-05-05 09:27:42', 'Gastroenterología'),
(21, 41, 6, 12, 'Ca. mama estadio II en remisión', 'Tamoxifeno 20mg/día. Control semestral', 'Mamografía sin signos de recidiva', '2026-05-05 09:27:42', 'Oncología'),
(22, 42, 6, 6, 'Epilepsia focal. Buen control', 'Levetiracetam 1000mg/12h', 'Sin crisis en últimos 6 meses. EEG normal', '2026-05-05 09:27:42', 'Neurología'),
(23, 43, 6, 3, 'Revisión anual. Sin alteraciones', 'Continuar estilo de vida saludable', 'Analítica normal. TA 120/75. IMC 22', '2026-05-05 09:27:42', 'Medicina General'),
(24, 46, 7, 13, 'Litiasis renal 8mm', 'Tamsulosina 0.4mg. Hidratación abundante', 'Litotricia extracorpórea programada', '2026-05-05 09:27:42', 'Urología'),
(25, 47, 7, 5, 'Hernia discal L4-L5', 'Fisioterapia. Diclofenaco 75mg/12h. Pregabalina 75mg', 'RMN: protrusión discal con afectación radicular L5', '2026-05-05 09:27:42', 'Traumatología'),
(26, 48, 7, 1, 'Insuficiencia cardíaca FEVI 40%', 'Sacubitrilo/Valsartán 100mg/12h. Furosemida 40mg', 'NT-proBNP 850. Disfunción sistólica leve', '2026-05-05 09:27:42', 'Cardiología'),
(27, 51, 8, 4, 'Otitis media aguda', 'Amoxicilina-clavulánico 875mg/8h 10 días', 'Niño 2 años. Timpanograma tipo B bilateral', '2026-05-05 09:27:42', 'Pediatría'),
(28, 52, 8, 7, 'Síndrome ovario poliquístico', 'Metformina 850mg. Anticonceptivos ACO', 'Ecografía: ovarios poliquísticos. Andrógenos elevados', '2026-05-05 09:27:42', 'Ginecología'),
(29, 56, 9, 6, 'Parkinson estadio 2 Hoehn-Yahr', 'Levodopa/Carbidopa 100/25mg/8h. Pramipexol 0.18mg', 'Temblor en reposo controlado. DAT scan positivo', '2026-05-05 09:27:42', 'Neurología'),
(30, 57, 9, 1, 'Angina estable CCS II', 'AAS 100mg. Atenolol 50mg. Nitroglicerina SOS', 'Ergometría positiva. Cateterismo: lesión 70% DA', '2026-05-05 09:27:42', 'Cardiología'),
(31, 58, 9, 5, 'Artroplastia total cadera derecha', 'Rehabilitación intensiva. Anticoagulación 35 días', 'Rx: prótesis bien posicionada. Funcionalidad 80%', '2026-05-05 09:27:42', 'Traumatología'),
(32, 61, 10, 9, 'Esquizofrenia paranoide estable', 'Risperidona 6mg/día. Lorazepam 1mg SOS', 'Sin episodios psicóticos en 8 meses. Adherencia buena', '2026-05-05 09:27:42', 'Psiquiatría'),
(33, 62, 10, 12, 'Ca. mama estadio I tras QT/RT', 'Letrozol 2.5mg/día. Bisfosfonatos', 'Marcadores tumorales normales. PET negativo', '2026-05-05 09:27:42', 'Oncología'),
(34, 63, 10, 7, 'Menopausia. Síntomas vasomotores', 'THS: Estradiol 1mg + Progesterona micronizada', 'Densitometría: osteopenia leve. Mamografía normal', '2026-05-05 09:27:42', 'Ginecología'),
(35, 68, 19, 1, 'vv', 'vvv', 'vvvv', '2026-05-19 16:09:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id` int NOT NULL,
  `medico_id` int NOT NULL,
  `dia_semana` tinyint NOT NULL COMMENT '0=Lunes, 1=Martes, ..., 6=Domingo',
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `duracion_min` int NOT NULL DEFAULT '30' COMMENT 'Duración de cada cita en minutos',
  `activo` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id`, `medico_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `duracion_min`, `activo`) VALUES
(1, 1, 0, '09:00:00', '14:00:00', 30, 1),
(2, 1, 0, '09:00:00', '14:00:00', 30, 1),
(3, 1, 0, '09:00:00', '13:00:00', 30, 1),
(4, 2, 0, '10:00:00', '15:00:00', 30, 1),
(5, 2, 0, '10:00:00', '15:00:00', 30, 1),
(6, 3, 0, '08:00:00', '15:00:00', 30, 1),
(7, 3, 0, '08:00:00', '15:00:00', 30, 1),
(8, 3, 0, '08:00:00', '15:00:00', 30, 1),
(9, 3, 0, '08:00:00', '15:00:00', 30, 1),
(10, 3, 0, '08:00:00', '14:00:00', 30, 1),
(11, 4, 0, '09:00:00', '14:00:00', 30, 1),
(12, 4, 0, '09:00:00', '14:00:00', 30, 1),
(13, 5, 0, '10:00:00', '16:00:00', 30, 1),
(14, 5, 0, '10:00:00', '16:00:00', 30, 1),
(15, 6, 0, '16:00:00', '20:00:00', 30, 1),
(16, 6, 0, '16:00:00', '20:00:00', 30, 1),
(17, 7, 0, '09:00:00', '14:00:00', 30, 1),
(18, 7, 0, '09:00:00', '14:00:00', 30, 1),
(19, 8, 0, '10:00:00', '15:00:00', 30, 1),
(20, 8, 0, '10:00:00', '14:00:00', 30, 1),
(21, 9, 0, '16:00:00', '20:00:00', 30, 1),
(22, 9, 0, '16:00:00', '20:00:00', 30, 1),
(23, 10, 0, '09:00:00', '14:00:00', 30, 1),
(24, 10, 0, '09:00:00', '14:00:00', 30, 1),
(25, 11, 0, '10:00:00', '15:00:00', 30, 1),
(26, 11, 0, '10:00:00', '14:00:00', 30, 1),
(27, 12, 0, '08:00:00', '14:00:00', 30, 1),
(28, 12, 0, '08:00:00', '14:00:00', 30, 1),
(29, 13, 0, '09:00:00', '14:00:00', 30, 1),
(30, 13, 0, '09:00:00', '14:00:00', 30, 1),
(31, 14, 0, '10:00:00', '15:00:00', 30, 1),
(32, 14, 0, '10:00:00', '15:00:00', 30, 1),
(33, 15, 0, '09:00:00', '14:00:00', 30, 1),
(34, 15, 0, '09:00:00', '14:00:00', 30, 1),
(35, 15, 0, '09:00:00', '13:00:00', 30, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `id` int NOT NULL,
  `clinica_id` int NOT NULL,
  `especialidad_id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `foto_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num_colegiado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fcm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`id`, `clinica_id`, `especialidad_id`, `nombre`, `apellidos`, `email`, `password`, `telefono`, `descripcion`, `foto_url`, `num_colegiado`, `activo`, `created_at`, `fcm_token`) VALUES
(1, 1, 1, 'Carlos', 'Martínez López', 'carlos@test.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(2, 2, 2, 'Ana', 'García Fernández', 'ana.garcia@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(3, 3, 3, 'Miguel', 'Rodríguez Vega', 'miguel.rod@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(4, 4, 4, 'Elena', 'Sánchez Torres', 'elena.san@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(5, 5, 5, 'Roberto', 'López Moreno', 'roberto.lop@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(6, 6, 6, 'Patricia', 'Jiménez Ruiz', 'patricia.jim@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(7, 7, 7, 'Fernando', 'Díaz Castillo', 'fernando.dia@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(8, 8, 8, 'Carmen', 'Romero Gil', 'carmen.rom@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(9, 1, 9, 'Alberto', 'Navarro Blanco', 'alberto.nav@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(10, 2, 10, 'Cristina', 'Herrera Campos', 'cristina.her@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(11, 3, 11, 'Javier', 'Moreno Castro', 'javier.mor@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(12, 4, 12, 'Pilar', 'Ortega Medina', 'pilar.ort@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(13, 5, 13, 'Sergio', 'Delgado Santos', 'sergio.del@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(14, 6, 14, 'Marta', 'Reyes Fuentes', 'marta.rey@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL),
(15, 7, 15, 'Pablo', 'Molina Serrano', 'pablo.mol@clinica.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:27:42', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int NOT NULL,
  `cita_id` int NOT NULL,
  `remitente` enum('paciente','clinica') COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `leido` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `cita_id`, `remitente`, `mensaje`, `leido`, `created_at`) VALUES
(1, 1, 'paciente', '¿Debo seguir tomando el Bisoprolol en ayunas?', 1, '2026-05-05 09:27:42'),
(2, 1, 'clinica', 'Sí, es recomendable tomarlo con el desayuno para mejor tolerancia', 1, '2026-05-05 09:27:42'),
(3, 1, 'paciente', 'Perfecto, muchas gracias', 1, '2026-05-05 09:27:42'),
(4, 4, 'paciente', '¿Puedo practicar deporte con la cita confirmada?', 1, '2026-05-05 09:27:42'),
(5, 4, 'clinica', 'Puede hacer ejercicio moderado, evite esfuerzos intensos', 1, '2026-05-05 09:27:42'),
(6, 9, 'paciente', 'Tengo fiebre de 38°, ¿debo ir a urgencias?', 1, '2026-05-05 09:27:42'),
(7, 9, 'clinica', 'Si supera 39° o tiene dificultad respiratoria sí. Si no, paracetamol y reposo', 1, '2026-05-05 09:27:42'),
(8, 9, 'paciente', 'Gracias, la fiebre ha bajado a 37.5°', 1, '2026-05-05 09:27:42'),
(9, 13, 'paciente', '¿A qué hora es la cita exactamente?', 1, '2026-05-05 09:27:42'),
(10, 13, 'clinica', 'Su cita está confirmada a las 17:00h del día indicado', 1, '2026-05-05 09:27:42'),
(11, 21, 'paciente', '¿Tengo que ir en ayunas a la ecografía?', 1, '2026-05-05 09:27:42'),
(12, 21, 'clinica', 'Sí, por favor acuda con 4 horas de ayuno', 1, '2026-05-05 09:27:42'),
(13, 21, 'paciente', 'De acuerdo, ¿necesito traer algo más?', 1, '2026-05-05 09:27:42'),
(14, 21, 'clinica', 'Traiga la cartilla del embarazo y analítica del primer trimestre', 1, '2026-05-05 09:27:42'),
(15, 37, 'paciente', 'He medido la tensión en casa y sigue alta, 155/90', 1, '2026-05-05 09:27:42'),
(16, 37, 'clinica', 'Tome la medicación tal como se indicó. Si persiste venga a consulta', 1, '2026-05-05 09:27:42'),
(17, 48, 'paciente', 'Noto que me canso mucho al subir escaleras', 0, '2026-05-05 09:27:42'),
(18, 48, 'clinica', 'Es normal en su situación. Vaya despacio y descanse si lo necesita', 0, '2026-05-05 09:27:42'),
(19, 57, 'paciente', '¿Cuándo sabré los resultados del cateterismo?', 0, '2026-05-05 09:27:42'),
(20, 57, 'clinica', 'En 48 horas le llamaremos con los resultados', 1, '2026-05-05 09:27:42'),
(21, 57, 'paciente', 'Muchas gracias, estoy nervioso', 1, '2026-05-05 09:27:42'),
(22, 57, 'clinica', 'Es normal, estamos aquí para ayudarle', 0, '2026-05-05 09:27:42'),
(23, 16, 'clinica', 'hola', 0, '2026-05-19 15:27:32'),
(24, 2, 'paciente', 'Quiero una cita', 0, '2026-05-21 15:05:13'),
(25, 16, 'clinica', 'que deseas', 0, '2026-05-25 08:05:16'),
(26, 2, 'clinica', 'para cuando la quieres', 0, '2026-05-25 08:05:35'),
(27, 5, 'paciente', 'Hola quiero una consulta', 0, '2026-06-03 08:14:15'),
(28, 75, 'paciente', 'Hola', 0, '2026-06-06 14:06:58'),
(29, 75, 'clinica', 'Que te pasa', 0, '2026-06-06 14:09:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `medico_id` int DEFAULT NULL,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('recordatorio','confirmacion','cancelacion','informe','general') COLLATE utf8mb4_unicode_ci DEFAULT 'general',
  `leida` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `usuario_id`, `medico_id`, `titulo`, `mensaje`, `tipo`, `leida`, `created_at`) VALUES
(1, 16, NULL, 'Cita confirmada', 'Su cita con Dr. Carlos Martínez ha sido confirmada para el 15/05/2026 a las 11:30', 'general', 1, '2026-05-05 09:27:42'),
(2, 16, NULL, 'Recordatorio de cita', 'Mañana tiene cita con Dr. Roberto López a las 09:30', 'general', 1, '2026-05-05 09:27:42'),
(3, 16, NULL, 'Cita cancelada', 'Su cita del 10/05/2026 con Dra. Ana García ha sido cancelada', 'general', 1, '2026-05-05 09:27:42'),
(4, 17, NULL, 'Cita confirmada', 'Su cita con Dra. Carmen Romero ha sido confirmada para el 18/05/2026 a las 17:00', 'general', 1, '2026-05-05 09:27:42'),
(5, 17, NULL, 'Informe disponible', 'Su informe médico del 01/04/2026 ya está disponible para descarga', 'general', 0, '2026-05-05 09:27:42'),
(6, 1, NULL, 'Cita confirmada', 'Su cita con Dr. Roberto López ha sido confirmada para el 12/05/2026 a las 10:00', 'general', 1, '2026-05-05 09:27:42'),
(7, 1, NULL, 'Historial actualizado', 'El Dr. Carlos Martínez ha actualizado su historial clínico', 'general', 0, '2026-05-05 09:27:42'),
(8, 2, NULL, 'Cita confirmada', 'Su cita con Dra. Carmen Romero ha sido confirmada para el 19/05/2026 a las 12:00', 'general', 1, '2026-05-05 09:27:42'),
(9, 3, NULL, 'Cita confirmada', 'Su cita con Dr. Carlos Martínez ha sido confirmada para el 08/05/2026 a las 09:00', 'general', 1, '2026-05-05 09:27:42'),
(10, 4, NULL, 'Cita confirmada', 'Su cita con Dr. Miguel Rodríguez ha sido confirmada para el 14/05/2026 a las 10:30', 'general', 1, '2026-05-05 09:27:42'),
(11, 5, NULL, 'Cita confirmada', 'Su cita con Dra. Carmen Romero ha sido confirmada para el 16/05/2026 a las 12:00', 'general', 1, '2026-05-05 09:27:42'),
(12, 6, NULL, 'Cita confirmada', 'Su cita con Dr. Javier Moreno ha sido confirmada para el 13/05/2026 a las 10:00', 'general', 1, '2026-05-05 09:27:42'),
(13, 7, NULL, 'Cita confirmada', 'Su cita con Dra. Marta Reyes ha sido confirmada para el 17/05/2026 a las 09:30', 'general', 1, '2026-05-05 09:27:42'),
(14, 8, NULL, 'Recordatorio de cita', 'Mañana tiene cita con Dra. Ana García a las 09:00. Llegue 10 min antes', 'general', 0, '2026-05-05 09:27:42'),
(15, 9, NULL, 'Cita confirmada', 'Su cita con Dr. Miguel Rodríguez ha sido confirmada para el 11/05/2026 a las 09:30', 'general', 1, '2026-05-05 09:27:42'),
(16, 10, NULL, 'Cita confirmada', 'Su cita con Dra. Cristina Herrera ha sido confirmada para el 09/05/2026 a las 10:00', 'general', 1, '2026-05-05 09:27:42'),
(17, 2, NULL, 'Cita solicitada', 'Tu cita para el 2026-05-20 a las 09:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-05-19 15:26:16'),
(18, 2, NULL, 'Cita solicitada', 'Tu cita para el 2026-05-20 a las 09:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-05-19 15:26:35'),
(19, 16, NULL, 'Cita completada', 'Tu cita del 2026-04-10 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 1, '2026-05-19 15:37:49'),
(20, 16, NULL, 'Cita completada', 'Tu cita del 2026-04-10 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 1, '2026-05-19 15:38:17'),
(21, 19, NULL, 'Cita solicitada', 'Tu cita para el 2026-05-21 a las 09:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-05-19 16:08:17'),
(22, 19, NULL, 'Cita confirmada', 'Tu cita del 2026-05-21 a las 09:00:00 ha sido confirmada ✅', 'confirmacion', 0, '2026-05-19 16:08:53'),
(23, 19, NULL, 'Cita completada', 'Tu cita del 2026-05-21 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 0, '2026-05-19 16:08:58'),
(24, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-05-25 ha sido cancelada.', 'cancelacion', 1, '2026-05-21 15:04:18'),
(25, 3, NULL, 'Cita completada', 'Tu cita del 2026-05-08 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 0, '2026-05-25 08:03:13'),
(26, 20, NULL, 'Cita solicitada', 'Tu cita para el 2026-05-31 a las 11:11:00 ha sido solicitada.', 'confirmacion', 0, '2026-05-30 18:33:21'),
(27, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-05-31 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-05-30 18:55:00'),
(28, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-12 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-03 08:11:34'),
(29, 1, NULL, 'Cita cancelada', 'Tu cita del 2026-02-10 a las 10:30:00 ha sido cancelada ❌', 'confirmacion', 0, '2026-06-03 08:17:48'),
(30, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-10 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-03 14:46:58'),
(31, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-06-12 a las 11:00:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:52:13'),
(33, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-06-10 a las 11:00:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:52:20'),
(35, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-05-31 a las 11:00:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:52:25'),
(37, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-05-31 a las 11:00:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:53:06'),
(39, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-05-31 a las 11:00:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:53:07'),
(41, 16, NULL, 'Cita completada', 'Tu cita del 2026-05-31 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 0, '2026-06-03 14:53:08'),
(43, 16, NULL, 'Cita confirmada', 'Tu cita del 2026-05-31 a las 11:00:00 ha sido confirmada ✅', 'confirmacion', 0, '2026-06-03 14:53:11'),
(45, 20, NULL, 'Cita cancelada', 'Tu cita del 2026-05-31 a las 11:11:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 14:54:22'),
(47, 16, NULL, 'Cita completada', 'Tu cita del 2026-06-12 ha sido completada. ¡Gracias por tu visita! 🏥', 'confirmacion', 0, '2026-06-03 15:02:18'),
(48, NULL, 1, 'Cita completada', 'Has completado la consulta de Mario del 2026-06-12', 'confirmacion', 0, '2026-06-03 15:02:18'),
(49, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-04-29 a las 10:15:00 ha sido cancelada ❌', 'cancelacion', 0, '2026-06-03 15:02:25'),
(50, NULL, 1, 'Cita cancelada', 'Has cancelado la cita de Mario del 2026-04-29', 'cancelacion', 0, '2026-06-03 15:02:25'),
(51, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-16 a las 11:11:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-03 15:26:26'),
(52, NULL, 1, 'Nueva cita solicitada', 'El paciente Mario ha solicitado cita para el 2026-06-16 a las 11:11:00', 'confirmacion', 0, '2026-06-03 15:26:26'),
(53, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-21 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-03 15:36:38'),
(54, NULL, 1, 'Nueva cita solicitada', 'El paciente Mario ha solicitado cita para el 2026-06-21 a las 11:00:00', 'confirmacion', 0, '2026-06-03 15:36:38'),
(55, 16, NULL, 'Cita cancelada', 'Tu cita del 2026-06-16 ha sido cancelada.', 'cancelacion', 0, '2026-06-03 15:41:32'),
(56, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-30 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-06 13:45:32'),
(57, NULL, 1, 'Nueva cita solicitada', 'El paciente Mario ha solicitado cita para el 2026-06-30 a las 11:00:00', 'confirmacion', 0, '2026-06-06 13:45:32'),
(58, 16, NULL, 'Cita solicitada', 'Tu cita para el 2026-06-29 a las 11:00:00 ha sido solicitada.', 'confirmacion', 0, '2026-06-06 14:05:14'),
(59, NULL, 1, 'Nueva cita solicitada', 'El paciente Mario ha solicitado cita para el 2026-06-29 a las 11:00:00', 'confirmacion', 0, '2026-06-06 14:05:14'),
(60, 2, NULL, 'Cita confirmada', 'Tu cita del 2026-05-20 a las 09:00:00 ha sido confirmada ✅', 'confirmacion', 0, '2026-06-06 14:09:27'),
(61, NULL, 1, 'Cita confirmada', 'Has confirmado la cita de María para el 2026-05-20', 'confirmacion', 0, '2026-06-06 14:09:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `tarjeta_sanitaria` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fcm_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellidos`, `email`, `password`, `telefono`, `fecha_nacimiento`, `tarjeta_sanitaria`, `foto_url`, `activo`, `created_at`, `fcm_token`) VALUES
(1, 'Carlos', 'García López', 'carlos.garcia@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '666111222', NULL, 'AND-123456789', NULL, 1, '2026-05-05 09:27:42', NULL),
(2, 'María', 'Martínez Ruiz', 'maria.martinez@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '666333444', NULL, 'AND-987654321', NULL, 1, '2026-05-05 09:27:42', NULL),
(3, 'Antonio', 'López Fernández', 'antonio.lopez@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '666555666', NULL, 'AND-456789123', NULL, 1, '2026-05-05 09:27:42', NULL),
(4, 'Laura', 'Sánchez Pérez', 'laura.sanchez@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '666777888', NULL, 'AND-789123456', NULL, 1, '2026-05-05 09:27:42', NULL),
(5, 'Manuel', 'Jiménez Torres', 'manuel.jimenez@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '666999000', NULL, 'AND-321654987', NULL, 1, '2026-05-05 09:27:42', NULL),
(6, 'Isabel', 'Romero Vega', 'isabel.romero@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '667111222', NULL, 'AND-654987321', NULL, 1, '2026-05-05 09:27:42', NULL),
(7, 'Francisco', 'Moreno Castillo', 'francisco.moreno@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '667333444', NULL, 'AND-147258369', NULL, 1, '2026-05-05 09:27:42', NULL),
(8, 'Ana', 'Díaz Serrano', 'ana.diaz@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '667555666', NULL, 'AND-369258147', NULL, 1, '2026-05-05 09:27:42', NULL),
(9, 'José', 'Álvarez Molina', 'jose.alvarez@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '667777888', NULL, 'AND-258147369', NULL, 1, '2026-05-05 09:27:42', NULL),
(10, 'Carmen', 'Ruiz Blanco', 'carmen.ruiz@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '667999000', NULL, 'AND-741852963', NULL, 1, '2026-05-05 09:27:42', NULL),
(11, 'Pedro', 'Navarro Gil', 'pedro.navarro@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '668111222', NULL, 'AND-963852741', NULL, 1, '2026-05-05 09:27:42', NULL),
(12, 'Lucía', 'Herrera Campos', 'lucia.herrera@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '668333444', NULL, 'AND-852963741', NULL, 1, '2026-05-05 09:27:42', NULL),
(13, 'David', 'Castro Reyes', 'david.castro@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '668555666', NULL, 'AND-159357486', NULL, 1, '2026-05-05 09:27:42', NULL),
(14, 'Sofía', 'Ortega Medina', 'sofia.ortega@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '668777888', NULL, 'AND-486357159', NULL, 1, '2026-05-05 09:27:42', NULL),
(15, 'Alejandro', 'Delgado Santos', 'alejandro.delgado@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '668999000', NULL, 'AND-753951852', NULL, 1, '2026-05-05 09:27:42', NULL),
(16, 'Mario', 'Masuco Chávez', 'mario@gmai.com', '$2y$12$8pVpHbrLc/b9cVFbtydhXO55QHEGT/OTMnjE9qUCo7JkEOM58uhZ6', '630841435', NULL, 'AND-000000001', NULL, 1, '2026-05-05 09:27:42', NULL),
(17, 'Juan', 'García López', 'juan@test.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', '699000001', NULL, 'AND-000000002', NULL, 1, '2026-05-05 09:27:42', NULL),
(18, 'Ismael', 'Masuo', 'ismael@gmail.com', '$2y$12$W8O2rOnPZBDarI8Ba86kXOEVM7se8y93t5ELo8ewUV.FqSCQDuRnW', NULL, NULL, NULL, NULL, 1, '2026-05-05 09:49:35', NULL),
(19, 'Manolo', 'Masuco', 'manolo@gmail.com', '$2y$12$0mC9cr0fLAtVTxMddtusPOqbzcP36OVvcgK5Il47oO9uGXzUXLnW.', NULL, NULL, NULL, NULL, 1, '2026-05-19 16:07:39', NULL),
(20, 'Mario', 'Masuco Chavez', 'mariomasuco04@gmail.com', '$2y$12$7BO8NFqj5sSPDhRV0ehVY.K9KCLwYcJOwWSmNJDhGWWnjV/g7ra12', '630 84 14 35', NULL, NULL, NULL, 1, '2026-05-30 18:30:00', NULL),
(21, 'Mario', 'Masuco', 'mario@gmail.com', '$2y$12$r9DU9RvDUuVL5R0qAsdEHenruCQ/V4pzpVkgiDPShYP1AEbVYXBZC', '655679997', NULL, NULL, NULL, 1, '2026-05-30 18:52:14', NULL),
(22, 'Mario', 'Masuco', 'mariomasuco@gmail.com', '$2y$12$gFH1vgvGt58vkp3/ANIydeJYXyuP46kNV5W0HVcIRcctqpGNLkm.a', '630823445', NULL, NULL, NULL, 1, '2026-06-03 08:08:48', NULL),
(23, 'MARIO', 'Lopez', 'mariolopez@gmail.com', '$2y$12$Mmtym8bpGivXZaj3wlw9.OWZbcQJE/6LFbqMkyWhSDEeTZeaBuHNC', '630841435', NULL, NULL, NULL, 1, '2026-06-03 14:44:10', NULL),
(24, 'Mario', 'Gomez', 'mariogomez@gmail.com', '$2y$12$9m68S4II5kUWIBhW7EnsqOs0uQ7FApe3Je7Rs/QYSaiW9O8S1Nmca', '630813245', NULL, NULL, NULL, 1, '2026-06-03 15:23:45', NULL),
(25, 'Mario', 'Moreno', 'mariomoreno@gmail.com', '$2y$12$w/55mIQUYGzY1Lj42y9YP.1r/C1XwzhEyMmZ8fIYMTBf9cJxTxVUC', '630841435', NULL, NULL, NULL, 1, '2026-06-03 15:34:09', NULL),
(26, 'Dario', 'Masuco', 'dariomasuco@gmai.com', '$2y$12$UYeofE0TKWzbN2e82k2.cueOtHdJZvEo.yKJzHTBOBiTCbh6kibgW', '630841435', NULL, NULL, NULL, 1, '2026-06-06 13:40:29', NULL),
(27, 'Carla', 'Masuco', 'carlamasuco@gmail.com', '$2y$12$J7HU8hmWshojXy9qkOWag.DFgbvA1piaRMnmp6YrdDsDCXoXIQo.O', '630841435', NULL, NULL, NULL, 1, '2026-06-06 13:43:23', NULL),
(28, 'Lucas', 'Masuco', 'lucasmasuco@gmail.com', '$2y$12$RTqJIl2c6jOD4lKXCe5SSeyG7SlQHz5wENwO1Vs09zORAd9zWNFXG', '630841435', NULL, NULL, NULL, 1, '2026-06-06 14:03:20', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones`
--

CREATE TABLE `valoraciones` (
  `id` int NOT NULL,
  `cita_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `medico_id` int NOT NULL,
  `puntuacion` tinyint NOT NULL,
  `comentario` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `valoraciones`
--

INSERT INTO `valoraciones` (`id`, `cita_id`, `usuario_id`, `medico_id`, `puntuacion`, `comentario`, `created_at`) VALUES
(1, 1, 16, 1, 5, 'Excelente médico, muy atento y profesional', '2026-05-05 09:27:42'),
(2, 2, 16, 1, 4, 'Buena atención, aunque la espera fue larga', '2026-05-05 09:27:42'),
(3, 9, 17, 1, 5, 'El doctor Martínez es el mejor cardiólogo que he tenido', '2026-05-05 09:27:42'),
(4, 10, 17, 3, 4, 'Muy buen profesional, explica todo muy bien', '2026-05-05 09:27:42'),
(5, 11, 17, 2, 5, 'Fantástica dermatóloga, muy recomendable', '2026-05-05 09:27:42'),
(6, 16, 1, 1, 5, 'Muy satisfecho con el tratamiento', '2026-05-05 09:27:42'),
(7, 17, 1, 6, 4, 'Buen neurólogo, aunque el tiempo de espera es elevado', '2026-05-05 09:27:42'),
(8, 18, 1, 3, 5, 'Trato excelente y muy profesional', '2026-05-05 09:27:42'),
(9, 21, 2, 7, 5, 'La mejor ginecóloga, muy humana y profesional', '2026-05-05 09:27:42'),
(10, 22, 2, 4, 4, 'Buena pediatra para los niños', '2026-05-05 09:27:42'),
(11, 23, 2, 2, 3, 'Correcta pero podría ser más cercana', '2026-05-05 09:27:42'),
(12, 26, 3, 14, 5, 'Solucionó mi problema respiratorio perfectamente', '2026-05-05 09:27:42'),
(13, 27, 3, 15, 4, 'Muy buen digestólogo', '2026-05-05 09:27:42'),
(14, 28, 3, 13, 5, 'Excelente urólogo, muy tranquilizador', '2026-05-05 09:27:42'),
(15, 31, 4, 10, 5, 'La mejor endocrinóloga que he tenido', '2026-05-05 09:27:42'),
(16, 32, 4, 9, 4, 'Buen psiquiatra, me ayudó mucho', '2026-05-05 09:27:42'),
(17, 33, 4, 7, 5, 'Muy profesional y atenta', '2026-05-05 09:27:42'),
(18, 36, 5, 5, 5, 'Excelente traumatólogo', '2026-05-05 09:27:42'),
(19, 37, 5, 1, 4, 'Buen cardiólogo, controlé mi hipertensión', '2026-05-05 09:27:42'),
(20, 38, 5, 15, 4, 'Atención rápida y eficaz', '2026-05-05 09:27:42'),
(21, 41, 6, 12, 5, 'El doctor me salvó la vida, infinitamente agradecida', '2026-05-05 09:27:42'),
(22, 42, 6, 6, 4, 'Muy buen control de mi epilepsia', '2026-05-05 09:27:42'),
(23, 43, 6, 3, 5, 'Revisión muy completa', '2026-05-05 09:27:42'),
(24, 46, 7, 13, 5, 'Resolvió mi problema renal completamente', '2026-05-05 09:27:42'),
(25, 47, 7, 5, 4, 'Buena atención para la hernia discal', '2026-05-05 09:27:42'),
(26, 48, 7, 1, 5, 'Excelente cardiólogo, muy implicado con mi caso', '2026-05-05 09:27:42'),
(27, 51, 8, 4, 5, 'Pediatra muy buena con los niños', '2026-05-05 09:27:42'),
(28, 52, 8, 7, 4, 'Muy profesional', '2026-05-05 09:27:42'),
(29, 56, 9, 6, 5, 'El mejor neurólogo para el Parkinson', '2026-05-05 09:27:42'),
(30, 57, 9, 1, 4, 'Muy buen diagnóstico cardíaco', '2026-05-05 09:27:42'),
(31, 58, 9, 5, 5, 'La prótesis funcionó perfectamente', '2026-05-05 09:27:42'),
(32, 61, 10, 9, 5, 'Excelente psiquiatra, mucho apoyo', '2026-05-05 09:27:42'),
(33, 62, 10, 12, 5, 'Gracias a él estoy libre de cáncer', '2026-05-05 09:27:42'),
(34, 63, 10, 7, 4, 'Muy atenta con mis síntomas de menopausia', '2026-05-05 09:27:42'),
(35, 71, 16, 1, 3, NULL, '2026-06-06 14:18:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_solapamiento` (`medico_id`,`fecha`,`hora`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `clinicas`
--
ALTER TABLE `clinicas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_id` (`historial_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cita_id` (`cita_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `medico_id` (`medico_id`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medico_id` (`medico_id`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `clinica_id` (`clinica_id`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cita_id` (`cita_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cita_id` (`cita_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `medico_id` (`medico_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `clinicas`
--
ALTER TABLE `clinicas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`historial_id`) REFERENCES `historial_clinico` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentos_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD CONSTRAINT `historial_clinico_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `citas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historial_clinico_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historial_clinico_ibfk_3` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`clinica_id`) REFERENCES `clinicas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicos_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`);

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `citas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`cita_id`) REFERENCES `citas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoraciones_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoraciones_ibfk_3` FOREIGN KEY (`medico_id`) REFERENCES `medicos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
