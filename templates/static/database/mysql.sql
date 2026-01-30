-- DATABASE SCHEMA FOR COE ASSISTANT
-- This file creates the database structure and inserts static college information.
-- No personal user data is included.

-- 1. Table: chat_history
DROP TABLE IF EXISTS `chat_history`;
CREATE TABLE `chat_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) DEFAULT NULL,
  `user_query` text,
  `bot_response` text,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Table: college_info (With Static Data)
DROP TABLE IF EXISTS `college_info`;
CREATE TABLE `college_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting College Info (Required for Chatbot Context)
LOCK TABLES `college_info` WRITE;
INSERT INTO `college_info` (category, content) VALUES 
('Institutional Name','Centre of Excellence, Government College Sanjauli, Shimla.'),
('Address','Sanjauli, Shimla, Himachal Pradesh, PIN - 171006.'),
('Contact Details','Phone: 0177-2640332 | Email: principalsanjauli@gmail.com.'),
('Official Website','www.gcsanjauli.edu.in.'),
('NAAC Accreditation','The college is accredited with an A+ Grade by NAAC (2023 Cycle).'),
('History','Established in 1869 as a school and converted into a degree college in 1969. It is one of the oldest and most prestigious institutions in Himachal Pradesh.'),
('Academic Programs','Offers Undergraduate courses in Arts (BA), Science (BSc), Commerce (BCom), Computer Applications (BCA), and Vocational studies (B.Voc).'),
('Campus Facilities','Equipped with a digitized library, modern science labs, IT labs, a multipurpose hall, and sports facilities.'),
('Student Strength','Over 3000+ students are currently enrolled across various disciplines.'),
('Scholarships','Provides various state and central government scholarships including Post-Matric and Merit-based schemes.'),
('Faculty','Staffed by over 50+ highly qualified professors and academic experts.'),
('Vision','To provide quality education that empowers students with knowledge and character for a better future.'),
('Mission','To foster an environment of learning and innovation that prepares students for global challenges.'),
('Location Info','Situated approximately 12 KM from the ISBT Shimla and easily accessible via local transport.');
UNLOCK TABLES;

-- 3. Table: users
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `roll` varchar(50) DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `attendance` varchar(50) DEFAULT '0',
  `internal_grade` varchar(20) DEFAULT 'N/A',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. Table: id_applications
DROP TABLE IF EXISTS `id_applications`;
CREATE TABLE `id_applications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `roll_no` varchar(50) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `academic_year` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `signature_path` varchar(255) DEFAULT NULL,
  `marksheet_path` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `unique_id` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  CONSTRAINT `id_applications_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. Table: results
DROP TABLE IF EXISTS `results`;
CREATE TABLE `results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `marks` int NOT NULL,
  `total_marks` int DEFAULT '100',
  `semester` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. Table: timetable
DROP TABLE IF EXISTS `timetable`;
CREATE TABLE `timetable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course` varchar(50) DEFAULT NULL,
  `year_sem` varchar(50) DEFAULT NULL,
  `time_slot` varchar(100) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `room_no` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting Timetable (Generic College Data - Safe to keep)
LOCK TABLES `timetable` WRITE;
INSERT INTO `timetable` (course, year_sem, time_slot, subject, room_no) VALUES 
('BCA','1st','12 TO 12:40','ENGLISH','12'),
('BCA','1st','3 TO 4','COMPUTER','13'),
('BCA','1st','10 to 10:40','sanskrit','25'),
('BA','1st','10 to 10:40','POLITICAL SCIENCE','23'),
('BA','2ND','10 to 10:40','ECONOMICS','20'),
('MCA','2ND','10 to 10:40','DIGITAL ELECTRONICS','BCA LAB');
UNLOCK TABLES;

-- 7. Table: import_history
DROP TABLE IF EXISTS `import_history`;
CREATE TABLE `import_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `total_records` int DEFAULT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_email` varchar(255) DEFAULT 'admin@coe.control',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;