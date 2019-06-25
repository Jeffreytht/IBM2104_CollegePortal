-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2019 at 04:14 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `college_portal`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AuthenticateUser` (IN `username` VARCHAR(30))  BEGIN
		SELECT user_name, pwd 
        FROM `users` 
        WHERE user_name = username ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteInstituteByID` (IN `InstituteID` BIGINT)  BEGIN
		CREATE TEMPORARY TABLE ConstraintID
        (
        	id INT
        );
        
        INSERT INTO ConstraintID(id)
		SELECT image_id FROM `gallery_news` WHERE news_id IN(SELECT news_id FROM `news` WHERE institute_id = InstituteID);
        
        DELETE FROM `gallery_news` WHERE news_id IN(SELECT news_id FROM `news` WHERE institute_id = InstituteID);
        DELETE FROM `news` WHERE institute_id = InstituteID;
        DELETE FROM `institute_course` WHERE institute_id = InstituteID;
        
        INSERT INTO ConstraintID(id)
		SELECT image_id FROM `profile_pic` WHERE institute_id = InstituteID;
        
        DELETE FROM `profile_pic` WHERE institute_id = InstituteID;
       	
        INSERT INTO ConstraintID(id)
        SELECT `image_id` FROM cover_photo WHERE institute_id = InstituteID;
          
        DELETE FROM `cover_photo` WHERE institute_id = InstituteID;
		
        INSERT INTO ConstraintID(id)
        SELECT `image_id` FROM institute_logo WHERE institute_id = InstituteID;
        
        DELETE FROM institute_logo WHERE institute_id = InstituteID;
        DELETE FROM `institute_user` WHERE institute_id = InstituteID;
        DELETE FROM `gallery` WHERE image_id IN (SELECT id FROM ConstraintID );
        DELETE FROM `institute` WHERE institute_id = InstituteID;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `userID` INT(6))  BEGIN
       		DELETE FROM `user_role` WHERE user_id = userID;
            DELETE FROM `rate` WHERE user_id = userID;
			DELETE FROM `users` WHERE user_id = userID;
		END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertGalleryNews` (IN `imagePath` TEXT, IN `newsID` BIGINT)  BEGIN
        	INSERT INTO `gallery` (image_path)
					VALUES(imagePath);
                    
            SET @imageID = (SELECT image_id FROM `gallery` WHERE image_path = imagePath);
            
            INSERT INTO `gallery_news`VALUES(@imageID, newsID);
            
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertInstitute` (IN `name` TEXT, IN `addresses` TEXT, IN `url` TEXT, IN `stateId` INT(6))  BEGIN
       
        INSERT INTO `institute`(institute_name, address,address_url,state_id)
        VALUES(name, addresses, url, stateId);
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser` (IN `username` VARCHAR(30), IN `email` VARCHAR(50), IN `pass` VARCHAR(20), IN `dob` DATE)  BEGIN
 		INSERT INTO users(user_name, email, pwd, dob)
        VALUES(username, email, pass, dob);
        INSERT INTO user_role
        SELECT u.user_id, r.role_id 
        FROM users u, role r 
        WHERE u.user_name = username && r.role_id = 3;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllUserDetailsByUsername` (IN `username` VARCHAR(50))  BEGIN
	SET @userID =(
        SELECT user_id
        FROM `users`
        WHERE user_name = username);

	SET @roleID = (
        SELECT role_id 
        FROM `user_role`
        WHERE user_id = @userID);
        
	SET @roleName = (
        SELECT role_name 
        FROM `role` 
        WHERE role_id = @roleID);

	SELECT u.* , ur.role_id, r.role_name
	FROM `user_role` ur, `users` u, `role` r
	WHERE u.user_id = @userID 
	&& ur.user_id = @userID
	&& r.role_name = @roleName ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectCourseByInstituteID` (IN `instituteID` BIGINT)  BEGIN
    	SELECT ic.course_id, c.course_name, ic.fee, ic.duration
        FROM `institute_course` ic, `course` c
        WHERE ic.institute_id = instituteID && c.course_id = ic.course_id;
        
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectImageIDByNewsID` (IN `newsID` BIGINT)  BEGIN
        	SELECT image_id FROM gallery_news WHERE news_id = newsID;
            
		END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectInstituteCourse` (IN `instituteID` INT(10))  BEGIN
		SELECT c.*, ic.fee, ic.duration
        FROM institute_course ic, course c
        WHERE ic.institute_id = instituteID && ic.course_id = c.course_id;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectInstituteDetails` (IN `instituteID` INT(10))  BEGIN 
	SET @userID = (SELECT user_id FROM `institute_user` WHERE institute_id = instituteID);
	SELECT i.*, s.state_name, s.state_url, u.user_name, u.user_id
    FROM `institute` i, `state`s, `users` u
    WHERE i.institute_id = instituteID && s.state_id = i.state_id && u.user_id = @userID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectNewsByInstituteID` (IN `instituteID` BIGINT)  BEGIN
    	SELECT * FROM `news` WHERE institute_id = instituteID;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectUser` (IN `col_name` VARCHAR(50), IN `requirement` VARCHAR(50))  BEGIN 
    CASE col_name 
    	WHEN 'user_name' THEN SELECT user_name FROM Users WHERE user_name = requirement;
       	WHEN 'email' THEN SELECT email FROM Users WHERE email = requirement;
        END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectUserInstitute` (IN `userID` INT(6))  BEGIN
        	SET @instituteID = (SELECT institute_id FROM `institute_user` WHERE user_id = userID);
            CALL SelectInstituteDetails(@instituteID);
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser` (IN `userID` INT(6), IN `userDOB` DATE, IN `userPwd` VARCHAR(30))  BEGIN
    	UPDATE users
        SET dob = userDOB, pwd = userPwd
        WHERE userID = user_id;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` int(6) UNSIGNED NOT NULL,
  `course_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_name`) VALUES
(1, 'Accounting'),
(2, 'Agricultural Science'),
(3, 'Aquaculture'),
(4, 'Architecture'),
(5, 'Animation'),
(6, 'Aerospace'),
(7, 'Aircraft Maintenance'),
(8, 'Automotive Engineering'),
(9, 'Anthropology'),
(10, 'Actuarial Science'),
(11, 'Advertising'),
(12, 'Animal Science'),
(13, 'Audiology'),
(14, 'ACCA'),
(15, 'A-Levels'),
(16, 'American Degree Programme'),
(17, 'Banking'),
(18, 'Biomedical Science'),
(19, 'Business Administration'),
(20, 'Biomedical Engineering'),
(21, 'Biology'),
(22, 'Commerce'),
(23, 'Computer Engineering'),
(24, 'Computer Science'),
(25, 'Chemical Engineering'),
(26, 'Civil Engineering'),
(27, 'Culinary Arts'),
(28, 'Communications'),
(29, 'Counselling'),
(30, 'Chemistry'),
(31, 'College Foundations'),
(32, 'Canandian Pre-University'),
(33, 'Chemical Engineering with Oil and Gas'),
(34, 'Construction project management'),
(35, 'Design'),
(36, 'Dentistry'),
(37, 'Drama, Theatre & Film'),
(38, 'Economics'),
(39, 'Early Childhood Education'),
(40, 'Electrical Engineering'),
(41, 'Environmental Engineering'),
(42, 'Environmental Health'),
(43, 'Environmental Science'),
(44, 'Events Management'),
(45, 'Engineering Technology'),
(46, 'Food Technology'),
(47, 'Forensic Science'),
(48, 'Fashion Design'),
(49, 'Food Science'),
(50, 'Finance Management'),
(51, 'Game Design'),
(52, 'Graphic Design'),
(53, 'Geology'),
(54, 'Human Resource Management'),
(55, 'Hospitality Management'),
(56, 'History'),
(57, 'Interior Design'),
(58, 'Information System'),
(59, 'Industrial and Manufacturing Engineering'),
(60, 'Islamic Finance'),
(61, 'Industrial Electronics'),
(62, 'ICAEW'),
(63, 'Jurisprudence'),
(64, 'Journalism Broadcasting'),
(65, 'Language Studies'),
(66, 'Law'),
(67, 'Medical Laboratory Technology'),
(68, 'Multimedia'),
(69, 'Marketing'),
(70, 'Mechanical Engineering'),
(71, 'Marine Biology'),
(72, 'Marine Engineering'),
(73, 'Marine Science'),
(74, 'Mathematics'),
(75, 'Medicine'),
(76, 'Music'),
(77, 'Mechatronic Engineering'),
(78, 'Nursing'),
(79, 'Nutrition and Dietetics'),
(80, 'Nanotechnology'),
(81, 'Optometry'),
(82, 'Physiotherapy'),
(83, 'Piloting'),
(84, 'Petroleum Engineering'),
(85, 'Political Science'),
(86, 'Public Relations'),
(87, 'Pharmacy'),
(88, 'Psychology'),
(89, 'Physics'),
(90, 'Port Management'),
(91, 'Patisserie & Gastronomic Cuisine'),
(92, 'Quantity Surveying'),
(93, 'Radiography and Medical Imaging'),
(94, 'Religious Studies'),
(95, 'Sports Science'),
(96, 'Sociology'),
(97, 'Shipping Management'),
(98, 'South Australian Matriculation / SACE International'),
(99, 'Traditional Finance'),
(100, 'TESOL & TESL'),
(101, 'Traditional Medicine'),
(102, 'Tourism Management'),
(103, 'Urban and Regional Planning'),
(104, 'Veterinary Medicine');

-- --------------------------------------------------------

--
-- Table structure for table `cover_photo`
--

CREATE TABLE `cover_photo` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `image_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cover_photo`
--

INSERT INTO `cover_photo` (`institute_id`, `image_id`) VALUES
(3, 33),
(2, 42);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`image_id`, `image_path`) VALUES
(31, 'Images/Profile/31.png'),
(32, 'Images/Logo/32.png'),
(33, 'Images/Cover/33.jpg'),
(40, 'images/InstituteDetail/36.jpg'),
(41, 'Images/Profile/41.jpg'),
(42, 'Images/cover/42.jpg'),
(43, 'Images/Logo/43.png'),
(44, 'images/InstituteDetail/34.jpg'),
(45, 'images/InstituteDetail/35.jpg'),
(51, 'images/InstituteDetail/46.jpg'),
(53, 'images/InstituteDetail/52.jpg'),
(54, 'images/InstituteDetail/54.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_news`
--

