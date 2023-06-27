-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2023 at 03:13 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hmdbms_sample`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `pid` int(11) NOT NULL,
  `date` date NOT NULL,
  `Medicine_Name` varchar(20) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `totalprice` int(11) NOT NULL,
  `paymentstatus` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`pid`, `date`, `Medicine_Name`, `price`, `quantity`, `totalprice`, `paymentstatus`) VALUES
(4, '2023-02-27', 'Dolo', 100, 2, 200, 'Yes'),
(4, '2023-02-27', 'Low-dose Aspirin', 400, 1, 400, 'No'),
(7, '2023-03-22', 'Dolo', 50, 1, 50, 'No'),
(9, '2023-03-05', 'censpram', 100, 1, 100, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `cashier`
--

CREATE TABLE `cashier` (
  `cid` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cashier`
--

INSERT INTO `cashier` (`cid`, `firstname`, `midname`, `lastname`, `email`) VALUES
(6, 'Akshay', 'S', 'S', 'akshayss@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `did` int(11) NOT NULL,
  `doctorfirstname` varchar(50) NOT NULL,
  `doctormidname` varchar(50) DEFAULT NULL,
  `doctorlastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `dept` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`did`, `doctorfirstname`, `doctormidname`, `doctorlastname`, `email`, `dept`) VALUES
(1, 'Adarsh', 'S', 'Patil', 'adarshsp@gmail.com', 'Cardiologist'),
(8, 'Ananth', 'S', 'Hegde', 'ananthshegde@gmail.com', 'Neurologist'),
(2, 'Gopi', 'Anand', 'Bhat', 'gopiab@gmail.com', 'Dermatologist'),
(3, 'Mohan', 'H', 'Bongale', 'mohanhb@gmail.com', 'Physician');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `nid` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`nid`, `firstname`, `midname`, `lastname`, `email`) VALUES
(5, 'Usha', 'p', 'K', 'ushapk@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `pid` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`pid`, `firstname`, `midname`, `lastname`, `email`) VALUES
(4, 'Sainath', 'Somappa', 'Yalavigi', 'sainathsy.cs20@rvce.edu.in'),
(9, 'Someshwar', 'S', 'M', 'someshwarsm.cs20@rvce.edu.in'),
(7, 'Samarth', 'S', 'S', 'ss.cs20@rvce.edu.in'),
(10, 'S', 'S', 'Y', 'ssy@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `date` date NOT NULL,
  `did` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `disease` varchar(50) NOT NULL,
  `slot` varchar(20) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`pid`, `date`, `did`, `firstname`, `midname`, `lastname`, `disease`, `slot`, `gender`, `email`) VALUES
(4, '2023-02-28', 3, 'Sainath', 'Somappa', 'Yalavigi', 'fever', 'morning', 'Male', 'sainathsy.cs20@rvce.edu.in'),
(4, '2023-03-06', 3, 'Sainath', 'Somappa', 'Yalavigi', 'fever', 'morning', 'Male', 'sainathsy.cs20@rvce.edu.in'),
(4, '2023-03-21', 3, 'Sainath', 'Somappa', 'Yalavigi', 'fever', 'evening', 'Male', 'sainathsy.cs20@rvce.edu.in'),
(4, '2023-03-22', 3, 'Sainath', 'Somappa', 'Yalavigi', 'fever', 'evening', 'Male', 'sainathsy.cs20@rvce.edu.in'),
(7, '2023-02-28', 3, 'Samarth', 'S', 'S', 'fever', 'morning', 'Male', 'ss.cs20@rvce.edu.in'),
(7, '2023-03-06', 3, 'Samarth', 'S', 'S', 'fever', 'morning', 'Male', 'ss.cs20@rvce.edu.in'),
(7, '2023-03-22', 3, 'Samarth', 'S', 'S', 'fever', 'evening', 'Male', 'ss.cs20@rvce.edu.in'),
(9, '2023-03-05', 8, 'Someshwar', 'S', 'M', 'Brain', 'morning', 'Male', 'someshwarsm.cs20@rvce.edu.in'),
(10, '2023-03-22', 3, 'S', 'S', 'Y', 'fever', 'evening', 'Male', 'ssy@gmail.com');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `PatientDelete` BEFORE DELETE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.email,OLD.firstname,OLD.midname,OLD.lastname,'PATIENT DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `PatientUpdate` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.firstname,NEW.midname,NEW.lastname,'PATIENT UPDATED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.firstname,NEW.midname,NEW.lastname,'PATIENT INSERTED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `presc`
--

CREATE TABLE `presc` (
  `did` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `Medicine_Name` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `dosage` varchar(20) NOT NULL,
  `number_of_days` int(3) NOT NULL,
  `Note_to_patient` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `presc`
--

INSERT INTO `presc` (`did`, `pid`, `Medicine_Name`, `date`, `dosage`, `number_of_days`, `Note_to_patient`) VALUES
(1, 4, 'Low-dose Aspirin', '2023-02-13', '100', 1, 'Suffering from CHD'),
(3, 4, 'Dolo', '2023-02-13', '101', 3, 'Suffering from mild '),
(3, 4, 'Dolo', '2023-02-14', '101', 2, 'Suffering from fever'),
(3, 7, 'Dolo', '2023-03-22', '101', 7, 'Suffering from fever'),
(8, 9, 'censpram', '2023-03-05', '001', 7, 'Suffering from acute brain disease.');

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `pid`, `email`, `firstname`, `midname`, `lastname`, `action`, `timestamp`) VALUES
(1, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-02-13 19:48:06'),
(2, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-02-13 20:02:52'),
(3, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-02-14 10:04:12'),
(4, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-02-25 23:57:41'),
(5, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-02-28 00:31:23'),
(6, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT INSERTED', '2023-02-28 00:56:28'),
(7, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT DELETED', '2023-02-28 00:58:08'),
(8, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT INSERTED', '2023-02-28 00:58:36'),
(9, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT DELETED', '2023-02-28 01:05:49'),
(10, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT INSERTED', '2023-02-28 01:07:43'),
(11, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-03-05 19:10:15'),
(12, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT DELETED', '2023-03-05 19:13:43'),
(13, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT DELETED', '2023-03-05 19:13:53'),
(14, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT DELETED', '2023-03-05 19:13:59'),
(15, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT DELETED', '2023-03-05 19:14:03'),
(16, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT INSERTED', '2023-03-05 19:15:35'),
(17, 9, 'someshwarsm.cs20@rvce.edu.in', 'Someshwar', 'S', 'M', 'PATIENT INSERTED', '2023-03-05 19:28:34'),
(18, 9, 'someshwarsm.cs20@rvce.edu.in', 'Someshwar', 'S', 'M', 'PATIENT DELETED', '2023-03-05 19:32:41'),
(19, 9, 'someshwarsm.cs20@rvce.edu.in', 'Someshwar', 'S', 'M', 'PATIENT INSERTED', '2023-03-05 19:33:13'),
(20, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-03-21 19:29:04'),
(21, 4, 'sainathsy.cs20@rvce.edu.in', 'Sainath', 'Somappa', 'Yalavigi', 'PATIENT INSERTED', '2023-03-22 18:50:17'),
(22, 10, 'ssy@gmail.com', 'S', 'S', 'Y', 'PATIENT INSERTED', '2023-03-22 19:30:28'),
(23, 7, 'ss.cs20@rvce.edu.in', 'Samarth', 'S', 'S', 'PATIENT INSERTED', '2023-03-22 19:38:19');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `midname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `usertype` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `firstname`, `midname`, `lastname`, `email`, `usertype`, `password`) VALUES
(1, 'Adarsh', 'S', 'Patil', 'adarshsp@gmail.com', 'Doctor', 'pbkdf2:sha256:260000$WGSWQxMRKdBuXeGD$92172dc5994d91f3372bfebb45dbe6baa9f09a91c3bf7d827982c6075a4b10db'),
(2, 'Gopi', 'Anand', 'Bhat', 'gopiab@gmail.com', 'Doctor', 'pbkdf2:sha256:260000$vuEEFQNfbRVMsECP$6d7378d94e4b187131d2fbbf87cd061f27b1eab7f833c6da5d0eeaf132099ed0'),
(3, 'Mohan', 'H', 'Bongale', 'mohanhb@gmail.com', 'Doctor', 'pbkdf2:sha256:260000$SzZ7nXE14oNJYMSY$11236828bcf943036d383fdcd165ceaf7eee9faa3394e57723087ac78382a550'),
(4, 'Sainath', 'Somappa', 'Yalavigi', 'sainathsy.cs20@rvce.edu.in', 'Patient', 'pbkdf2:sha256:260000$l6qfnHyoKHTHUzNM$16c0d54cf67ca541133214fee86672fc2683b114d9c81d1d4e8aa759a1dfe4c7'),
(5, 'Usha', 'p', 'K', 'ushapk@gmail.com', 'Nurse', 'pbkdf2:sha256:260000$2y8s6a0XMQRN8Dw5$f22f396fd7eb00ef10c91e32106e35bc88395b6304d4963a1cf9ef2480005be7'),
(6, 'Akshay', 'S', 'S', 'akshayss@gmail.com', 'Cashier', 'pbkdf2:sha256:260000$SOrYgDv583RQFGvN$e77ce33c29cefe22b7408b71b058164eb29e76c85cd9edd8e8dd3f6a6292c343'),
(7, 'Samarth', 'S', 'S', 'ss.cs20@rvce.edu.in', 'Patient', 'pbkdf2:sha256:260000$Q0p4lL7o30VlycRs$22fd0c0f57b75b3e3fd7d72af44f38733e3bc29e73e3f56fa32b652456251d31'),
(8, 'Ananth ', 'S', 'Hegde', 'ananthshegde@gmail.com', 'Doctor', 'pbkdf2:sha256:260000$dByLSW8CqDDW7Syu$eb7ecc5a976466004782fe95b6df111906397338643c222808a487f64604fcbe'),
(9, 'Someshwar', 'S', 'M', 'someshwarsm.cs20@rvce.edu.in', 'Patient', 'pbkdf2:sha256:260000$8sRNStSKq9qTWaOc$92dfadecf44fb1418d32f874b54d99e028b78fefdec9d87376c9ca178038921d'),
(10, 'S', 'S', 'Y', 'ssy@gmail.com', 'Patient', 'pbkdf2:sha256:150000$UYnRKC46$251e07d524da2127464a10724baa360e41ba6457bb6d115ee6d9cd4e96c135a5');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`pid`,`date`,`Medicine_Name`);

