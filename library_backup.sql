-- Created by belenamiune (https://github.com/belenamiune)

-- Backup

CREATE DATABASE  IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `Author_ID` int NOT NULL AUTO_INCREMENT,
  `Author_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Author_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'F. Scott Fitzgerald'),(2,'Harper Lee'),(3,'George Orwell'),(4,'Yuval Noah Harari'),(5,'Tara Westover'),(6,'Stephen Hawking'),(7,'Rebecca Skloot'),(8,'Anne Frank'),(9,'Michelle Obama'),(10,'Alex Michaelides'),(11,'J.D. Salinger'),(12,'Markus Zusak'),(13,'Charles Duhigg'),(14,'John Green'),(15,'Paulo Coelho'),(16,'J.K. Rowling'),(17,'E.B. White'),(18,'Eric Carle'),(19,'Maurice Sendak'),(20,'William Strunk Jr.');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `Book_ID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(200) NOT NULL,
  `Year` year DEFAULT NULL,
  `Amount_of_copies` int NOT NULL DEFAULT '1',
  `Category_ID` int NOT NULL,
  `Editory_ID` int NOT NULL,
  `Shelf_ID` int NOT NULL DEFAULT '1',
  `Available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`Book_ID`),
  KEY `FK_Book_Category` (`Category_ID`),
  KEY `FK_Book_Editory` (`Editory_ID`),
  KEY `FK_Book_Shelf` (`Shelf_ID`),
  CONSTRAINT `FK_Book_Category` FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`),
  CONSTRAINT `FK_Book_Editory` FOREIGN KEY (`Editory_ID`) REFERENCES `editory` (`Editory_ID`),
  CONSTRAINT `FK_Book_Shelf` FOREIGN KEY (`Shelf_ID`) REFERENCES `shelf` (`Shelf_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'The Great Gatsby',1925,3,1,1,1,1),(2,'To Kill a Mockingbird',1960,5,1,2,1,1),(3,'1984',1949,4,1,3,1,1),(4,'Sapiens: A Brief History of Humankind',2011,2,2,1,2,1),(5,'Educated',2018,3,2,2,2,1),(6,'A Brief History of Time',1988,4,3,3,2,1),(7,'The Immortal Life of Henrietta Lacks',2010,5,3,4,2,1),(8,'The Diary of a Young Girl',1947,2,4,1,3,1),(9,'Becoming',2018,3,4,2,3,1),(10,'The Silent Patient',2019,4,1,5,3,1),(11,'The Catcher in the Rye',1951,3,1,1,4,1),(12,'The Book Thief',2005,5,1,2,4,1),(13,'The Power of Habit',2012,2,2,3,4,1),(14,'The Fault in Our Stars',2012,4,1,4,4,1),(15,'The Alchemist',1988,3,1,5,5,1),(16,'Harry Potter and the Sorcerer\'s Stone',1997,6,6,1,5,1),(17,'Charlottes Web',1952,5,6,2,5,1),(18,'The Very Hungry Caterpillar',1969,7,6,3,5,1),(19,'Where the Wild Things Are',1963,4,6,4,5,1),(20,'The Elements of Style',1959,2,7,5,6,1),(21,'Nuevo Libro',NULL,1,1,2,1,1),(22,'Nuevo Libro',NULL,1,1,2,1,1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BeforeDeleteBook` BEFORE DELETE ON `book` FOR EACH ROW BEGIN
    DECLARE loanCount INT;
    -- Contar los préstamos activos para el libro
    SELECT COUNT(*) INTO loanCount
    FROM LOAN
    WHERE Book_ID = OLD.Book_ID AND Return_Date IS NULL;
    
    -- Manejo de errores: Si hay préstamos activos
    IF loanCount > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el libro porque está prestado';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `Book_ID` int NOT NULL,
  `Author_ID` int NOT NULL,
  PRIMARY KEY (`Book_ID`,`Author_ID`),
  KEY `FK_Author_ID_Author` (`Author_ID`),
  CONSTRAINT `FK_Author_ID_Author` FOREIGN KEY (`Author_ID`) REFERENCES `author` (`Author_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Book_ID_Author` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(100) NOT NULL,
  `Description` text,
  PRIMARY KEY (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Fiction','Novels and stories of fiction'),(2,'Non-Fiction','Books based on real facts'),(3,'Science','Books about science and technology'),(4,'History','Works on historical events'),(5,'Biographies','Lives of notable people'),(6,'Children','Literature for children'),(7,'Reference','Consultation and reference material');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editory`
--

DROP TABLE IF EXISTS `editory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editory` (
  `Editory_ID` int NOT NULL AUTO_INCREMENT,
  `Editory_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Editory_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editory`
--

LOCK TABLES `editory` WRITE;
/*!40000 ALTER TABLE `editory` DISABLE KEYS */;
INSERT INTO `editory` VALUES (1,'Penguin Random House'),(2,'HarperCollins'),(3,'Simon & Schuster'),(4,'Macmillan Publishers'),(5,'Hachette Book Group');
/*!40000 ALTER TABLE `editory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `Fine_ID` int NOT NULL AUTO_INCREMENT,
  `Price` decimal(10,2) NOT NULL,
  `Description` text,
  `Sanction_ID` int NOT NULL,
  PRIMARY KEY (`Fine_ID`),
  KEY `FK_Fine_Sanction` (`Sanction_ID`),
  CONSTRAINT `FK_Fine_Sanction` FOREIGN KEY (`Sanction_ID`) REFERENCES `sanction` (`Sanction_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (1,10.00,'Fine for late return of \"The Great Gatsby\"',1),(2,5.00,'Fine for late return of \"1984\"',2);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librarian`
--

DROP TABLE IF EXISTS `librarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarian` (
  `Librarian_ID` int NOT NULL AUTO_INCREMENT,
  `Librarian_Name` varchar(100) NOT NULL,
  `Shift` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Librarian_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librarian`
--

LOCK TABLES `librarian` WRITE;
/*!40000 ALTER TABLE `librarian` DISABLE KEYS */;
INSERT INTO `librarian` VALUES (1,'Clara Martínez','Morning'),(2,'Jorge López','Afternoon'),(3,'Elena García','Evening'),(4,'Ricardo Fernández','Night');
/*!40000 ALTER TABLE `librarian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `Loan_ID` int NOT NULL AUTO_INCREMENT,
  `Loan_Date` date DEFAULT NULL,
  `Return_Date` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  `Librarian_ID` int NOT NULL,
  `Book_ID` int NOT NULL,
  PRIMARY KEY (`Loan_ID`),
  KEY `FK_Loan_User` (`User_ID`),
  KEY `FK_Loan_Librarian` (`Librarian_ID`),
  KEY `FK_Loan_Book` (`Book_ID`),
  CONSTRAINT `FK_Loan_Book` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`),
  CONSTRAINT `FK_Loan_Librarian` FOREIGN KEY (`Librarian_ID`) REFERENCES `librarian` (`Librarian_ID`),
  CONSTRAINT `FK_Loan_User` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,'2024-01-10','2024-01-17','Returned',1,1,1),(2,'2024-01-12','2024-01-19','Returned',2,2,2),(3,'2024-01-15',NULL,'Pending',3,3,3),(4,'2024-01-16',NULL,'Pending',4,1,4),(5,'2024-01-20','2024-01-27','Returned',5,2,5),(6,'2024-01-22',NULL,'Pending',6,3,6),(7,'2024-01-25','2024-02-01','Returned',7,1,7),(8,'2024-01-28',NULL,'Pending',8,2,8);
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BeforeInsertLoan` BEFORE INSERT ON `loan` FOR EACH ROW BEGIN
    DECLARE isAvailable TINYINT(1);
    -- Verificar la disponibilidad del libro usando la función
    SET isAvailable = IsBookAvailable(NEW.Book_ID);
    IF isAvailable = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El libro no está disponible para préstamo';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterInsertLoan` AFTER INSERT ON `loan` FOR EACH ROW BEGIN
    UPDATE LOAN
    SET Return_Date = DATE_ADD(NEW.Loan_Date, INTERVAL 14 DAY)
    WHERE Loan_ID = NEW.Loan_ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `BeforeUpdateLoan` BEFORE UPDATE ON `loan` FOR EACH ROW BEGIN
    IF NEW.Return_Date < NEW.Loan_Date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de devolución no puede ser anterior a la fecha de préstamo';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `Reservation_ID` int NOT NULL AUTO_INCREMENT,
  `Reservation_Date` date NOT NULL,
  `Reservation_Status` varchar(50) DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  PRIMARY KEY (`Reservation_ID`),
  KEY `FK_Reservation_User` (`User_ID`),
  CONSTRAINT `FK_Reservation_User` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'2024-01-05','Active',1),(2,'2024-01-08','Active',3),(3,'2024-01-12','Cancelled',4);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanction`
--

DROP TABLE IF EXISTS `sanction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanction` (
  `Sanction_ID` int NOT NULL AUTO_INCREMENT,
  `Sanction_Date` date NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Description` text,
  `Sanction_Status` varchar(50) DEFAULT NULL,
  `User_ID` int NOT NULL,
  `Loan_ID` int DEFAULT NULL,
  PRIMARY KEY (`Sanction_ID`),
  KEY `FK_Sanction_User` (`User_ID`),
  KEY `FK_Sanction_Loan` (`Loan_ID`),
  CONSTRAINT `FK_Sanction_Loan` FOREIGN KEY (`Loan_ID`) REFERENCES `loan` (`Loan_ID`),
  CONSTRAINT `FK_Sanction_User` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanction`
--

LOCK TABLES `sanction` WRITE;
/*!40000 ALTER TABLE `sanction` DISABLE KEYS */;
INSERT INTO `sanction` VALUES (1,'2024-01-15',10.00,'Late return of \"The Great Gatsby\"','Pending',1,1),(2,'2024-01-20',5.00,'Late return of \"1984\"','Paid',3,3);
/*!40000 ALTER TABLE `sanction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelf`
--

DROP TABLE IF EXISTS `shelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelf` (
  `Shelf_ID` int NOT NULL AUTO_INCREMENT,
  `Shelf_Number` int NOT NULL,
  `Section` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Shelf_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelf`
--

LOCK TABLES `shelf` WRITE;
/*!40000 ALTER TABLE `shelf` DISABLE KEYS */;
INSERT INTO `shelf` VALUES (1,1,'Fiction'),(2,2,'Non-Fiction'),(3,3,'Science'),(4,4,'History'),(5,5,'Biographies'),(6,6,'Children'),(7,7,'Reference');
/*!40000 ALTER TABLE `shelf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `User_Name` varchar(100) NOT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `User_Type` int NOT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `FK_User_Type` (`User_Type`),
  CONSTRAINT `FK_User_Type` FOREIGN KEY (`User_Type`) REFERENCES `usertypes` (`User_Type`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Juan Pérez','Calle Falsa 123','555-0123','juan@example.com',2),(2,'Ana Gómez','Avenida Siempre Viva 742','555-0456','ana@example.com',2),(3,'Luis Martínez','Boulevard de los Sueños 456','555-0789','luis@example.com',3),(4,'Marta López','Calle del Sol 321','555-0112','marta@example.com',1),(5,'Carlos Ruiz','Calle del Mar 654','555-0345','carlos@example.com',2),(6,'Sofía Torres','Calle de la Luna 987','555-0678','sofia@example.com',4),(7,'Pedro Sánchez','Calle de la Esperanza 258','555-0912','pedro@example.com',2),(8,'Laura Jiménez','Avenida de la Paz 135','555-0134','laura@example.com',3),(9,'Diego Fernández','Calle de la Libertad 369','555-0457','diego@example.com',1),(10,'Carmen Castro','Calle del Amor 147','555-0890','carmen@example.com',4),(11,'Javier Morales','Calle de la Amistad 258','555-0246','javier@example.com',2),(12,'María González','Avenida de la Felicidad 753','555-0690','maria@example.com',3),(13,'Roberto Díaz','Calle del Valor 369','555-0312','roberto@example.com',2),(14,'Patricia Ruiz','Calle del Respeto 159','555-0780','patricia@example.com',4),(15,'Fernando Herrera','Calle de la Unidad 951','555-1023','fernando@example.com',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterUpdateUser` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
    INSERT INTO USER_AUDIT (User_ID, Old_Name, New_Name, Change_Date)
    VALUES (OLD.User_ID, OLD.User_Name, NEW.User_Name, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usertypes`
--

DROP TABLE IF EXISTS `usertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usertypes` (
  `User_Type` int NOT NULL AUTO_INCREMENT,
  `User_Type_Name` varchar(50) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`User_Type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertypes`
--

LOCK TABLES `usertypes` WRITE;
/*!40000 ALTER TABLE `usertypes` DISABLE KEYS */;
INSERT INTO `usertypes` VALUES (1,'Admin','Administrator with full access'),(2,'Member','Regular library member'),(3,'Librarian','Library staff member'),(4,'Visitor','Non-member visitor');
/*!40000 ALTER TABLE `usertypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_availablebooks`
--

DROP TABLE IF EXISTS `vw_availablebooks`;
/*!50001 DROP VIEW IF EXISTS `vw_availablebooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_availablebooks` AS SELECT 
 1 AS `Book_ID`,
 1 AS `Title`,
 1 AS `Category_Name`,
 1 AS `Editory_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_bookcategorysummary`
--

DROP TABLE IF EXISTS `vw_bookcategorysummary`;
/*!50001 DROP VIEW IF EXISTS `vw_bookcategorysummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_bookcategorysummary` AS SELECT 
 1 AS `Category_Name`,
 1 AS `Total_Books`,
 1 AS `Total_Loans`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_categorybookcount`
--

DROP TABLE IF EXISTS `vw_categorybookcount`;
/*!50001 DROP VIEW IF EXISTS `vw_categorybookcount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_categorybookcount` AS SELECT 
 1 AS `Category_Name`,
 1 AS `Total_Books`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_librarianstats`
--

DROP TABLE IF EXISTS `vw_librarianstats`;
/*!50001 DROP VIEW IF EXISTS `vw_librarianstats`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_librarianstats` AS SELECT 
 1 AS `Librarian_Name`,
 1 AS `Total_Loans`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_overdueloans`
--

DROP TABLE IF EXISTS `vw_overdueloans`;
/*!50001 DROP VIEW IF EXISTS `vw_overdueloans`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_overdueloans` AS SELECT 
 1 AS `User_Name`,
 1 AS `Title`,
 1 AS `Loan_Date`,
 1 AS `Return_Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_popularbooks`
--

DROP TABLE IF EXISTS `vw_popularbooks`;
/*!50001 DROP VIEW IF EXISTS `vw_popularbooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_popularbooks` AS SELECT 
 1 AS `Title`,
 1 AS `Times_Loaned`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_userdetails`
--

DROP TABLE IF EXISTS `vw_userdetails`;
/*!50001 DROP VIEW IF EXISTS `vw_userdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_userdetails` AS SELECT 
 1 AS `User_ID`,
 1 AS `User_Name`,
 1 AS `Address`,
 1 AS `Phone`,
 1 AS `Email`,
 1 AS `User_Type_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_userloans`
--

DROP TABLE IF EXISTS `vw_userloans`;
/*!50001 DROP VIEW IF EXISTS `vw_userloans`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_userloans` AS SELECT 
 1 AS `User_Name`,
 1 AS `Title`,
 1 AS `Loan_Date`,
 1 AS `Return_Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_usertypesummary`
--

DROP TABLE IF EXISTS `vw_usertypesummary`;
/*!50001 DROP VIEW IF EXISTS `vw_usertypesummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_usertypesummary` AS SELECT 
 1 AS `User_Type_Name`,
 1 AS `Total_Users`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'library'
--

--
-- Dumping routines for database 'library'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_GetLateFees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_GetLateFees`(loanID INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE lateFee DECIMAL(10,2) DEFAULT 0;  -- Inicializa lateFee
    DECLARE daysLate INT DEFAULT 0;  -- Inicializa daysLate
    DECLARE returnDate DATE;

    SELECT Return_Date INTO returnDate
    FROM LOAN
    WHERE Loan_ID = loanID;

    -- Verifica que Return_Date no sea nulo
    IF returnDate IS NOT NULL THEN
        SET daysLate = DATEDIFF(CURDATE(), returnDate);
        IF daysLate > 0 THEN
            SET lateFee = daysLate * 0.50; 
        END IF;
    END IF;

    RETURN lateFee;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_GetPopularBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_GetPopularBooks`(categoryID INT, limitCount INT) RETURNS varchar(255) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE bookIDs VARCHAR(255) DEFAULT '';
    
    SELECT GROUP_CONCAT(BOOK.Book_ID ORDER BY COUNT(LOAN.Loan_ID) DESC SEPARATOR ', ')
    INTO bookIDs
    FROM LOAN
    JOIN BOOK ON LOAN.Book_ID = BOOK.Book_ID
    WHERE BOOK.Category_ID = categoryID
    GROUP BY BOOK.Book_ID
    LIMIT limitCount;

    RETURN bookIDs;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_GetTotalBooksInCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_GetTotalBooksInCategory`(categoryID INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE totalBooks INT DEFAULT 0; -- Valor por defecto
    SELECT COUNT(*) INTO totalBooks
    FROM BOOK
    WHERE Category_ID = categoryID;
    RETURN totalBooks;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_GetUserLoanCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_GetUserLoanCount`(userID INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE loanCount INT DEFAULT 0; -- Valor por defecto
    SELECT COUNT(*) INTO loanCount
    FROM LOAN
    WHERE User_ID = userID;
    RETURN loanCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_IsBookAvailable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_IsBookAvailable`(bookID INT) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE available TINYINT(1);  -- Cambiado BOOLEAN a TINYINT(1)
    SELECT COUNT(*) = 0 INTO available
    FROM LOAN
    WHERE Book_ID = bookID AND Return_Date IS NULL; 
    RETURN available;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AddNewBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddNewBook`(
    IN bookTitle VARCHAR(255),
    IN categoryID INT,
    IN editoryID INT,
    IN available TINYINT(1)
)
BEGIN
    INSERT INTO BOOK (Title, Category_ID, Editory_ID, Available)
    VALUES (bookTitle, categoryID, editoryID, available);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetPopularBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetPopularBooks`(
    IN resultLimit INT
)
BEGIN
    SELECT 
        b.Title, 
        COUNT(l.Loan_ID) AS Times_Loaned
    FROM 
        BOOK b
    LEFT JOIN 
        LOAN l ON b.Book_ID = l.Book_ID
    GROUP BY 
        b.Book_ID
    ORDER BY 
        Times_Loaned DESC
    LIMIT resultLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetUserLoans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserLoans`(
    IN userID INT
)
BEGIN
    SELECT 
        u.User_Name, 
        b.Title, 
        l.Loan_Date, 
        l.Return_Date
    FROM 
        LOAN l
    JOIN 
        USER u ON l.User_ID = u.User_ID
    JOIN 
        BOOK b ON l.Book_ID = b.Book_ID
    WHERE 
        u.User_ID = userID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_LoanBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_LoanBook`(
    IN userID INT,
    IN bookID INT
)
BEGIN
    DECLARE loanDate DATE;
    DECLARE isAvailable TINYINT(1);  -- Variable para almacenar la disponibilidad

    -- Verificar disponibilidad usando fn_IsBookAvailable
    SET isAvailable = fn_IsBookAvailable(bookID);
    
    IF isAvailable THEN
        SET loanDate = CURDATE();
        INSERT INTO LOAN (User_ID, Book_ID, Loan_Date, Return_Date)
        VALUES (userID, bookID, loanDate, NULL);
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El libro no está disponible para préstamo';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ReturnBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ReturnBook`(
 IN loanID INT
)
BEGIN
    DECLARE loanDate DATE;

    -- Obtener la fecha de préstamo
    SELECT Loan_Date INTO loanDate
    FROM LOAN
    WHERE Loan_ID = loanID;

    -- Validar que la fecha de devolución no sea anterior a la de préstamo
    IF CURDATE() < loanDate THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'La fecha de devolución no puede ser anterior a la fecha de préstamo';
    ELSE
        UPDATE LOAN
        SET Return_Date = CURDATE()
        WHERE Loan_ID = loanID AND Return_Date IS NULL;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_availablebooks`
--

/*!50001 DROP VIEW IF EXISTS `vw_availablebooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_availablebooks` AS select `b`.`Book_ID` AS `Book_ID`,`b`.`Title` AS `Title`,`c`.`Category_Name` AS `Category_Name`,`e`.`Editory_Name` AS `Editory_Name` from ((`book` `b` join `category` `c` on((`b`.`Category_ID` = `c`.`Category_ID`))) join `editory` `e` on((`b`.`Editory_ID` = `e`.`Editory_ID`))) where (`b`.`Available` = true) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_bookcategorysummary`
--

/*!50001 DROP VIEW IF EXISTS `vw_bookcategorysummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_bookcategorysummary` AS select `c`.`Category_Name` AS `Category_Name`,count(`b`.`Book_ID`) AS `Total_Books`,count(`l`.`Loan_ID`) AS `Total_Loans` from ((`category` `c` left join `book` `b` on((`c`.`Category_ID` = `b`.`Category_ID`))) left join `loan` `l` on((`b`.`Book_ID` = `l`.`Book_ID`))) group by `c`.`Category_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_categorybookcount`
--

/*!50001 DROP VIEW IF EXISTS `vw_categorybookcount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_categorybookcount` AS select `c`.`Category_Name` AS `Category_Name`,count(`b`.`Book_ID`) AS `Total_Books` from (`category` `c` left join `book` `b` on((`b`.`Category_ID` = `c`.`Category_ID`))) group by `c`.`Category_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_librarianstats`
--

/*!50001 DROP VIEW IF EXISTS `vw_librarianstats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_librarianstats` AS select `l`.`Librarian_Name` AS `Librarian_Name`,count(`lo`.`Book_ID`) AS `Total_Loans` from (`librarian` `l` left join `loan` `lo` on((`l`.`Librarian_ID` = `lo`.`Librarian_ID`))) group by `l`.`Librarian_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_overdueloans`
--

/*!50001 DROP VIEW IF EXISTS `vw_overdueloans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_overdueloans` AS select `u`.`User_Name` AS `User_Name`,`b`.`Title` AS `Title`,`l`.`Loan_Date` AS `Loan_Date`,`l`.`Return_Date` AS `Return_Date` from ((`loan` `l` join `user` `u` on((`l`.`User_ID` = `u`.`User_ID`))) join `book` `b` on((`l`.`Book_ID` = `b`.`Book_ID`))) where (`l`.`Return_Date` < curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_popularbooks`
--

/*!50001 DROP VIEW IF EXISTS `vw_popularbooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_popularbooks` AS select `b`.`Title` AS `Title`,count(`l`.`Loan_ID`) AS `Times_Loaned` from (`book` `b` left join `loan` `l` on((`b`.`Book_ID` = `l`.`Book_ID`))) group by `b`.`Book_ID` order by `Times_Loaned` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_userdetails`
--

/*!50001 DROP VIEW IF EXISTS `vw_userdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_userdetails` AS select `u`.`User_ID` AS `User_ID`,`u`.`User_Name` AS `User_Name`,`u`.`Address` AS `Address`,`u`.`Phone` AS `Phone`,`u`.`Email` AS `Email`,`ut`.`User_Type_Name` AS `User_Type_Name` from (`user` `u` join `usertypes` `ut` on((`u`.`User_Type` = `ut`.`User_Type`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_userloans`
--

/*!50001 DROP VIEW IF EXISTS `vw_userloans`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_userloans` AS select `u`.`User_Name` AS `User_Name`,`b`.`Title` AS `Title`,`l`.`Loan_Date` AS `Loan_Date`,`l`.`Return_Date` AS `Return_Date` from ((`loan` `l` join `user` `u` on((`l`.`User_ID` = `u`.`User_ID`))) join `book` `b` on((`l`.`Book_ID` = `b`.`Book_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_usertypesummary`
--

/*!50001 DROP VIEW IF EXISTS `vw_usertypesummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_usertypesummary` AS select `ut`.`User_Type_Name` AS `User_Type_Name`,count(`u`.`User_ID`) AS `Total_Users` from (`usertypes` `ut` left join `user` `u` on((`u`.`User_Type` = `ut`.`User_Type`))) group by `ut`.`User_Type_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07 18:42:33