CREATE TABLE `gallery_news` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `news_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gallery_news`
--

INSERT INTO `gallery_news` (`image_id`, `news_id`) VALUES
(40, 13),
(44, 14),
(45, 15),
(51, 23),
(53, 26),
(54, 27);

-- --------------------------------------------------------

--
-- Table structure for table `institute`
--

CREATE TABLE `institute` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `institute_name` text NOT NULL,
  `address` text NOT NULL,
  `address_url` text NOT NULL,
  `iframe_url` text NOT NULL,
  `state_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `institute`
--

INSERT INTO `institute` (`institute_id`, `institute_name`, `address`, `address_url`, `iframe_url`, `state_id`) VALUES
(2, 'INTI College Penang', '1-Z, Lebuh Bukit Jambul, Bukit Jambul, 11900 Bayan Lepas, Pulau Pinang', 'https://goo.gl/maps/cx43bBcQaQkNP5PL6', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3972.491988724782!2d100.27968201549743!3d5.34160379612528!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac048a161f277%3A0x881c46d428b3162c!2sINTI+International+College+Penang!5e0!3m2!1sen!2smy!4v1560696521934!5m2!1sen!2smy', 7),
(3, 'SEGI College Penang', 'Wisma Greenhall, 43, Jalan Green Hall, 10200 George Town, Pulau Pinang', 'https://goo.gl/maps/q5PC11fzU4WdaTU57', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3971.9615395055894!2d100.3374739147654!3d5.422814696067055!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac3853c19eabd%3A0xf18e216f6994764b!2sSEGi+College+Penang!5e0!3m2!1sen!2smy!4v1560873244562!5m2!1sen!2smy', 7);

-- --------------------------------------------------------

--
-- Table structure for table `institute_course`
--

CREATE TABLE `institute_course` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(6) UNSIGNED NOT NULL,
  `fee` double NOT NULL,
  `duration` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `institute_course`
--

INSERT INTO `institute_course` (`institute_id`, `course_id`, `fee`, `duration`) VALUES
(3, 1, 25000, 3),
(3, 2, 25000, 3),
(3, 21, 55000, 2),
(3, 31, 15000, 2),
(3, 41, 23000, 2),
(3, 51, 28000, 3),
(3, 61, 43000, 2),
(3, 71, 76000, 3),
(3, 81, 25000, 2),
(3, 91, 22000, 3),
(3, 1, 55000, 2),
(3, 22, 50000, 4),
(3, 25, 35000, 2),
(3, 31, 25000, 2),
(3, 35, 15000, 3),
(3, 53, 88000, 3),
(3, 55, 58000, 3),
(3, 67, 28000, 3),
(3, 79, 16000, 2),
(3, 80, 35000, 2),
(2, 1, 55000, 2),
(2, 12, 55000, 4),
(2, 22, 50000, 4),
(2, 31, 25000, 2),
(2, 35, 15000, 3),
(2, 53, 88000, 3),
(2, 55, 58000, 3),
(2, 67, 28000, 3),
(2, 79, 16000, 2),
(2, 80, 35000, 2),
(2, 82, 45000, 2),
(2, 17, 40000, 3),
(2, 85, 20000, 4),
(2, 74, 30000, 4);

-- --------------------------------------------------------

--
-- Table structure for table `institute_logo`
--

CREATE TABLE `institute_logo` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `image_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `institute_logo`
--

