-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2024 at 01:19 PM
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
-- Database: `hostelwebsite`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `AdminID` int(11) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`AdminID`, `Username`, `Email`, `Password`) VALUES
(1, 'admin', 'admin@hostel.com', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `BookingStatus` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `HostelID` int(11) NOT NULL,
  `NumberOfOccupants` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `UserID`, `RoomID`, `CheckInDate`, `CheckOutDate`, `TotalPrice`, `BookingStatus`, `CreatedAt`, `HostelID`, `NumberOfOccupants`) VALUES
(1, 3, 6, '2024-12-01', '2024-12-31', 8450.00, 'Confirmed', '2024-12-01 12:43:57', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hostels`
--

CREATE TABLE `hostels` (
  `HostelID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  `AdminID` int(11) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `TotalRooms` int(11) DEFAULT 0,
  `AvailableRooms` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `hostels`
--

INSERT INTO `hostels` (`HostelID`, `Name`, `Address`, `City`, `Description`, `ContactNumber`, `AdminID`, `CreatedAt`, `TotalRooms`, `AvailableRooms`) VALUES
(1, 'Prasar Boys Hostel', 'New Baneshwor', 'Kathmandu', 'Good Hostel.', '9874545412', 1, '2024-11-29 07:08:57', 1, 1),
(6, 'Garud Boys Hostel', 'Koteswor', 'Kathmandu', 'kfjd', '9845451526', 1, '2024-11-29 08:26:50', 2, 3),
(7, 'Boys hostel', 'Old Baneshwor', 'Kathmandu', 'Great Hostel.', '9874545412', 1, '2024-11-29 10:13:01', 3, 3),
(8, 'New Boys Hostel', 'Bagbazar', 'Kathmandu', 'good', '9839938374', 1, '2024-11-30 14:01:02', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `hostel_images`
--

CREATE TABLE `hostel_images` (
  `ImageID` int(11) NOT NULL,
  `HostelID` int(11) NOT NULL,
  `ImagePath` varchar(255) NOT NULL,
  `IsPrimaryImage` tinyint(1) DEFAULT 0,
  `UploadedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `hostel_images`
--

INSERT INTO `hostel_images` (`ImageID`, `HostelID`, `ImagePath`, `IsPrimaryImage`, `UploadedAt`) VALUES
(1, 6, 'uploads/hostels/67497aca93815_Garud Boys Hostel.png', 1, '2024-11-29 08:26:50'),
(3, 7, 'uploads/hostels/674993ad417c8_prasar boys hostel.png', 0, '2024-11-29 10:13:01'),
(4, 1, 'uploads/hostels/6749d28e40999_prasar boys hostel.png', 1, '2024-11-29 14:41:18'),
(5, 1, 'uploads/hostels/674a99849b9eb_Garud Boys Hostel.png', 0, '2024-11-30 04:50:12'),
(6, 7, 'uploads/hostels/674a9b3cdb24e_Garud Boys Hostel.png', 1, '2024-11-30 04:57:32'),
(7, 8, 'uploads/hostels/674b1a9ed9c7d_image1.jpg', 1, '2024-11-30 14:01:02');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `ReviewID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `HostelID` int(11) NOT NULL,
  `Rating` int(11) DEFAULT NULL CHECK (`Rating` between 1 and 5),
  `ReviewText` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `RoomNumber` varchar(10) NOT NULL,
  `Floor` int(11) DEFAULT NULL,
  `HostelID` int(11) NOT NULL,
  `RoomType` enum('Single','Double','Dorm') NOT NULL,
  `PricePerMonth` decimal(10,2) NOT NULL,
  `AvailabilityStatus` enum('Available','Booked') DEFAULT 'Available',
  `MaxOccupancy` int(11) NOT NULL,
  `HasPrivateBathroom` tinyint(1) DEFAULT 0,
  `HasAirConditioning` tinyint(1) DEFAULT 0,
  `WindowView` enum('Street','Garden','Courtyard','No View') DEFAULT NULL,
  `SquareFootage` decimal(6,2) DEFAULT NULL,
  `FurnishingStatus` enum('Fully Furnished','Partially Furnished','Unfurnished') DEFAULT NULL,
  `AdditionalAmenities` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `RoomNumber`, `Floor`, `HostelID`, `RoomType`, `PricePerMonth`, `AvailabilityStatus`, `MaxOccupancy`, `HasPrivateBathroom`, `HasAirConditioning`, `WindowView`, `SquareFootage`, `FurnishingStatus`, `AdditionalAmenities`, `CreatedAt`) VALUES
(3, '101', 1, 6, 'Single', 4500.00, 'Available', 1, 1, 0, 'Street', 0.00, 'Partially Furnished', '', '2024-11-29 09:57:29'),
(6, '115', 1, 6, 'Double', 8450.00, 'Booked', 2, 0, 0, 'Street', 0.00, 'Fully Furnished', '', '2024-11-29 10:05:04'),
(7, '119', 1, 1, 'Single', 4500.00, 'Available', 1, 0, 0, 'Garden', 0.00, 'Fully Furnished', '', '2024-11-29 12:10:45'),
(13, '203', 1, 7, 'Single', 4500.00, 'Available', 1, 0, 0, 'Garden', 0.00, 'Partially Furnished', '', '2024-11-30 05:14:46'),
(14, '205', 1, 7, 'Single', 5500.00, 'Available', 1, 1, 0, 'Street', 0.00, 'Partially Furnished', '', '2024-11-30 05:15:06'),
(15, '304', 2, 7, 'Double', 6000.00, 'Available', 2, 0, 0, 'Garden', 0.00, 'Partially Furnished', '', '2024-11-30 05:15:28');

--
-- Triggers `rooms`
--
DELIMITER $$
CREATE TRIGGER `update_available_rooms_after_booking` AFTER UPDATE ON `rooms` FOR EACH ROW BEGIN
    IF OLD.AvailabilityStatus = 'Available' AND NEW.AvailabilityStatus = 'Booked' THEN
        UPDATE hostels 
        SET AvailableRooms = AvailableRooms - 1
        WHERE HostelID = NEW.HostelID;
    ELSEIF OLD.AvailabilityStatus = 'Booked' AND NEW.AvailabilityStatus = 'Available' THEN
        UPDATE hostels 
        SET AvailableRooms = AvailableRooms + 1
        WHERE HostelID = NEW.HostelID;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_rooms_after_delete` AFTER DELETE ON `rooms` FOR EACH ROW BEGIN
    UPDATE hostels 
    SET TotalRooms = TotalRooms - 1,
        AvailableRooms = AvailableRooms - 1
    WHERE HostelID = OLD.HostelID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_rooms_after_insert` AFTER INSERT ON `rooms` FOR EACH ROW BEGIN
    UPDATE hostels 
    SET TotalRooms = TotalRooms + 1,
        AvailableRooms = AvailableRooms + 1
    WHERE HostelID = NEW.HostelID;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `PasswordHash`, `FullName`, `Email`, `PhoneNumber`, `CreatedAt`) VALUES
(2, 'testuser', '$2y$10$zLII9v6wPouEXGuqZ3rGFuAoHHL0JEBWvodXamuH8yOwd1qy1IRvq', 'Test User', 'testuser@gmail.com', '9800000000', '2024-11-28 11:44:10'),
(3, 'johndoe', '$2y$10$PmFs/A4lIgN45GlNwoH6XOodeilYD4oFGMf7hRQXx0j5aF56rbr6W', 'John Doe', 'johndoe@gmail.com', '9837443377', '2024-11-30 15:35:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`AdminID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `bookings_hostel_fk` (`HostelID`);

--
-- Indexes for table `hostels`
--
ALTER TABLE `hostels`
  ADD PRIMARY KEY (`HostelID`),
  ADD KEY `hostels_ibfk_1` (`AdminID`);

--
-- Indexes for table `hostel_images`
--
ALTER TABLE `hostel_images`
  ADD PRIMARY KEY (`ImageID`),
  ADD KEY `HostelID` (`HostelID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`ReviewID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `HostelID` (`HostelID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`RoomID`),
  ADD UNIQUE KEY `UniqueRoomNumber` (`HostelID`,`RoomNumber`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hostels`
--
ALTER TABLE `hostels`
  MODIFY `HostelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hostel_images`
--
ALTER TABLE `hostel_images`
  MODIFY `ImageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_hostel_fk` FOREIGN KEY (`HostelID`) REFERENCES `hostels` (`HostelID`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`) ON DELETE CASCADE;

--
-- Constraints for table `hostels`
--
ALTER TABLE `hostels`
  ADD CONSTRAINT `hostels_ibfk_1` FOREIGN KEY (`AdminID`) REFERENCES `admins` (`AdminID`) ON DELETE SET NULL;

--
-- Constraints for table `hostel_images`
--
ALTER TABLE `hostel_images`
  ADD CONSTRAINT `hostel_images_ibfk_1` FOREIGN KEY (`HostelID`) REFERENCES `hostels` (`HostelID`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`HostelID`) REFERENCES `hostels` (`HostelID`) ON DELETE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`HostelID`) REFERENCES `hostels` (`HostelID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
