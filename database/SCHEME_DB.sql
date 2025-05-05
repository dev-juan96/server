-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: fn_inventario_repuestos
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--
use inventario;
DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `documento` int NOT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `fk_id_ubicacion` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `cliente_ubicacion_FK` (`fk_id_ubicacion`),
  CONSTRAINT `cliente_ubicacion_FK` FOREIGN KEY (`fk_id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `documento` int NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` int NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `fk_id_rol` int DEFAULT NULL,
  `fk_id_ubicacion` int DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `empleado_rol_FK` (`fk_id_rol`),
  KEY `empleado_ubicacion_FK` (`fk_id_ubicacion`),
  CONSTRAINT `empleado_rol_FK` FOREIGN KEY (`fk_id_rol`) REFERENCES `rol` (`id_rol`),
  CONSTRAINT `empleado_ubicacion_FK` FOREIGN KEY (`fk_id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `id_envio` int NOT NULL AUTO_INCREMENT,
  `direccion de envio` varchar(100) NOT NULL,
  `fecha_envio` timestamp NOT NULL,
  `fecha_entrega` timestamp NOT NULL,
  `numero_seguimiento` varchar(100) NOT NULL,
  `estado` enum('preparado','en_transito','entregado') DEFAULT NULL,
  `fk_id_transportista` int DEFAULT NULL,
  PRIMARY KEY (`id_envio`),
  KEY `envios_transportista_FK` (`fk_id_transportista`),
  CONSTRAINT `envios_transportista_FK` FOREIGN KEY (`fk_id_transportista`) REFERENCES `transportista` (`id_transportista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `codigo_factura` varchar(20) NOT NULL,
  `accion` enum('compra','venta') NOT NULL,
  `fecha_emision` timestamp NOT NULL,
  `num_producto` int DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `iva` decimal(5,2) NOT NULL,
  `descuento` decimal(5,2) NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `fk_id_proveedor` int DEFAULT NULL,
  `fk_id_cliente` int DEFAULT NULL,
  `fk_id_producto` int DEFAULT NULL,
  `fk_id_metodo_pago` int DEFAULT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `facturas_empleado_FK` (`fk_id_proveedor`),
  KEY `facturas_cliente_FK` (`fk_id_cliente`),
  KEY `facturas_producto_FK` (`fk_id_producto`),
  KEY `facturas_metodo_pago_FK` (`fk_id_metodo_pago`),
  CONSTRAINT `facturas_cliente_FK` FOREIGN KEY (`fk_id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `facturas_empleado_FK` FOREIGN KEY (`fk_id_proveedor`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `facturas_metodo_pago_FK` FOREIGN KEY (`fk_id_metodo_pago`) REFERENCES `metodo_pago` (`id_metodo_pago`),
  CONSTRAINT `facturas_producto_FK` FOREIGN KEY (`fk_id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_producto`
--

DROP TABLE IF EXISTS `inventario_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_producto` (
  `id_inventario_producto` int NOT NULL AUTO_INCREMENT,
  `cantidad_disponible` int DEFAULT NULL,
  `stock_minimo` int DEFAULT '100',
  `stock_maximo` int DEFAULT '10000',
  `ingreso_inventario` timestamp NULL DEFAULT NULL,
  `salida_venta` timestamp NULL DEFAULT NULL,
  `fk_id_producto` int DEFAULT NULL,
  `fk_id_proveedor` int DEFAULT NULL,
  PRIMARY KEY (`id_inventario_producto`),
  KEY `inventario_producto_producto_FK` (`fk_id_producto`),
  KEY `inventario_producto_proveedor_FK` (`fk_id_proveedor`),
  CONSTRAINT `inventario_producto_producto_FK` FOREIGN KEY (`fk_id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `inventario_producto_proveedor_FK` FOREIGN KEY (`fk_id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_producto`
--

LOCK TABLES `inventario_producto` WRITE;
/*!40000 ALTER TABLE `inventario_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo_pago`
--

DROP TABLE IF EXISTS `metodo_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pago` (
  `id_metodo_pago` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `descripción` tinytext,
  PRIMARY KEY (`id_metodo_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pago`
--

LOCK TABLES `metodo_pago` WRITE;
/*!40000 ALTER TABLE `metodo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodo_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedidos` int NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` timestamp NULL DEFAULT NULL,
  `estado` enum('pendiente','creado','finalizado') DEFAULT NULL,
  `descripcion` tinytext,
  `fk_id_cliente` int DEFAULT NULL,
  `fk_id_envio` int DEFAULT NULL,
  PRIMARY KEY (`id_pedidos`),
  KEY `ordenes_pendientes_cliente_FK` (`fk_id_cliente`),
  KEY `pedidos_envios_FK` (`fk_id_envio`),
  CONSTRAINT `ordenes_pendientes_cliente_FK` FOREIGN KEY (`fk_id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `pedidos_envios_FK` FOREIGN KEY (`fk_id_envio`) REFERENCES `envios` (`id_envio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(100) DEFAULT NULL COMMENT 'código único asignado a un producto para identificarlo y gestionarlo en el inventario',
  `nombre` varchar(50) NOT NULL,
  `valor_venta` decimal(10,2) NOT NULL,
  `valor_compra` decimal(10,2) NOT NULL,
  `descripcion` tinytext,
  `fk_id_tipo_producto` int DEFAULT NULL,
  `fk_id_unidad_medida` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `producto_tipo_producto_FK` (`fk_id_tipo_producto`),
  KEY `producto_unidad_medida_FK` (`fk_id_unidad_medida`),
  CONSTRAINT `producto_tipo_producto_FK` FOREIGN KEY (`fk_id_tipo_producto`) REFERENCES `tipo_producto` (`id_tipo_producto`),
  CONSTRAINT `producto_unidad_medida_FK` FOREIGN KEY (`fk_id_unidad_medida`) REFERENCES `unidad_medida` (`id_unidad_medida`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `nit` int NOT NULL,
  `nombre_comercial` varchar(100) NOT NULL,
  `telefono` int NOT NULL,
  `correo` varchar(100) NOT NULL,
  `fecha_creacion` timestamp NOT NULL,
  `descripción` tinytext,
  `fk_id_ubicacion` int DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  KEY `proveedor_ubicacion_FK` (`fk_id_ubicacion`),
  CONSTRAINT `proveedor_ubicacion_FK` FOREIGN KEY (`fk_id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(10) DEFAULT NULL,
  `descripcion` tinytext,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_producto`
--

DROP TABLE IF EXISTS `tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_producto` (
  `id_tipo_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcio` tinytext,
  `created` timestamp NULL DEFAULT NULL,
  `update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_producto`
--

LOCK TABLES `tipo_producto` WRITE;
/*!40000 ALTER TABLE `tipo_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportista`
--

DROP TABLE IF EXISTS `transportista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportista` (
  `id_transportista` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` int NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `fk_id_ubicacion` int DEFAULT NULL,
  PRIMARY KEY (`id_transportista`),
  KEY `transportista_ubicacion_FK` (`fk_id_ubicacion`),
  CONSTRAINT `transportista_ubicacion_FK` FOREIGN KEY (`fk_id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportista`
--

LOCK TABLES `transportista` WRITE;
/*!40000 ALTER TABLE `transportista` DISABLE KEYS */;
/*!40000 ALTER TABLE `transportista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicacion` (
  `id_ubicacion` int NOT NULL AUTO_INCREMENT,
  `pais` varchar(25) NOT NULL DEFAULT 'COLOMBIA',
  `departamento` varchar(50) NOT NULL,
  `municipio` varchar(50) NOT NULL,
  `codigo_postal` int NOT NULL,
  `zona` enum('urbana','rural') NOT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacion`
--

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidad_medida`
--

DROP TABLE IF EXISTS `unidad_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidad_medida` (
  `id_unidad_medida` int NOT NULL AUTO_INCREMENT,
  `medida` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `valor_unidad` decimal(5,2) NOT NULL,
  `descripcion` tinytext,
  `created` timestamp NOT NULL,
  `update` timestamp NOT NULL,
  PRIMARY KEY (`id_unidad_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad_medida`
--

LOCK TABLES `unidad_medida` WRITE;
/*!40000 ALTER TABLE `unidad_medida` DISABLE KEYS */;
/*!40000 ALTER TABLE `unidad_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'fn_inventario_repuestos'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-24 18:15:59