INSERT INTO `institute_logo` (`institute_id`, `image_id`) VALUES
(3, 32),
(2, 43);

-- --------------------------------------------------------

--
-- Table structure for table `institute_user`
--

CREATE TABLE `institute_user` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `institute_user`
--

INSERT INTO `institute_user` (`institute_id`, `user_id`) VALUES
(3, 13),
(2, 12);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `news_id` bigint(20) UNSIGNED NOT NULL,
  `content` text,
  `news_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `institute_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`news_id`, `content`, `news_date`, `institute_id`) VALUES
(13, 'SEGi College Penang (SCPG) SAG Roadshow', '2019-06-21 07:55:52', 3),
(14, 'Let INTI ligthen your future', '2019-06-18 01:31:50', 2),
(15, 'Physical (In)Activity in IR 4.0', '2019-06-20 08:57:32', 2),
(19, 'INTI the best', '2019-06-24 05:17:00', 2),
(20, 'Good Afternoon', '2019-06-24 05:44:24', 3),
(21, 'Hi have a nice day\r\n', '2019-06-24 05:48:55', 3),
(22, 'Hello Guys', '2019-06-24 05:49:39', 3),
(23, 'Tutorial\r\n', '2019-06-24 06:04:33', 3),
(24, 'Good evening \r\n', '2019-06-24 06:04:57', 3),
(25, 'Happy holiday', '2019-06-24 06:15:35', 3),
(26, 'Our campaign\r\n', '2019-06-24 06:22:17', 3),
(27, 'ryguyryg', '2019-06-24 07:05:15', 3),
(28, '', '2019-06-24 07:05:26', 3);

