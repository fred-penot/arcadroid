-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: arcadroid
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
  `command` varchar(500) NOT NULL,
  `path` varchar(255) NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `extension` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emulator`
--

LOCK TABLES `emulator` WRITE;
/*!40000 ALTER TABLE `emulator` DISABLE KEYS */;
INSERT INTO `emulator` VALUES (1,'MAME','/recalbox/scripts/runcommand.sh 4 \'retroarch -L /usr/lib/libretro/mame078_libretro.so --config /recalbox/share/system/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/mame/__ROM_NAME__.zip\'','/recalbox/share/roms/mame/','arcade','zip'),(2,'Playstation','/recalbox/scripts/runcommand.sh 4 \'/usr/bin/retroarch -L /usr/lib/libretro/pcsx_rearmed_libretro.so --config /recalbox/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/psx/__ROM_NAME__\'','/recalbox/share/roms/psx/','playstation','bin'),(3,'Nintendo 64','/recalbox/scripts/runcommand.sh 4 \'SDL_VIDEO_GL_DRIVER=/usr/lib/libGLESv2.so  mupen64plus --corelib /usr/lib/libmupen64plus.so.2.0.0 --gfx /usr/lib/mupen64plus/mupen64plus-video-n64.so --configdir /recalbox/configs/mupen64/ --datadir /recalbox/configs/mupen64/ /recalbox/share/roms/n64/__ROM_NAME__\'','/recalbox/share/roms/n64/','nintendo 64','n64,z64'),(4,'Super Nintendo','/recalbox/scripts/runcommand.sh 4 \'/usr/bin/retroarch -L /usr/lib/libretro/snes9x_next_libretro.so --config /recalbox/share/system/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/snes/__ROM_NAME__\'','/recalbox/share/roms/snes','super nintendo','smc'),(5,'Megadrive','/recalbox/scripts/runcommand.sh 4 \'/usr/bin/retroarch -L /usr/lib/libretro/snes9x_next_libretro.so --config /recalbox/share/system/configs/retroarch/retroarchcustom.cfg /recalbox/share/roms/snes/__ROM_NAME__\'','/recalbox/share/roms/megadrive/','megadrive','mdr');
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
  `name` varchar(150) NOT NULL,
  `rom` varchar(150) NOT NULL,
  `emulator_id` int(10) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_game_emulator_idx` (`emulator_id`),
  KEY `fk_game_type1_idx` (`type_id`),
  CONSTRAINT `fk_game_emulator` FOREIGN KEY (`emulator_id`) REFERENCES `emulator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Alien Vs Predator','avsp',1,1),(2,'Asterix','asterix',1,1),(3,'Double Dragon','ddragon',1,1),(4,'Double Dragon II : revenge','ddragon2',1,1),(5,'Double Dragon III : Rosetta Stone','ddragon3',1,1),(6,'Dragon Blaze','dragnblz',1,1),(7,'DragonBall Z','dbz',1,1),(8,'DragonBall Z 2 : super battle','dbz2',1,1),(9,'Dream soccer 94','dsoccr94',1,1),(10,'Final Fight','ffight',1,1),(11,'Gaia Crusaders','gaia',1,1),(12,'Golden Axe','goldnaxe',1,1),(13,'Mario Bros','mario',1,1),(14,'Mars Matrix : hyper solid shooting','mmatrix',1,1),(15,'Marvel Super Heroes Vs Street Fighter','mshvsf',1,1),(16,'Marvel Vs Capcom','mvsc',1,1),(17,'Megaman : the power battle','megaman',1,1),(18,'Megaman 2 : the power fighters','megaman2',1,1),(19,'Mortal Kombat','mk',1,1),(20,'Mortal Kombat II','mk2',1,1),(21,'Mortal Kombat III','mk3',1,1),(22,'NBA Jam','nbajam',1,1),(23,'Out Run','outrun',1,1),(24,'Pac Man','pacman',1,1),(25,'Paperboy','paperboy',1,1),(26,'Puzzle Bobble 4','pbobble4',1,1),(27,'Renegade','renegade',1,1),(28,'Rollergames','rollerg',1,1),(29,'Sailor Moon (pretty soldier)','sailormn',1,1),(30,'Shinobi','shinobi',1,1),(31,'Soul Calibur','soulclbr',1,1),(32,'Street Fighter','sf1',1,1),(33,'Street Fighter II','sf2',1,1),(34,'Street Fighter Alpha','sfa',1,1),(35,'Street Fighter Alpha 2','sfa2',1,1),(36,'Street Fighter Alpha 3','sfa3',1,1),(37,'Super Mario','suprmrio',1,1),(38,'Super World Court','swcourt',1,1),(39,'Teenage Mutant Ninja Turtle','tmnt',1,1),(40,'Teenage Mutant Ninja Turtle : turtle in time','tmnt2',1,1),(41,'Tekken','tekken',1,1),(42,'Tekken II','tekken2',1,1),(43,'Tekken III','tekken3',1,1),(44,'The Simpsons','simpsons',1,1),(45,'Toki','toki',1,1),(46,'Vampire Hunter 2 : Darkstalkers revenge','vhunt2r1',1,1),(47,'WWF : Wrestlemania','wwfmania',1,1),(48,'X-Men','xmen',1,1),(49,'Tekken 3','Tekken_3_Track_1.bin',2,1),(50,'Mario Kart','Mario_Kart_64.v64',3,1),(51,'3 Ninjas Kick Back','3_Ninjas_Kick_Back.smc',4,1),(52,'1080 Snowboarding','1080_Snowboarding.z64',3,1),(53,'All Star Tennis \'99','All_Star_Tennis__99.z64',3,1),(54,'BattleTanx - Global Assault','BattleTanx_-_Global_Assault.z64',3,1),(55,'Beast Wars Transmetal','Beast_Wars_Transmetal.z64',3,1),(56,'Bust-A-Move 2 - Arcade Edition','Bust-A-Move_2_-_Arcade_Edition.z64',3,1),(57,'Destruction Derby 64','Destruction_Derby_64z64',3,1),(58,'Excitebike 64','Excitebike_64.z64',3,1),(59,'Extreme-G','Extreme-G.z64',3,1),(60,'Extreme-G XG2','Extreme-G_XG2.z64',3,1),(61,'Fighter\'s Destiny','Fighter_s_Destiny.z64',3,1),(62,'Fighting Force 64','Fighting_Force_64.z64',3,1),(64,'Forsaken 64','Forsaken_64.z64',3,1),(65,'Hot Wheels Turbo Racing','Hot_Wheels_Turbo_Racing.z64',3,1),(66,'Hydro Thunder','Hydro_Thunder.z64',3,1),(67,'Killer Instinct Gold','Killer_Instinct_Gold.z64',3,1),(68,'Lode Runner 3D','Lode_Runner_3D.z64',3,1),(69,'Mace - The Dark Age','Mace_-_The_Dark_Age.z64',3,1),(70,'Mario Golf','Mario_Golf_(E).z64',3,1),(71,'Midway\'s Greatest Arcade Hits Volume 1','Midway_s_Greatest_Arcade_Hits_Volume_1.z64',3,1),(72,'Mortal Kombat 4','Mortal_Kombat_4.z64',3,1),(73,'Namco Museum 64','Namco_Museum_64.z64',3,1),(74,'Nuclear Strike 64','Nuclear_Strike_64.z64',3,1),(75,'Off Road Challenge','Off_Road_Challenge.z64',3,1),(76,'Polaris SnoCross','Polaris_SnoCross.z64',3,1),(77,'RR64 - Ridge Racer 64','RR64_-_Ridge_Racer_64.z64',3,1),(78,'Rampage 2 - Universal Tour','Rampage_2_-_Universal_Tour.z64',3,1),(79,'Re-Volt','Re-Volt.z64',3,1),(80,'Ready 2 Rumble Boxing - Round 2','Ready_2_Rumble_Boxing_-_Round_2.z64',3,1),(81,'Ridge Racer 64','Ridge_Racer_64.z64',3,1),(82,'Road Rash 64','Road_Rash_64.z64',3,1),(83,'S.C.A.R.S.','S.C.A.R.S..z64',3,1),(84,'Shadow Man','Shadow_Man.z64',3,1),(85,'Star Wars Episode I - Racer','Star_Wars_Episode_I_-_Racer.z64',3,1),(86,'Virtual Chess 64','Virtual_Chess_64.z64',3,1),(87,'Virtual Pool 64','Virtual_Pool_64.z64',3,1),(88,'Waialae Country Club - True Golf Classics','Waialae_Country_Club_-_True_Golf_Classics.z64',3,1),(89,'Wave Race 64','Wave_Race_64.z64',3,1),(90,'Wipeout 64','Wipeout_64.z64',3,1),(91,'Addams Family - Pugsley\'s Scavenger Hunt','Addams_Family_-_Pugsley_s_Scavenger_Hunt.smc',4,1),(92,'Addams Family','Addams_Family.smc',4,1),(93,'Adventures of Batman & Robin','Adventures_of_Batman_&_Robin.smc',4,1),(94,'Adventures of Dr. Franken','Adventures_of_Dr._Franken.smc',4,1),(95,'Adventures of Kid Kleets','Adventures_of_Kid_Kleets.smc',4,1),(96,'Aero Fighters','Aero_Fighters.smc',4,1),(97,'Aladdin','Aladdin.smc',4,1),(98,'Alcahest','Alcahest.smc',4,1),(99,'Alien 3','Alien_3.smc',4,1),(100,'Alien vs. Predator','Alien_vs._Predator.smc',4,1),(101,'Arkanoid - Doh It Again','Arkanoid_-_Doh_It_Again.smc',4,1),(102,'Armored Police Metal Jack','Armored_Police_Metal_Jack.smc',4,1),(103,'Art of Fighting','Art_of_Fighting.smc',4,1),(104,'Asterix & Obelix','Asterix_&_Obelix.smc',4,1),(105,'Asterix','Asterix.smc',4,1),(106,'Axelay','Axelay.smc',4,1),(107,'B.O.B.','B.O.B..smc',4,1),(108,'Baby T-Rex','Baby_T-Rex.smc',4,1),(109,'Ballz 3D','Ballz_3D.smc',4,1),(110,'Bass Masters Classic Pro Edition','Bass_Masters_Classic_Pro_Edition.smc',4,1),(111,'Bassin\'s Black Bass','Bassin_s_Black_Bass.smc',4,1),(112,'Batman Forever','Batman_Forever.smc',4,1),(113,'Batman Returns','Batman_Returns.smc',4,1),(114,'Battle Blaze','Battle_Blaze.smc',4,1),(115,'Battle Cars','Battle_Cars.smc',4,1),(116,'Battle Pinball','Battle_Pinball.smc',4,1),(117,'Battle Robot Retsuden','Battle_Robot_Retsuden.smc',4,1),(118,'Battletoads in Battlemaniacs','Battletoads_in_Battlemaniacs.smc',4,1),(119,'Beauty and the Beast','Beauty_and_the_Beast.smc',4,1),(120,'Best of the Best - Championship Karate','Best_of_the_Best_-_Championship_Karate.smc',4,1),(121,'Biker Mice From Mars','Biker_Mice_From_Mars.smc',4,1),(122,'Bio Metal','Bio_Metal.smc',4,1),(123,'Blazing Skies','Blazing_Skies.smc',4,1),(124,'Boxing Legends of the Ring','Boxing_Legends_of_the_Ring.smc',4,1),(125,'Brutal - Paws of Fury','Brutal_-_Paws_of_Fury.smc',4,1),(126,'Bust-A-Move','Bust-A-Move.smc',4,1),(127,'Cannon Fodder','Cannon_Fodder.smc',4,1),(128,'Captain Commando','Captain_Commando.smc',4,1),(129,'Carrier Aces','Carrier_Aces.smc',4,1),(130,'Castlevania - Dracula X','Castlevania_-_Dracula_X.smc',4,1),(131,'Chavez II','Chavez_II.smc',4,1),(132,'Choplifter III','Choplifter_III.smc',4,1),(133,'Chuck Rock','Chuck_Rock.smc',4,1),(134,'Clay Fighter - Tournament Edition','Clay_Fighter_-_Tournament_Edition.smc',4,1),(135,'Clay Fighter 2 - Judgement Clay','Clay_Fighter_2_-_Judgement_Clay.smc',4,1),(136,'Clay Fighter','Clay_Fighter.smc',4,1),(137,'Claymates','Claymates.smc',4,1),(138,'Combatribes','Combatribes.smc',4,1),(139,'Cool Spot','Cool_Spot.smc',4,1),(140,'Corn Buster','Corn_Buster.smc',4,1),(141,'Cutthroat Island','Cutthroat_Island.smc',4,1),(142,'Daffy Duck - The Marvin Missions','Daffy_Duck_-_The_Marvin_Missions.smc',4,1),(143,'Darius Force','Darius_Force.smc',4,1),(144,'David Crane\'s Amazing Tennis','David_Crane_s_Amazing_Tennis.smc',4,1),(145,'Dead Dance','Dead_Dance.smc',4,1),(146,'Demolition Man','Demolition_Man.smc',4,1),(147,'Demon\'s Crest','Demon_s_Crest.smc',4,1),(148,'Desert Fighter','Desert_Fighter.smc',4,1),(149,'Desert Strike - Return to the Gulf','Desert_Strike_-_Return_to_the_Gulf.smc',4,1),(150,'Donald Duck - Maui Mallard in Cold Shadow','Donald_Duck_-_Maui_Mallard_in_Cold_Shadow.smc',4,1),(151,'Donald Duck - Maui Mallard','Donald_Duck_-_Maui_Mallard.smc',4,1),(152,'Donkey Kong Country 2 - Diddy\'s Kong Quest','Donkey_Kong_Country_2_-_Diddy_s_Kong_Quest.smc',4,1),(153,'Donkey Kong Country 3 - Dixie Kong\'s Double Trouble','Donkey_Kong_Country_3_-_Dixie_Kong_s_Double_Trouble.smc',4,1),(154,'Donkey Kong Country','Donkey_Kong_Country.smc',4,1),(155,'DonkeyKongClassic','DonkeyKongClassic.smc',4,1),(156,'Doom Troopers','Doom_Troopers.smc',4,1),(157,'Doomsday Warrior','Doomsday_Warrior.smc',4,1),(158,'Double Dragon V - The Shadow Falls','Double_Dragon_V_-_The_Shadow_Falls.smc',4,1),(159,'Dragon - The Bruce Lee Story','Dragon_-_The_Bruce_Lee_Story.smc',4,1),(160,'Dragon Ball Z - Hyper Dimension','Dragon_Ball_Z_-_Hyper_Dimension.smc',4,1),(161,'Dragon Ball Z - Super Butouden 2','Dragon_Ball_Z_-_Super_Butouden_2.smc',4,1),(162,'Dragon Ball Z - Super Butouden 3','Dragon_Ball_Z_-_Super_Butouden_3.smc',4,1),(163,'Dragon Ball Z - Super Butouden','Dragon_Ball_Z_-_Super_Butouden.smc',4,1),(164,'Earthworm Jim 2','Earthworm_Jim_2.smc',4,1),(165,'Earthworm Jim','Earthworm_Jim.smc',4,1),(166,'Edono Kiba','Edono_Kiba.smc',4,1),(167,'FIFA \'98','FIFA__98.smc',4,1),(168,'Fatal Fury 2','Fatal_Fury_2.smc',4,1),(169,'Fatal Fury Special','Fatal_Fury_Special.smc',4,1),(170,'Fatal Fury','Fatal_Fury.smc',4,1),(171,'Fighter\'s History','Fighter_s_History.smc',4,1),(172,'Final Fight 2','Final_Fight_2.smc',4,1),(173,'Final Fight 3','Final_Fight_3.smc',4,1),(174,'Final Fight Guy','Final_Fight_Guy.smc',4,1),(175,'Final Fight','Final_Fight.smc',4,1),(176,'Final Knockout','Final_Knockout.smc',4,1),(177,'Firemen','Firemen.smc',4,1),(178,'First Samurai','First_Samurai.smc',4,1),(179,'Flashback - The Quest for Identity','Flashback_-_The_Quest_for_Identity.smc',4,1),(180,'Flintstones - The Treasure of Sierra Madrock','Flintstones_-_The_Treasure_of_Sierra_Madrock.smc',4,1),(181,'Flintstones','Flintstones.smc',4,1),(182,'Foreman For Real','Foreman_For_Real.smc',4,1),(183,'Frantic Flea','Frantic_Flea.smc',4,1),(184,'Full Throttle Racing','Full_Throttle_Racing.smc',4,1),(185,'Ganbare Goemon 3 - Shishi Juurokubei no Karakuri Manjigatame','Ganbare_Goemon_3_-_Shishi_Juurokubei_no_Karakuri_Manjigatame.smc',4,1),(186,'Genocide 2','Genocide_2.smc',4,1),(187,'Gods','Gods.smc',4,1),(188,'Godzilla - Kaijuu Daikessen','Godzilla_-_Kaijuu_Daikessen.smc',4,1),(189,'Gradius 3','Gradius_3.smc',4,1),(190,'Great Battle III','Great_Battle_III.smc',4,1),(191,'Great Battle IV','Great_Battle_IV.smc',4,1),(192,'Great Battle V','Great_Battle_V.smc',4,1),(193,'Great Circus Mystery Starring Mickey & Minnie','Great_Circus_Mystery_Starring_Mickey_&_Minnie.smc',4,1),(194,'Gun Force','Gun_Force.smc',4,1),(195,'Gundam Wing - Endless Duel','Gundam_Wing_-_Endless_Duel.smc',4,1),(196,'Hagane','Hagane.smc',4,1),(197,'Hamelin no Violin Tamaki','Hamelin_no_Violin_Tamaki.smc',4,1),(198,'Home Improvement','Home_Improvement.smc',4,1),(199,'Hook','Hook.smc',4,1),(200,'Humans','Humans.smc',4,1),(201,'Hurricanes','Hurricanes.smc',4,1),(202,'Hyper V-Ball','Hyper_V-Ball.smc',4,1),(203,'Ignition Factor','Ignition_Factor.smc',4,1),(204,'Incantation','Incantation.smc',4,1),(205,'Incredible Hulk','Incredible_Hulk.smc',4,1),(206,'Indiana Jones - Trilogy','Indiana_Jones_-_Trilogy.smc',4,1),(207,'Indiana Jones\' Greatest Adventures','Indiana_Jones__Greatest_Adventures.smc',4,1),(208,'Inspector Gadget','Inspector_Gadget.smc',4,1),(209,'Iron Commando - Koutetsu no Senshi','Iron_Commando_-_Koutetsu_no_Senshi.smc',4,1),(210,'Iron Commando','Iron_Commando.smc',4,1),(211,'Jammes','Jammes.smc',4,1),(212,'Jim Lee\'s WildC.A.T.S','Jim_Lee_s_WildC.A.T.S.smc',4,1),(213,'Jim Power - The Lost Dimension in 3D','Jim_Power_-_The_Lost_Dimension_in_3D.smc',4,1),(214,'Joe & Mac - Caveman Ninja','Joe_&_Mac_-_Caveman_Ninja.smc',4,1),(215,'Joe & Mac 2 - Lost in the Tropics','Joe_&_Mac_2_-_Lost_in_the_Tropics.smc',4,1),(216,'Joe & Mac','Joe_&_Mac.smc',4,1),(217,'Judge Dredd','Judge_Dredd.smc',4,1),(218,'Jungle Book','Jungle_Book.smc',4,1),(219,'Jurassic Park 2','Jurassic_Park_2.smc',4,1),(220,'Jurassic Park','Jurassic_Park.smc',4,1),(221,'Justice League Task Force','Justice_League_Task_Force.smc',4,1),(222,'Kid Klown in Crazy Chase','Kid_Klown_in_Crazy_Chase.smc',4,1),(223,'Kidou Butouden G-Gundam','Kidou_Butouden_G-Gundam.smc',4,1),(224,'Killer Instinct','Killer_Instinct.smc',4,1),(225,'Last Action Hero','Last_Action_Hero.smc',4,1),(226,'Legend','Legend.smc',4,1),(227,'Lester the Unlikely','Lester_the_Unlikely.smc',4,1),(228,'Lethal Enforcers','Lethal_Enforcers.smc',4,1),(229,'Lion King','Lion_King.smc',4,1),(230,'Lode Runner Twin','Lode_Runner_Twin.smc',4,1),(231,'Lost Vikings 2','Lost_Vikings_2.smc',4,1),(232,'Lost Vikings','Lost_Vikings.smc',4,1),(233,'Magic Sword','Magic_Sword.smc',4,1),(234,'Magical Drop 2','Magical_Drop_2.smc',4,1),(235,'Magical Drop','Magical_Drop.smc',4,1),(236,'Magical Quest Starring Mickey Mouse','Magical_Quest_Starring_Mickey_Mouse.smc',4,1),(237,'Mario\'s Time Machine','Mario_s_Time_Machine.smc',4,1),(238,'Marvel Super Heroes - War of the Gems','Marvel_Super_Heroes_-_War_of_the_Gems.smc',4,1),(239,'Mechwarrior 3050','Mechwarrior_3050.smc',4,1),(240,'Mechwarrior','Mechwarrior.smc',4,1),(241,'Metal Combat - Falcon\'s Revenge','Metal_Combat_-_Falcon_s_Revenge.smc',4,1),(242,'Metal Morph','Metal_Morph.smc',4,1),(243,'Mickey Mania','Mickey_Mania.smc',4,1),(244,'Mickey no Magical Adventure','Mickey_no_Magical_Adventure.smc',4,1),(245,'Mighty Max','Mighty_Max.smc',4,1),(246,'Mortal Kombat 2','Mortal_Kombat_2.smc',4,1),(247,'Mortal Kombat 3','Mortal_Kombat_3.smc',4,1),(248,'Mortal Kombat','Mortal_Kombat.smc',4,1),(249,'Ninja Gaiden Trilogy','Ninja_Gaiden_Trilogy.smc',4,1),(250,'Ninja Warriors Again','Ninja_Warriors_Again.smc',4,1),(251,'Ninja Warriors','Ninja_Warriors.smc',4,1),(252,'No Escape','No_Escape.smc',4,1),(253,'Nosferatu','Nosferatu.smc',4,1),(254,'On the Ball','On_the_Ball.smc',4,1),(255,'Oscar','Oscar.smc',4,1),(256,'Pikiinya!','Pikiinya!.smc',4,1),(257,'Pinball Dreams','Pinball_Dreams.smc',4,1),(258,'Pinball Fantasies','Pinball_Fantasies.smc',4,1),(259,'Pinball Pinball','Pinball_Pinball.smc',4,1),(260,'Prehistorik Man','Prehistorik_Man.smc',4,1),(261,'Primal Rage','Primal_Rage.smc',4,1),(262,'Prince of Persia 2','Prince_of_Persia_2.smc',4,1),(263,'Prince of Persia','Prince_of_Persia.smc',4,1),(264,'Push-Over','Push-Over.smc',4,1),(265,'Putty Squad','Putty_Squad.smc',4,1),(266,'Puzzle Bobble','Puzzle_Bobble.smc',4,1),(267,'Q-bert 3','Q-bert_3.smc',4,1),(268,'R-Type 3','R-Type_3.smc',4,1),(269,'Return of Double Dragon','Return_of_Double_Dragon.smc',4,1),(270,'Rise of the Robots','Rise_of_the_Robots.smc',4,1),(271,'Rival Turf','Rival_Turf.smc',4,1),(272,'Rock N\' Roll Racing','Rock_N__Roll_Racing.smc',4,1),(273,'Samurai Showdown','Samurai_Showdown.smc',4,1),(274,'SeaQuest DSV','SeaQuest_DSV.smc',4,1),(275,'Shadow','Shadow.smc',4,1),(276,'Soldiers of Fortune','Soldiers_of_Fortune.smc',4,1),(277,'Sonic Blast Man II','Sonic_Blast_Man_II.smc',4,1),(278,'Sonic Blast Man','Sonic_Blast_Man.smc',4,1),(279,'Sonic Wings','Sonic_Wings.smc',4,1),(280,'Sonic the Hedgehog','Sonic_the_Hedgehog.smc',4,1),(281,'Spawn','Spawn.smc',4,1),(282,'Spell Craft','Spell_Craft.smc',4,1),(283,'Street Combat','Street_Combat.smc',4,1),(284,'Street Fighter 2 Turbo','Street_Fighter_2_Turbo.smc',4,1),(285,'Street Fighter Alpha 2','Street_Fighter_Alpha_2.smc',4,1),(286,'Street Fighter II - The World Warrior','Street_Fighter_II_-_The_World_Warrior.smc',4,1),(287,'Street Fighter Zero 2','Street_Fighter_Zero_2.smc',4,1),(288,'Street Racer','Street_Racer.smc',4,1),(289,'Sunset Riders','Sunset_Riders.smc',4,1),(290,'Super Bowling','Super_Bowling.smc',4,1),(291,'Super Pang','Super_Pang.smc',4,1),(292,'Super Putty','Super_Putty.smc',4,1),(293,'Super Street Fighter II - The New Challengers','Super_Street_Fighter_II_-_The_New_Challengers.smc',4,1),(294,'U.N. Squadron','U.N._Squadron.smc',4,1),(295,'Ultimate Mortal Kombat 3','Ultimate_Mortal_Kombat_3.smc',4,1),(296,'Wings 2 - Aces High','Wings_2_-_Aces_High.smc',4,1),(297,'World Heroes 2','World_Heroes_2.smc',4,1),(298,'X-Men Mutant Apocalypse','X-Men_Mutant_Apocalypse.smc',4,1),(299,'Zool','Zool.smc',4,1),(300,'Crash Bandicoot','Crash_Bandicoot.bin',2,1),(301,'Dragon Ball Z - Ultimate Battle 22','Dragon_Ball_Z_-_Ultimate_Battle_22.bin',2,1),(302,'Fatal Fury - Wild Ambition','Fatal_Fury_-_Wild_Ambition.bin',2,1),(303,'Resident evil 2 CD1','Resident_evil_2_CD1.bin',2,1),(304,'Resident Evil2 CD2 Pal','Resident_Evil2_CD2_Pal.bin',2,1),(305,'Street Fighter Alpha 3','Street_Fighter_Alpha_3.bin',2,1),(306,'Street Fighter Alpha 3','Street_Fighter_Alpha_3.bin',2,1),(307,'Tekken 3','Tekken_3.bin',2,1),(308,'Tekken 3','Tekken_3.bin',2,1),(309,'Destruction Derby 64','Destruction_Derby_64.z64',3,1),(310,'Mario Golf','Mario_Golf.z64',3,1),(311,'Xena Warrior Princess - The Talisman of Fate','Xena_Warrior_Princess_-_The_Talisman_of_Fate.z64',3,1),(312,'Zelda - Majora s Mask','Zelda_-_Majora_s_Mask.z64',3,1),(313,'Zelda - Ocarina of Time','Zelda_-_Ocarina_of_Time.z64',3,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_user`
--

DROP TABLE IF EXISTS `token_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  `time` bigint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_token_user_user_idx` (`user_id`),
  CONSTRAINT `fk_token_user_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1537 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_user`
--

LOCK TABLES `token_user` WRITE;
/*!40000 ALTER TABLE `token_user` DISABLE KEYS */;
INSERT INTO `token_user` VALUES (1527,1,'1661cb15f6a92f0d91859bcec9f6fdab',1501450242),(1528,1,'2307915b9bc0bdb3e75dcd7173006e85',1501450290),(1529,1,'bfa4e98f6553f83665a4335e9f2e8c6c',1501450293),(1530,1,'e2bbf69790c131d6576d23d362653f82',1501450294),(1531,1,'24c9bdb9d66eb2d0cc80363db536f0b2',1501450300),(1532,1,'01caaed9477cd868db53d0c89e027fed',1501450306),(1533,1,'2eec3df13be4dac0d447151c836c8bb0',1501450307),(1534,1,'36cc9bcb05ee3caa97a3a5c2898fcab5',1501450338),(1535,1,'2dd1725c815ca40371f90df9e08f56d8',1501450342),(1536,1,'46c9750d5d986693df52418483606a26',1501450343);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
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

-- Dump completed on 2017-07-30 23:34:43
