-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2024 at 08:52 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digital_dynasty`
--
CREATE DATABASE IF NOT EXISTS `digital_dynasty` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `digital_dynasty`;

-- --------------------------------------------------------

--
-- Table structure for table `'order'`
--

CREATE TABLE `'order'` (
  `order_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `total_price` decimal(10,0) NOT NULL,
  `total_quantity` int(11) NOT NULL,
  `status` enum('pending','delivered') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `'order'`
--

INSERT INTO `'order'` (`order_id`, `address_id`, `cart_id`, `order_date`, `total_price`, `total_quantity`, `status`) VALUES
(53, 1, 10, '2024-05-09', '2129', 3, 'pending'),
(54, 1, 10, '2024-05-09', '1128', 3, 'pending'),
(55, 1, 11, '2024-05-09', '929', 2, 'pending'),
(56, 1, 12, '2024-05-09', '2129', 3, 'pending'),
(57, 1, 13, '2024-05-10', '2199', 2, 'pending'),
(58, 1, 13, '2024-05-10', '2448', 4, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_product_quantity` int(11) NOT NULL,
  `total_price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `total_product_quantity`, `total_price`) VALUES
(12, 25, 0, '0'),
(13, 26, 2, '2199');

-- --------------------------------------------------------

--
-- Table structure for table `cart_product`
--

CREATE TABLE `cart_product` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL,
  `product_total` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_product`
--

INSERT INTO `cart_product` (`cart_id`, `product_id`, `product_quantity`, `product_total`) VALUES
(13, 1, 1, '1399'),
(13, 2, 1, '800');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(20) NOT NULL,
  `category_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_description`) VALUES
(1, 'Laptop', 'This is a field for laptop.'),
(2, 'Desktop', 'This is a field for desktop.'),
(3, 'Accessories', 'This is a field for accessories. ');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_address`
--