-- --------------------------------------------------------

--
-- Table structure for table `profile_pic`
--

CREATE TABLE `profile_pic` (
  `institute_id` int(10) UNSIGNED NOT NULL,
  `image_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profile_pic`
--

INSERT INTO `profile_pic` (`institute_id`, `image_id`) VALUES
(3, 31),
(2, 41);

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `user_id` int(6) UNSIGNED NOT NULL,
  `institute_id` int(6) UNSIGNED NOT NULL,
  `rating` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`user_id`, `institute_id`, `rating`) VALUES
(12, 2, 1),
(12, 3, 2),
(13, 3, 5),
(13, 2, 5),
(14, 2, 5),
(14, 3, 5),
(11, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(6) UNSIGNED NOT NULL,
  `role_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`) VALUES
(1, 'Super Admin'),
(2, 'Admin'),
(3, 'User');

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `state_id` int(6) UNSIGNED NOT NULL,
  `state_name` varchar(30) NOT NULL,
  `state_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`, `state_url`) VALUES
(1, 'Johor', 'https://goo.gl/maps/VS6sW6AwcNJmRnQU8'),
(2, 'Kedah', 'https://goo.gl/maps/HbAn65f81FeXT8YUA'),
(3, 'Kelantan', 'https://goo.gl/maps/CL4xja36eVUgWeeB7'),
(4, 'Malacca', 'https://goo.gl/maps/qFuRkekUBxazvPA3A'),
(5, 'Negeri Sembilan', 'https://goo.gl/maps/UvDwpcJPhgsjLjHA8'),
(6, 'Pahang', 'https://goo.gl/maps/rPvj695RgVQZueTL6'),
(7, 'Penang', 'https://goo.gl/maps/8Jrbddewr5CtgeVC6'),
(8, 'Perak', 'https://goo.gl/maps/nPk9DogrP2bhPqvu5'),
(9, 'Perlis', 'https://goo.gl/maps/Z6sqVV1jy2tDiQu39'),
(10, 'Sabah', 'https://goo.gl/maps/sAhAoRsRmo7PtN5D6'),
(11, 'Sarawak', 'https://goo.gl/maps/qN6buhqcDjkJDp6Q6'),
(12, 'Selangor', 'https://goo.gl/maps/fWce9uhN1Ps12iJw9'),
(13, 'Terengganu', 'https://goo.gl/maps/BWFrMrMzdMHDq7pk9');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(6) UNSIGNED NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pwd` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `recent_changes` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `email`, `pwd`, `dob`, `recent_changes`) VALUES
(11, 'jeffreytan', 'tanhoetheng@gmail.com', '12345abcde', '2000-04-12', '2019-06-16 06:48:13'),
(12, 'laukuansin', 'laukuansin@gmail.com', '12345abcde', '2000-03-18', '2019-06-25 14:07:41'),
(13, 'chuangjingyee', 'cjy@gmail.com', '12345abcde', '2000-04-15', '2019-06-20 07:44:43'),
(14, 'peyxinyee', 'pxy@gmail.com', '12345abcde', '1212-12-12', '2019-06-13 15:15:36'),
(15, 'leowjiehan', 'leowjiehan@gmail.com', '12345abcde', '2012-12-12', '2019-06-24 13:44:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(6) UNSIGNED NOT NULL,
  `role_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(11, 1),
