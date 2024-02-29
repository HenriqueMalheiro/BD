-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: Biblioteca_MariaJudite
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.22.04.2

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
-- Table structure for table `Funcionário`
--

DROP TABLE IF EXISTS `Funcionário`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Funcionário` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `email` varchar(35) NOT NULL,
  `nº_telemóvel` int unsigned NOT NULL,
  `rua` varchar(45) NOT NULL,
  `localidade` varchar(15) NOT NULL,
  `codigo_postal` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcionário`
--

LOCK TABLES `Funcionário` WRITE;
/*!40000 ALTER TABLE `Funcionário` DISABLE KEYS */;
/*!40000 ALTER TABLE `Funcionário` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Leitor`
--

DROP TABLE IF EXISTS `Leitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Leitor` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `nº_do_CC` int unsigned NOT NULL,
  `rua` varchar(45) NOT NULL,
  `localidade` varchar(15) NOT NULL,
  `codigo_postal` varchar(15) NOT NULL,
  `Funcionário_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `nº_do_CC_UNIQUE` (`nº_do_CC`),
  KEY `fk_Leitor_Funcionário1_idx` (`Funcionário_id`),
  CONSTRAINT `fk_Leitor_Funcionário1` FOREIGN KEY (`Funcionário_id`) REFERENCES `Funcionário` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Leitor`
--

LOCK TABLES `Leitor` WRITE;
/*!40000 ALTER TABLE `Leitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `Leitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Livro`
--

DROP TABLE IF EXISTS `Livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Livro` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `género` varchar(20) NOT NULL,
  `autor` varchar(25) NOT NULL,
  `título` varchar(25) NOT NULL,
  `sala` int unsigned NOT NULL,
  `corredor` int unsigned NOT NULL,
  `secção` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Livro`
--

LOCK TABLES `Livro` WRITE;
/*!40000 ALTER TABLE `Livro` DISABLE KEYS */;
/*!40000 ALTER TABLE `Livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nº_Telemóvel`
--

DROP TABLE IF EXISTS `Nº_Telemóvel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Nº_Telemóvel` (
  `nº_telemóvel` int unsigned NOT NULL,
  `Leitor_id` int unsigned NOT NULL,
  PRIMARY KEY (`Leitor_id`,`nº_telemóvel`),
  KEY `fk_Nº_Telemóvel_Leitor1_idx` (`Leitor_id`),
  CONSTRAINT `fk_Nº_Telemóvel_Leitor1` FOREIGN KEY (`Leitor_id`) REFERENCES `Leitor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nº_Telemóvel`
--

LOCK TABLES `Nº_Telemóvel` WRITE;
/*!40000 ALTER TABLE `Nº_Telemóvel` DISABLE KEYS */;
/*!40000 ALTER TABLE `Nº_Telemóvel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReservaLivro_Livro`
--

DROP TABLE IF EXISTS `ReservaLivro_Livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ReservaLivro_Livro` (
  `Reserva_Livro_id` int unsigned NOT NULL,
  `Livro_id` int unsigned NOT NULL,
  KEY `fk_ReservaLivro_Livro_Reserva_Livro1_idx` (`Reserva_Livro_id`),
  KEY `fk_ReservaLivro_Livro_Livro1_idx` (`Livro_id`),
  CONSTRAINT `fk_ReservaLivro_Livro_Livro1` FOREIGN KEY (`Livro_id`) REFERENCES `Livro` (`id`),
  CONSTRAINT `fk_ReservaLivro_Livro_Reserva_Livro1` FOREIGN KEY (`Reserva_Livro_id`) REFERENCES `Reserva_Livro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReservaLivro_Livro`
--

LOCK TABLES `ReservaLivro_Livro` WRITE;
/*!40000 ALTER TABLE `ReservaLivro_Livro` DISABLE KEYS */;
/*!40000 ALTER TABLE `ReservaLivro_Livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserva_Livro`
--

DROP TABLE IF EXISTS `Reserva_Livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reserva_Livro` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `dia` date NOT NULL,
  `Funcionário_id` int unsigned NOT NULL,
  `Leitor_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_Reserva_Livro_Funcionário1_idx` (`Funcionário_id`),
  KEY `fk_Reserva_Livro_Leitor1_idx` (`Leitor_id`),
  CONSTRAINT `fk_Reserva_Livro_Funcionário1` FOREIGN KEY (`Funcionário_id`) REFERENCES `Funcionário` (`id`),
  CONSTRAINT `fk_Reserva_Livro_Leitor1` FOREIGN KEY (`Leitor_id`) REFERENCES `Leitor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva_Livro`
--

LOCK TABLES `Reserva_Livro` WRITE;
/*!40000 ALTER TABLE `Reserva_Livro` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reserva_Livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserva_Sala_Estudo`
--

DROP TABLE IF EXISTS `Reserva_Sala_Estudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reserva_Sala_Estudo` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('Individual','Grupo') NOT NULL,
  `dia` date NOT NULL,
  `hora_de_entrada` time NOT NULL,
  `hora_de_saída` time NOT NULL,
  `Leitor_id` int unsigned NOT NULL,
  `Funcionário_id` int unsigned NOT NULL,
  `Sala_de_Estudo_número_da_sala` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_Reserva_Sala_Estudo_Leitor1_idx` (`Leitor_id`),
  KEY `fk_Reserva_Sala_Estudo_Funcionário1_idx` (`Funcionário_id`),
  KEY `fk_Reserva_Sala_Estudo_Sala_de_Estudo1_idx` (`Sala_de_Estudo_número_da_sala`),
  CONSTRAINT `fk_Reserva_Sala_Estudo_Funcionário1` FOREIGN KEY (`Funcionário_id`) REFERENCES `Funcionário` (`id`),
  CONSTRAINT `fk_Reserva_Sala_Estudo_Leitor1` FOREIGN KEY (`Leitor_id`) REFERENCES `Leitor` (`id`),
  CONSTRAINT `fk_Reserva_Sala_Estudo_Sala_de_Estudo1` FOREIGN KEY (`Sala_de_Estudo_número_da_sala`) REFERENCES `Sala_de_Estudo` (`número_da_sala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserva_Sala_Estudo`
--

LOCK TABLES `Reserva_Sala_Estudo` WRITE;
/*!40000 ALTER TABLE `Reserva_Sala_Estudo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reserva_Sala_Estudo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sala_de_Estudo`
--

DROP TABLE IF EXISTS `Sala_de_Estudo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sala_de_Estudo` (
  `número_da_sala` int unsigned NOT NULL,
  `tipo` enum('Individual','Grupo') NOT NULL,
  `capacidade` int unsigned NOT NULL,
  `estado` enum('Ocupada','Livre') NOT NULL,
  PRIMARY KEY (`número_da_sala`),
  UNIQUE KEY `número_da_sala_UNIQUE` (`número_da_sala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sala_de_Estudo`
--

LOCK TABLES `Sala_de_Estudo` WRITE;
/*!40000 ALTER TABLE `Sala_de_Estudo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sala_de_Estudo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-05 14:52:56
