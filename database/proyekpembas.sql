-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2023 at 09:03 AM
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
-- Database: `proyekpembas`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `bookAvail` ()   SELECT * FROM book WHERE copies != 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createBook` (IN `in_isbn` INT(13), IN `in_title` VARCHAR(255), IN `in_author` VARCHAR(255), IN `in_category` VARCHAR(30), IN `in_publisher` VARCHAR(255), IN `in_year_publisher` INT(4), IN `in_copies` INT(3))   INSERT INTO book
VALUES (in_isbn, in_title, in_author, in_category, in_publisher, in_year_published, in_copies)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createFine` (IN `in_loan_id` INT(11), IN `in_reader_id` INT(11))   BEGIN
DECLARE daysPassed int;
DECLARE amountTimesDays double;
SELECT return_date into @returnDate FROM loan_id WHERE loan_id = in_loan_id;
set daysPassed = TIMESTAMPDIFF(DAY, now(), @returnDate);
set amountTimesDays = 1600 * daysPassed;
INSERT INTO fine (fine_date, amount, loan_id, reader_id)
VALUES (now(), amountTimesDays, in_loan_id, in_reader_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createReader` (IN `in_name` VARCHAR(255), IN `in_email` VARCHAR(255), IN `in_password` VARCHAR(255), IN `in_age` INT(3), IN `in_address` VARCHAR(255), IN `in_phone_no` INT(15))   INSERT INTO reader (name, age, address, phone_no, email, reader.password)
VALUES (in_name, in_age, in_address, in_phone_no, in_email, in_password)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editBook` (IN `in_isbn` INT(13), IN `in_title` VARCHAR(255), IN `in_author` VARCHAR(255), IN `in_category` VARCHAR(30), IN `in_publisher` VARCHAR(255), IN `in_year_publisher` INT(4), IN `in_copies` INT(3))   UPDATE book
SET title = in_title, author = in_author, category = in_category, publisher = in_publisher, year_publisher = in_year_publisher, copies = in_copies
WHERE isbn = in_isbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editFine` (IN `in_fine_date` DATETIME, IN `in_amount` INT(11), IN `in_fine_id` INT(11))   UPDATE fine
SET fine_date = in_fine_date, amount = in_amount
WHERE fine_id = in_fine_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editProfile` (IN `in_name` VARCHAR(255), IN `in_age` INT(3), IN `in_address` VARCHAR(255), IN `in_phone_no` INT(15), IN `in_reader_id` INT(11))   UPDATE reader
SET name = in_name, age = in_age, address = in_address, phone_no = in_phone_no
WHERE reader_id = in_reader_idl$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fineHistory` (IN `in_reader_id` INT(11))   SELECT f.fine_id as Fine_ID, f.fine_date as Fine_Date, f.amount as Amount, fp.payment_date as Date_Paid, fp.payment_amount as Amount_Paid
FROM fine_payment fp
left JOIN fine f on fp.fine_id = f.fine_id
left JOIN reader r on fp.reader_id = r.reader_id
WHERE fp.reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loanBook` (IN `in_isbn` INT(13), IN `in_reader_id` INT(11), IN `in_days` INT(2))   BEGIN
INSERT INTO loan (loan_date, return_date, returned, reader_id, isbn)
VALUES (now(), date_add(now(), INTERVAL in_days day), 0, in_reader_id, in_isbn);
call reduceCopies(in_isbn, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loanHistory` (IN `in_reader_id` INT(11))   SELECT l.loan_id as Loan_ID, b.title as Book, l.loan_date as Borrowed, l.return_date as Returned
FROM loan l
left JOIN reader r on l.reader_id = r.reader_id
left JOIN book b on l.isbn = b.isbn
WHERE r.reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payFine` (IN `in_payment_amount` INT(11), IN `in_reader_id` INT(11), IN `in_fine_id` INT(11))   INSERT INTO fine_payment (payment_date, payment_amount, reader_id, fine_id)
VALUES (now(), in_payment_amount, in_reader_id, in_fine_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readAllFine` (IN `in_reader_id` INT(11))   SELECT * FROM fine WHERE reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readBook` (IN `in_isbn` INT(13))   SELECT * FROM book 
WHERE isbn = in_isbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readFine` (IN `in_fine_id` INT(11))   SELECT * FROM fine WHERE fine_id = in_fine_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reduceCopies` (IN `in_isbn` INT(13), IN `copiesTaken` INT(3))   BEGIN
DECLARE bookCopies int;
DECLARE copiesResult int;
SELECT copies INTO bookCopies FROM book WHERE isbn = in_isbn;
SET copiesResult := (bookCopies -copiesTaken); 
UPDATE book
SET copies = copiesResult
WHERE isbn = in_isbn;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `returnBook` (IN `in_loan_id` INT(11), IN `in_reader_id` INT(11))   BEGIN
UPDATE loan
SET returned = 1
WHERE loan_id = in_loan_id;
call createFine(in_loan_id, in_reader_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectProfile` (IN `in_reader_id` INT(11))   SELECT * FROM reader WHERE reader_id = in_reader_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `isbn` int(13) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `category` varchar(30) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `year_published` int(4) NOT NULL,
  `copies` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`isbn`, `title`, `author`, `category`, `publisher`, `year_published`, `copies`) VALUES
(22, 'asdui', 'qweo', 'sadiub', 'asdas', 2011, 0),
(12831123, 'Harry Potter', 'JK Rowling', 'Fiction', 'IDK', 2012, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fine`
--

CREATE TABLE `fine` (
  `fine_id` int(11) NOT NULL,
  `fine_date` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fine_payment`
--

CREATE TABLE `fine_payment` (
  `fine_payment_id` int(11) NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_amount` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL,
  `fine_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(11) NOT NULL,
  `loan_date` datetime NOT NULL,
  `return_date` datetime NOT NULL,
  `returned` tinyint(1) NOT NULL,
  `reader_id` int(11) NOT NULL,
  `isbn` int(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reader`
--

CREATE TABLE `reader` (
  `reader_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_no` int(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reader`
--

INSERT INTO `reader` (`reader_id`, `name`, `age`, `address`, `phone_no`, `email`, `password`) VALUES
(1, 'Zalvy', 20, 'Osella', 8138434, 'zlavyw8hd', 'thevandy10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`isbn`);

--
-- Indexes for table `fine`
--
ALTER TABLE `fine`
  ADD PRIMARY KEY (`fine_id`),
  ADD KEY `loan_id` (`loan_id`),
  ADD KEY `reader_id` (`reader_id`);

--
-- Indexes for table `fine_payment`
--
ALTER TABLE `fine_payment`
  ADD PRIMARY KEY (`fine_payment_id`),
  ADD KEY `fine_id` (`fine_id`),
  ADD KEY `reader_id` (`reader_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `isbn` (`isbn`),
  ADD KEY `loan_ibfk_2` (`reader_id`);

--
-- Indexes for table `reader`
--
ALTER TABLE `reader`
  ADD PRIMARY KEY (`reader_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fine`
--
ALTER TABLE `fine`
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fine_payment`
--
ALTER TABLE `fine_payment`
  MODIFY `fine_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reader`
--
ALTER TABLE `reader`
  MODIFY `reader_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fine`
--
ALTER TABLE `fine`
  ADD CONSTRAINT `fine_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`),
  ADD CONSTRAINT `fine_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `fine` (`fine_id`);

--
-- Constraints for table `fine_payment`
--
ALTER TABLE `fine_payment`
  ADD CONSTRAINT `fine_payment_ibfk_1` FOREIGN KEY (`fine_id`) REFERENCES `fine` (`fine_id`),
  ADD CONSTRAINT `fine_payment_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `fine_payment` (`fine_payment_id`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`),
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`reader_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
