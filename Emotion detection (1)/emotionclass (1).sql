-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2025 at 05:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emotionclass`
--

-- --------------------------------------------------------

--
-- Table structure for table `eusers`
--

CREATE TABLE `eusers` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eusers`
--

INSERT INTO `eusers` (`id`, `username`, `email`, `mobile`, `password`) VALUES
(1, 'test101', 'test101@gmail.com', '1234567890', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `predictions`
--

CREATE TABLE `predictions` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `emotion` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `predictions`
--

INSERT INTO `predictions` (`id`, `username`, `text`, `emotion`, `timestamp`) VALUES
(1, 'test101', 'im not happy', 'joy', '2025-03-26 15:42:41'),
(2, 'test101', 'im not happy', 'joy', '2025-03-26 16:01:06'),
(3, 'test101', 'im not happy', 'joy', '2025-03-26 16:13:59'),
(4, 'test101', 'I\'m not happy', 'joy', '2025-03-26 16:17:07'),
(5, 'test101', 'I\'m not happy.', 'joy', '2025-03-26 16:17:27'),
(6, 'test101', 'I am happy', 'joy', '2025-03-26 16:17:32'),
(7, 'test101', 'I\'m not happy.', 'joy', '2025-03-26 16:17:37'),
(8, 'test101', 'I\'m not happy.', 'sadness', '2025-03-26 16:20:06'),
(9, 'test101', 'I\'m not happy.', 'sadness', '2025-03-26 16:20:06'),
(10, 'test101', 'in the bathroom', 'neutral', '2025-03-26 16:22:30'),
(11, 'test101', 'Im not bad', 'Unknown emotion', '2025-03-26 16:22:40'),
(12, 'test101', 'bad', 'anger', '2025-03-26 16:23:31'),
(13, 'test101', 'in the bathroom', 'neutral', '2025-03-26 16:23:42'),
(14, 'test101', 'I\'m Bad', 'anger', '2025-03-26 16:23:49'),
(15, 'test101', 'im not bad', 'Unknown emotion', '2025-03-26 16:33:55'),
(16, 'test101', 'im not bad', 'delight', '2025-03-26 16:36:31'),
(17, 'test101', 'I\'m bad boy but in good way', 'sadness', '2025-03-26 16:37:06'),
(18, 'test101', 'helpless', 'disappointment', '2025-03-26 16:37:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eusers`
--
ALTER TABLE `eusers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `predictions`
--
ALTER TABLE `predictions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `eusers`
--
ALTER TABLE `eusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `predictions`
--
ALTER TABLE `predictions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
