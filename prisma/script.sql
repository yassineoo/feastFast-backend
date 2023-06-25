-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: feastfast
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `categorie` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitems`
--

LOCK TABLES `menuitems` WRITE;
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
INSERT INTO `menuitems` VALUES (1,2,'Caesar Salad','Crisp romaine lettuce with parmesan cheese, croutons, and classic Caesar dressing',8.99,'https://example.com/images/salad.jpg','pizza'),(2,1,'French Fries','Thin, crispy french fries with sea salt',4.99,'https://example.com/images/fries.jpg','pizza'),(3,1,'Chicken Wings','Spicy buffalo chicken wings with blue cheese dip',12.99,'https://example.com/images/wings.jpg','tacos'),(4,1,'Margherita Pizza','Classic Neapolitan-style pizza with tomato sauce, mozzarella, and fresh basil',14.99,'https://example.com/images/pizza.jpg','tacos'),(13,4,'chicken box','Spicy chicken with delicious sauce and crispy wings',450.00,'hotspot_chicken_box.png','Boxes'),(14,4,'fries','fries not much to say!',250.00,'hotspot_fries.png','Fried'),(15,4,'lebanese wrap','great marinated chicken wrapped in house made bread',350.00,'hotspot_lebanese_wrap.png','Sandwiches'),(16,4,'pizza','wood baked pizza',500.00,'hotspot_pizza.png','Pizza'),(17,4,'salad','fresh salad with organic ingredients',300.00,'hotspot_salad.png','Healthy'),(18,4,'wok box','Description of Menu Item 6',800.00,'hotspot_wok_box.png','Boxes'),(19,4,'mega family meal','Description of Menu Item 6',1000.00,'hotspot_family_meal.png','Combos'),(20,5,'coffee','pure black coffee refreshing',150.00,'foodland_coffee.png','Drinks'),(21,5,'gratin','backed and cheesy',280.00,'foodland_gratin.png','Gratins'),(22,5,'pailleia','seafoody',900.00,'foodland_pailleia.png','Seafood'),(23,5,'sandwich','filling sandwich',300.00,'foodland_sandwich.png','Sandwiches'),(24,5,'soup','nice and warm',200.00,'foodland_soup.png','Entrees'),(25,5,'tacos','Description of Menu Item 6',300.00,'foodland_tacos.png','Tacos'),(26,6,'coffee','pure black coffee refreshing',150.00,'foodland_coffee.png','Drinks'),(27,6,'gratin','backed and cheesy',280.00,'foodland_gratin.png','Gratins'),(28,6,'pailleia','seafoody',900.00,'foodland_pailleia.png','Seafood'),(29,6,'sandwich','filling sandwich',300.00,'foodland_sandwich.png','Sandwiches'),(30,6,'soup','nice and warm',200.00,'foodland_soup.png','Entrees'),(31,6,'tacos','Description of Menu Item 6',300.00,'foodland_tacos.png','Tacos');
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_id` int NOT NULL,
  `notification_type` enum('Preparing','Picked Up','On the Way') NOT NULL,
  `sent_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `menu_item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `special_instructions` text,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `menu_item_id` (`menu_item_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`menu_item_id`) REFERENCES `menuitems` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (9,11,1,2,'No onions please'),(10,11,4,1,'Extra cheese');
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `delivery_address` varchar(255) NOT NULL,
  `delivery_notes` text,
  `order_status` varchar(100) NOT NULL DEFAULT (_utf8mb4'Pending'),
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `restaurantName` varchar(100) NOT NULL,
  `totalPrice` float NOT NULL,
  `isRated` tinyint(1) DEFAULT (false),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (11,1,1,'123 Main St','Ring buzzer for delivery','Pending','2023-05-09','21:22:28','taco haven',100,0),(12,1,3,'456 Elm St','jojo','Preparing','2023-05-09','21:22:28','pho house',300,0),(13,1,1,'P593+5C6, Oued Smar, Algeria',NULL,'Pending','2023-06-23','18:37:40','HotSpot DZ 1',950,0),(14,1,1,'P593+5C6, Oued Smar, Algeria',NULL,'Pending','2023-06-23','18:38:29','HotSpot DZ 1',950,0),(15,1,1,'P593+5C6, Oued Smar, Algeria',NULL,'Pending','2023-06-24','02:05:47','Pho House',254.99,0),(16,28,1,'P593+6W7, Oued Smar 16000, Algeria',NULL,'Pending','2023-06-24','02:26:38','Pho House',254.99,0),(17,28,1,'P593+6W7, Oued Smar 16000, Algeria',NULL,'Pending','2023-06-24','02:28:31','Pho House',254.99,0),(18,28,2,'P593+6W7, Oued Smar 16000, Algeria',NULL,'Completed','2023-06-24','02:59:35','Pizza Palace',265.733,0),(19,28,1,'P593+6W7, Oued Smar 16000, Algeria',NULL,'Completed','2023-06-24','03:32:26','Pho House',254.99,0),(20,28,1,'P54C+G8H, Bab Ezzouar, Algeria',NULL,'Pending','2023-06-24','09:36:12','Pho House',295.465,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefer_restaurant`
--

DROP TABLE IF EXISTS `prefer_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prefer_restaurant` (
  `user_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`restaurant_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `prefer_restaurant_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `prefer_restaurant_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefer_restaurant`
--

LOCK TABLES `prefer_restaurant` WRITE;
/*!40000 ALTER TABLE `prefer_restaurant` DISABLE KEYS */;
INSERT INTO `prefer_restaurant` VALUES (1,1),(28,1),(9,3);
/*!40000 ALTER TABLE `prefer_restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `rating` int NOT NULL,
  `review` text,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,1,1,4,'Great food and atmosphere!','2023-05-09 10:30:00'),(2,9,1,2,'bad service','2023-07-23 14:44:00'),(3,28,1,1,'good','2023-06-24 04:35:07'),(4,28,1,2,'hhh','2023-06-24 04:35:20'),(5,28,2,3,'kjj','2023-06-24 05:51:40'),(6,28,2,3,'kjj','2023-06-24 05:51:41'),(7,28,2,3,'kjj','2023-06-24 05:51:42'),(8,28,2,3,'','2023-06-24 08:48:17'),(9,28,2,2,'','2023-06-24 08:48:45'),(10,28,1,4,'the fois was goid','2023-06-24 09:37:40');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `locationAddress` varchar(255) NOT NULL,
  `locationMapLat` float DEFAULT NULL,
  `locationMaplong` float DEFAULT NULL,
  `cuisineType` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `averageRating` float DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `instaLink` varchar(255) DEFAULT NULL,
  `fbLink` varchar(255) DEFAULT NULL,
  `opening_time` time DEFAULT '10:00:00',
  `closing_time` time DEFAULT '00:00:00',
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Pho House','phohouse.jpg','phohouselogo.png','567 Walnut Street',34.0522,-118.244,'Vietnamese','(555) 555-6789',0,'info@phohouse.com','https://instagram.com/phohouse','https://facebook.com/phohouse','10:00:00','00:00:00'),(2,'Pizza Palace','pizza-place.jpg','phohouse.png','234 Maple Street',34.0522,-118.244,'Italian','(555) 555-3456',0,'info@pizzapalace.com','https://instagram.com/pizzapalace','https://facebook.com/pizzapalace','10:00:00','00:00:00'),(3,'Taco Haven','taco-haven.jpg','phohouse.png','789 Oak Street',34.0522,-118.244,'Mexican','(555) 555-9012',0,'info@tacohaven.com','https://instagram.com/tacohaven','https://facebook.com/tacohaven','10:00:00','00:00:00'),(4,'hotspot','hotspot.png','hotspot_logo.png','Kouba, Algiers',NULL,NULL,'NeoModern',NULL,NULL,NULL,NULL,NULL,'10:00:00','00:00:00'),(5,'foodland','foodland.png','foodland_logo.png','Cheraga, Algiers',NULL,NULL,'French',NULL,NULL,NULL,NULL,NULL,'10:00:00','00:00:00'),(6,'hotspot','hotspot.png','hotspot_logo.png','Kouba, Algiers',NULL,NULL,'NeoModern',NULL,NULL,NULL,NULL,NULL,'10:00:00','00:00:00');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `user_id` int NOT NULL,
  `order_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_text` text,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`order_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `registration_type` enum('Native','Facebook','Google') NOT NULL,
  `social_media_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Doe','john.doe@example.com','1234567890','123 Main St, Anytown, USA','mypassword',40.7128,-74.006,'profile-pic.jpg','Native',NULL),(2,'Jane Smith','jane.smith@example.com','0987654321','456 Elm St, Anytown, USA','anotherpassword',37.7749,-122.419,'profile-pic.png','Facebook','123456'),(3,'Bob Johnson','bob.johnson@example.com','5555555555','789 Oak St, Anytown, USA','yetanotherpassword',51.5074,-0.1278,NULL,'Google','789012'),(4,'yassine ','jy_attou@esi.sa','0794724',NULL,'0879t',NULL,NULL,NULL,'Native',NULL),(5,'yassine b','jy_attou@esi.dzv','079472486',NULL,'0879thg',NULL,NULL,NULL,'Native',NULL),(6,'islam','jy_attbvou@esi.dz','079885',NULL,'bjxpo',NULL,NULL,NULL,'Native',NULL),(7,'islam','jy_attbvou@esi.dzr','07988565',NULL,'$2b$10$QdtPi92hGVGqUbiBDnxrVeoBiwv8PnPZXdz5FKDgLm6uSmldU5JpK',NULL,NULL,NULL,'Native',NULL),(9,'Islam Youcef2','my@gmail.dz','07988565628',NULL,'$2b$10$OeStf3kIyvNtfOeqe9m2d.S80OIvWRgy0r.3V0MELjo3wlGU4f6p6',NULL,NULL,'pr731233.png','Native',NULL),(10,'yasww','y@j.com','0878885',NULL,'$2b$10$IeijPvSBmN063XEMENiZ2edQWJKGhNhgF7CQgGW93pW8txiE180Pa',NULL,NULL,'profile0.31643011498594587.png','Native',NULL),(11,'nur','hb','56',NULL,'$2b$10$a3Ml/vbIFzx6usDpvMEm.OfSNi9qDYRxtqw/wkgTmLWExH2VzJc8y',NULL,NULL,'profile0.8177053971073909.png','Native',NULL),(14,'d4ui5','xut','0565',NULL,'$2b$10$oqMZ5TNCBqN6Y9rz8hVRzefFSxjCDJ87YUK4FDpwuvQlqzLnEAqIe',NULL,NULL,'profile0.38659497053536307.png','Native',NULL),(18,'d4ui5hnx','xutj6hxnny','05658',NULL,'$2b$10$D7b5B8vCEarXquh8XWvYDeUyRslOS5/LTzEborUs8H8dNgrg6hxue',NULL,NULL,'profile0.9605172021668906.png','Native',NULL),(21,'d4ui5hnxsd','xutj6hxnnyff','0565808',NULL,'$2b$10$sDDKG300/RVq40AWPtiTJuNQjqVlO29unOEUoTY/9pAEACFtxrL1.',NULL,NULL,'profile0.8977293109283844.png','Native',NULL),(22,'d4ui5hnxsd','xutj6hxnnyffgf','05658080',NULL,'$2b$10$r1Imfaq2E7JfcTweFM.LluE2KhR6O0wqjSdTfkljiKaVoOWvxhdW.',NULL,NULL,'profile0.5082805873083969.png','Native',NULL),(23,'yf','xyfe','82623',NULL,'$2b$10$fjOYXp81hVbmMY4jfbDlo.vndBiaL5T7m3CMVvtOnmcgEFq0MPtgi',NULL,NULL,'profile0.7811164543057638.png','Native',NULL),(24,'ye5u','vtdtv','362',NULL,'$2b$10$hgzWn2.AM2gJL1hra09/Re2SsL6lp.Qsr2OACsTKeLBu.qjerg2oK',NULL,NULL,'profile0.20517223395218598.png','Native',NULL),(25,'yassino','sa@u.com','10288',NULL,'$2b$10$vgBASNxAzp2ps4YbVXWzQueyyBCxCFV5RUOOPUYFyFvNiGvtXOk/e',NULL,NULL,'profile0.8896763402457852.png','Native',NULL),(26,'yassino','jy_attou@esi.dz','885566788',NULL,'$2b$10$T3yA0x/91ReuuPceSZOGSOEXzzwAU5tENDwBQmcVW9iRLIJKv/DYe',NULL,NULL,'pr256970.png','Native',NULL),(27,'islam','jy_ghodbane@esi.dz','0236481904',NULL,'$2b$10$6dRBha6aUPGF1/Fy04V.Ve22bm2OCeFrRAyQXE.S2FiZmt5HPXsWi',NULL,NULL,'pr495491.png','Native',NULL),(28,'fake me','fake@fake.com','1236450709',NULL,'$2b$10$1pbgS/G6/eBnbhbo/y16au7teWEHntGxV9xJRY8IA8kYmUsIvS5NK',NULL,NULL,'pr493648.png','Native',NULL),(29,'meeee','esi@esi.dz','07512369',NULL,'$2b$10$Njd/pe1ZLiqFocmrOpMcTuKtNgfUmprgQ/Kw9qkEm7iCo/5tQwVrK',NULL,NULL,'pr977300.png','Native',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-25 10:22:26