--
-- Indexes for table `cashier`
--
ALTER TABLE `cashier`
  ADD PRIMARY KEY (`email`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `did` (`did`) USING BTREE;

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`email`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `pid` (`pid`) USING BTREE;

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`,`date`,`slot`),
  ADD KEY `did` (`did`);

--
-- Indexes for table `presc`
--
ALTER TABLE `presc`
  ADD PRIMARY KEY (`did`,`pid`,`Medicine_Name`,`date`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `billing`
--
ALTER TABLE `billing`
  ADD CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `user` (`id`);

--
-- Constraints for table `cashier`
--
ALTER TABLE `cashier`
  ADD CONSTRAINT `cashier_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `user` (`id`);

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`did`) REFERENCES `user` (`id`);

--
-- Constraints for table `nurse`
--
ALTER TABLE `nurse`
  ADD CONSTRAINT `nurse_ibfk_1` FOREIGN KEY (`nid`) REFERENCES `user` (`id`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `user` (`id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`did`) REFERENCES `user` (`id`);

--
-- Constraints for table `presc`
--
ALTER TABLE `presc`
  ADD CONSTRAINT `presc_ibfk_1` FOREIGN KEY (`did`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `presc_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `user` (`id`);

--
-- Constraints for table `trigr`
--
ALTER TABLE `trigr`
  ADD CONSTRAINT `trigr_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
