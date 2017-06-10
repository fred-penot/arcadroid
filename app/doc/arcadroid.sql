-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: arcadroid
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `emulator`
--

DROP TABLE IF EXISTS `emulator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emulator` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emulator`
--

LOCK TABLES `emulator` WRITE;
/*!40000 ALTER TABLE `emulator` DISABLE KEYS */;
INSERT INTO `emulator` VALUES (1,'MAME'),(2,'Playstation'),(3,'Nintendo 64'),(4,'Super Nintendo'),(5,'Megadrive');
/*!40000 ALTER TABLE `emulator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `rom` varchar(45) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `emulator_id` int(10) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_game_emulator_idx` (`emulator_id`),
  KEY `fk_game_type1_idx` (`type_id`),
  CONSTRAINT `fk_game_emulator` FOREIGN KEY (`emulator_id`) REFERENCES `emulator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Alien Vs Predator','avsp','Alien Vs Predator arcade',1,1),(2,'Asterix','asterix','Asterix arcade',1,1),(3,'Double Dragon','ddragon','Double Dragon arcade',1,1),(4,'Double Dragon II : revenge','ddragon2','Double Dragon 2 revenge arcade',1,1),(5,'Double Dragon III : Rosetta Stone','ddragon3','Double Dragon 3 Rosetta Stone arcade',1,1),(6,'Dragon Blaze','dragnblz','Dragon Blaze arcade',1,1),(7,'DragonBall Z','dbz','DragonBall Z arcade',1,1),(8,'DragonBall Z 2 : super battle','dbz2','DragonBall Z 2 super battle arcade',1,1),(9,'Dream soccer 94','dsoccr94','Dream soccer 94 arcade',1,1),(10,'Final Fight','ffight','Final Fight arcade',1,1),(11,'Gaia Crusaders','gaia','Gaia Crusaders arcade',1,1),(12,'Golden Axe','goldnaxe','Golden Axe arcade',1,1),(13,'Mario Bros','mario','Mario Bros arcade',1,1),(14,'Mars Matrix : hyper solid shooting','mmatrix','Mars Matrix hyper solid shooting arcade',1,1),(15,'Marvel Super Heroes Vs Street Fighter','mshvsf','Marvel Super Heroes Vs Street Fighter arcade',1,1),(16,'Marvel Vs Capcom','mvsc','Marvel Vs Capcom arcade',1,1),(17,'Megaman : the power battle','megaman','Megaman the power battle arcade',1,1),(18,'Megaman 2 : the power fighters','megaman2','Megaman 2 the power fighters arcade',1,1),(19,'Mortal Kombat','mk','Mortal Kombat arcade',1,1),(20,'Mortal Kombat II','mk2','Mortal Kombat 2 arcade',1,1),(21,'Mortal Kombat III','mk3','Mortal Kombat 3 arcade',1,1),(22,'NBA Jam','nbajam','NBA Jam arcade',1,1),(23,'Out Run','outrun','Out Run arcade',1,1),(24,'Pac Man','pacman','Pac Man arcade',1,1),(25,'Paperboy','paperboy','Paperboy arcade',1,1),(26,'Puzzle Bobble 4','pbobble4','Puzzle Bobble 4 arcade',1,1),(27,'Renegade','renegade','Renegade arcade',1,1),(28,'Rollergames','rollerg','Rollergames arcade',1,1),(29,'Sailor Moon (pretty soldier)','sailormn','pretty soldier Sailor Moon arcade',1,1),(30,'Shinobi','shinobi','Shinobi arcade',1,1),(31,'Soul Calibur','soulclbr','Soul Calibur arcade',1,1),(32,'Street Fighter','sf1','Street Fighter arcade',1,1),(33,'Street Fighter II','sf2','Street Fighter 2 arcade',1,1),(34,'Street Fighter Alpha','sfa','Street Fighter Alpha arcade',1,1),(35,'Street Fighter Alpha 2','sfa2','Street Fighter Alpha 2 arcade',1,1),(36,'Street Fighter Alpha 3','sfa3','Street Fighter Alpha 3 arcade',1,1),(37,'Super Mario','suprmrio','Super Mario arcade',1,1),(38,'Super World Court','swcourt','Super World Court arcade',1,1),(39,'Teenage Mutant Ninja Turtle','tmnt','Teenage Mutant Ninja Turtle arcade',1,1),(40,'Teenage Mutant Ninja Turtle : turtle in time','tmnt2','Teenage Mutant Ninja Turtle 2 turtle in time arcade',1,1),(41,'Tekken','tekken','Tekken arcade',1,1),(42,'Tekken II','tekken2','Tekken 2 arcade',1,1),(43,'Tekken III','tekken3','Tekken 3 arcade',1,1),(44,'The Simpsons','simpsons','The Simpsons arcade',1,1),(45,'Toki','toki','Toki arcade',1,1),(46,'Vampire Hunter 2 : Darkstalkers revenge','vhunt2r1','Vampire Hunter 2 Darkstalkers revenge arcade',1,1),(47,'WWF : Wrestlemania','wwfmania','WWF Wrestlemania arcade',1,1),(48,'X-Men','xmen','X-Men arcade',1,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_user`
--

DROP TABLE IF EXISTS `token_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_user` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  `time` bigint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_token_user_user_idx` (`user_id`),
  CONSTRAINT `fk_token_user_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_user`
--

LOCK TABLES `token_user` WRITE;
/*!40000 ALTER TABLE `token_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'Aventure'),(2,'Combat'),(3,'Sport'),(4,'Tir'),(5,'Plates-formes'),(6,'Réflexion'),(7,'Stratégie'),(8,'Jeu de rôle'),(9,'Action');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `profil` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user','Fwed','frederic.penot@gmail.com','fwed','1ef03ed0cd5863c550128836b28ec3e9');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-10 19:12:44