(12, 2),
(14, 3),
(13, 2),
(15, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `cover_photo`
--
ALTER TABLE `cover_photo`
  ADD PRIMARY KEY (`institute_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `gallery_news`
--
ALTER TABLE `gallery_news`
  ADD KEY `image_id` (`image_id`),
  ADD KEY `news_id` (`news_id`);

--
-- Indexes for table `institute`
--
ALTER TABLE `institute`
  ADD PRIMARY KEY (`institute_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `institute_course`
--
ALTER TABLE `institute_course`
  ADD KEY `institute_id` (`institute_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `institute_logo`
--
ALTER TABLE `institute_logo`
  ADD PRIMARY KEY (`institute_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexes for table `institute_user`
--
ALTER TABLE `institute_user`
  ADD KEY `institute_id` (`institute_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `institute_id` (`institute_id`);

--
-- Indexes for table `profile_pic`
--
ALTER TABLE `profile_pic`
  ADD PRIMARY KEY (`institute_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexes for table `rate`
--
ALTER TABLE `rate`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `institute_id` (`institute_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `image_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `institute`
--
ALTER TABLE `institute`
  MODIFY `institute_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `news_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `state_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cover_photo`
--
ALTER TABLE `cover_photo`
  ADD CONSTRAINT `cover_photo_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`),
  ADD CONSTRAINT `cover_photo_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `gallery` (`image_id`);

--
-- Constraints for table `gallery_news`
--
ALTER TABLE `gallery_news`
  ADD CONSTRAINT `gallery_news_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `gallery` (`image_id`),
  ADD CONSTRAINT `gallery_news_ibfk_2` FOREIGN KEY (`news_id`) REFERENCES `news` (`news_id`);

--
-- Constraints for table `institute`
--
ALTER TABLE `institute`
  ADD CONSTRAINT `institute_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`);

--
-- Constraints for table `institute_course`
--
ALTER TABLE `institute_course`
  ADD CONSTRAINT `institute_course_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`),
  ADD CONSTRAINT `institute_course_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- Constraints for table `institute_logo`
--
ALTER TABLE `institute_logo`
  ADD CONSTRAINT `institute_logo_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`),
  ADD CONSTRAINT `institute_logo_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `gallery` (`image_id`);

--
-- Constraints for table `institute_user`
--
ALTER TABLE `institute_user`
  ADD CONSTRAINT `institute_user_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`),
  ADD CONSTRAINT `institute_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`);

--
-- Constraints for table `profile_pic`
--
ALTER TABLE `profile_pic`
  ADD CONSTRAINT `profile_pic_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`),
  ADD CONSTRAINT `profile_pic_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `gallery` (`image_id`);

--
-- Constraints for table `rate`
--
ALTER TABLE `rate`
  ADD CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `rate_ibfk_2` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`institute_id`);

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
