-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: iti_grades
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

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
-- Table structure for table `Exam`
--

DROP TABLE IF EXISTS `Exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exam` (
  `exam_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `fk_exam_student` (`student_id`),
  KEY `fk_exam_subject` (`subject_id`),
  CONSTRAINT `Exam_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Student` (`student_id`),
  CONSTRAINT `Exam_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`),
  CONSTRAINT `fk_exam_student` FOREIGN KEY (`student_id`) REFERENCES `Student` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_subject` FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exam`
--

LOCK TABLES `Exam` WRITE;
/*!40000 ALTER TABLE `Exam` DISABLE KEYS */;
INSERT INTO `Exam` VALUES (1,1,1,'2025-11-01',85),(2,1,2,'2025-11-02',90),(3,2,3,'2025-11-03',40),(4,3,1,'2025-11-04',75),(5,5,2,'2025-11-05',88);
/*!40000 ALTER TABLE `Exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `Gender` enum('male','female') DEFAULT NULL,
  `Birth_Date` date DEFAULT NULL,
  `First_Name` varchar(255) DEFAULT NULL,
  `Last_Name` varchar(255) DEFAULT NULL,
  `Contact_Info` json DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (1,'male','1998-03-15','Ali','Hassan','{\"email\": \"ali@gmail.com\", \"address\": \"Cairo\"}'),(2,'female','1999-06-20','Mona','Youssef','{\"email\": \"mona@gmail.com\", \"address\": \"Giza\"}'),(3,'male','1995-01-10','Ahmed','Salem','{\"email\": \"ahmed@gmail.com\", \"address\": \"Alex\"}'),(4,'female','1997-02-18','Sara','Nabil','{\"email\": \"sara@gmail.com\", \"address\": \"Mansoura\"}'),(5,'male','1990-11-25','Mohammed','Omar','{\"email\": \"mohammed@gmail.com\", \"address\": \"Cairo\"}');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student_Phone`
--

DROP TABLE IF EXISTS `Student_Phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student_Phone` (
  `phone_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`phone_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `Student_Phone_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Student` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student_Phone`
--

LOCK TABLES `Student_Phone` WRITE;
/*!40000 ALTER TABLE `Student_Phone` DISABLE KEYS */;
INSERT INTO `Student_Phone` VALUES (1,1,'01023323888'),(2,1,'01023323889'),(3,2,'01023323891'),(4,3,'01023323890'),(5,4,'01023323882');
/*!40000 ALTER TABLE `Student_Phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student_Subject`
--

DROP TABLE IF EXISTS `Student_Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student_Subject` (
  `student_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`subject_id`),
  KEY `fk_studsub_subject` (`subject_id`),
  CONSTRAINT `fk_studsub_student` FOREIGN KEY (`student_id`) REFERENCES `Student` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_studsub_subject` FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`) ON DELETE CASCADE,
  CONSTRAINT `Student_Subject_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Student` (`student_id`),
  CONSTRAINT `Student_Subject_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student_Subject`
--

LOCK TABLES `Student_Subject` WRITE;
/*!40000 ALTER TABLE `Student_Subject` DISABLE KEYS */;
INSERT INTO `Student_Subject` VALUES (1,1),(3,1),(1,2),(5,2),(2,3),(4,3),(2,4),(4,4),(3,5),(5,5);
/*!40000 ALTER TABLE `Student_Subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subject`
--

DROP TABLE IF EXISTS `Subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subject` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `max_score` int DEFAULT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subject`
--

LOCK TABLES `Subject` WRITE;
/*!40000 ALTER TABLE `Subject` DISABLE KEYS */;
INSERT INTO `Subject` VALUES (1,'C','Structured programming language',100),(2,'CPP','Object-oriented C++ language',100),(3,'HTML','Markup language for web',100),(4,'JS','Client-side scripting',100),(5,'Python','General purpose programming',100);
/*!40000 ALTER TABLE `Subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21 18:50:43