CREATE TABLE `delivery_address` (
  `address_id` int(11) NOT NULL,
  `country` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `street_address` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_address`
--

INSERT INTO `delivery_address` (`address_id`, `country`, `province`, `city`, `street_address`) VALUES
(1, 'default', 'default', 'default', 'default'),
(2, 'Nepal', 'Gandaki', 'Gorkha', 'Haramtari'),
(3, 'Nepal', 'Bagmati', 'Bhaktapur', 'Petrol pump'),
(4, 'in', 'in', 'in', 'ni'),
(5, 'asfd', 'afsd', 'asf', 'asfd'),
(6, 'ads', 'asd', 'sad', 'sda'),
(7, 'afd', 'asf', 'afs', 'asd'),
(8, 'India', 'asd', 'ads', 'afs'),
(9, 'asf', 'afsd', 'fsa', 'fas'),
(10, 'afsd', 'adsf', 'adfs', 'dsa'),
(11, 'asfd', 'dsf', 'afd', 'asf'),
(12, 'afsd', 'asfd', 'asf', 'asdf'),
(13, 'ad', 'as', 'as', 'ads'),
(14, 'a', 'dasf', 'dasf', 'fas'),
(15, 'asd', 'dasf', 'asdf', 'asf'),
(16, 'asfd', 'asdf', 'asf', 'safdafds'),
(17, 'afs', 'asfd', 'sdfg', 'fsd'),
(18, 'afsd', 'saf', 'fds', 'afsd'),
(19, 'nepal', 'bagmati', 'bhaktapur', 'asf'),
(20, 'Nepal', 'Bagmati', 'Kathmandu', 'balaju height'),
(21, 'asfg', 'sfg', 'asf', 'asgf'),
(22, 'Nepal', 'Bagmati', 'Kantipur', 'Kamalpokhari');

-- --------------------------------------------------------

--
-- Table structure for table `ordered_product`
--

CREATE TABLE `ordered_product` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ordered_product`
--

INSERT INTO `ordered_product` (`order_id`, `product_id`, `quantity`, `total_price`) VALUES
(53, 1, 1, '1200'),
(53, 2, 1, '800'),
(53, 3, 1, '129'),
(54, 2, 1, '800'),
(54, 3, 1, '129'),
(54, 4, 1, '199'),
(55, 3, 1, '129'),
(55, 2, 1, '800'),
(56, 1, 1, '1200'),
(56, 2, 1, '800'),
(56, 3, 1, '129'),
(57, 1, 1, '1399'),
(57, 2, 1, '800'),
(58, 1, 1, '1399'),
(58, 2, 1, '800'),
(58, 3, 1, '129'),
(58, 5, 1, '120');

-- --------------------------------------------------------

--
-- Table structure for table `privileged_user`
--

CREATE TABLE `privileged_user` (
  `priviliged_user_id` int(11) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `contact_no` bigint(20) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` enum('admin','privileged') NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `privileged_user`
--

INSERT INTO `privileged_user` (`priviliged_user_id`, `first_name`, `last_name`, `contact_no`, `date_of_birth`, `gender`, `username`, `password`, `role`, `email`) VALUES
(1, 'admin', 'admin', 9876543210, '2000-05-01', 'Male', '@admin', 'ad1', 'admin', 'ed@scamdigitals.com'),
(2, 'Hari', 'Bahadur', 9876324560, '2004-03-24', 'Male', '@harry', 'h1', 'privileged', 'harry@scamdigitals.com'),
(3, 'Kamala ', 'Upreti', 9873456789, '2006-01-03', 'Female', '@kamala', 'k2', 'privileged', 'kamala@scamdigitals.com'),
(4, 'Samip', 'Adhikari', 9845678876, '2001-08-10', 'Other', '@samip', 'smp5', 'privileged', 'samip@scamdigitals.com'),
(5, 'Manil', 'Pyakurel', 9869123345, '1999-10-26', 'Male', '@manil', 'm4', 'privileged', 'manil@scamdigitals.com'),
(6, 'Puja', 'Kalami', 9812345678, '2005-07-08', 'Female', '@puja', 'pj10', 'privileged', 'puja@scamdigitals.com');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `price` int(11) NOT NULL,
  `product_image_url` varchar(255) DEFAULT NULL,
  `stock_quantity` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `name`, `description`, `price`, `product_image_url`, `stock_quantity`, `category_id`) VALUES
(1, 'Samsung Desktop', 'This is a Samsung desktop.', 1399, 'input.png', 12, 2),
(2, 'Lenovo Laptop', 'This is a lenovo laptop.', 800, 'laptop_image_url', 5, 1),
(3, 'Mouse', 'This is a mouse.', 129, 'mouseImageUrl.', 5, 3),
(4, 'Keyboard', 'This is a keyboard.', 199, 'keyboardImageUrl.', 8, 3),
(5, 'asfsfa', 'asf asfdsf', 120, '/Users/nishan/eclipse-workspace/digital_dynasty/src/main/webapp/resources/images/product/Screenshot 2024-05-10 at 12.02.25 AM.png', 12, 2),
(6, 'ipnone', 'aside ask', 1200, 'iphone.png', 40, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `firstname`, `lastname`, `username`, `password`, `email`, `phone_number`) VALUES
(23, 'jack', 'ma', 'jack', 'ma', 'jack@gmail.com', '98765432345'),
(24, 'nishan', 'pokharel', 'nishan01', '123', 'nishan@gmail.com', '987654234'),
(25, 'rajesh', 'dai', 'rajesh', '123', 'rajesh@email.com', '97653456999'),
(26, 'Mlon', 'Eusk', 'mlon017', '123', 'mlon@gmail.com', '98765434567');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `'order'`
--
ALTER TABLE `'order'`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `address_id` (`address_id`) USING BTREE;

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_product`
--
ALTER TABLE `cart_product`
  ADD KEY `cart_id` (`cart_id`) USING BTREE;

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `delivery_address`
--
ALTER TABLE `delivery_address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `ordered_product`
--
ALTER TABLE `ordered_product`
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `privileged_user`
--
ALTER TABLE `privileged_user`
  ADD PRIMARY KEY (`priviliged_user_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `'order'`
--
ALTER TABLE `'order'`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `delivery_address`
--
ALTER TABLE `delivery_address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `'order'`
--
ALTER TABLE `'order'`
  ADD CONSTRAINT `address_id` FOREIGN KEY (`address_id`) REFERENCES `delivery_address` (`address_id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`);

--
-- Constraints for table `ordered_product`
--
ALTER TABLE `ordered_product`
  ADD CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `'order'` (`order_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
