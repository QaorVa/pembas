-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2023 at 06:19 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `createBook` (IN `in_isbn` INT(13), IN `in_title` VARCHAR(255), IN `in_author` VARCHAR(255), IN `in_category` VARCHAR(30), IN `in_publisher` VARCHAR(255), IN `in_year_published` INT(4), IN `in_copies` INT(3))   INSERT INTO book
VALUES (in_isbn, in_title, in_author, in_category, in_publisher, in_year_published, in_copies)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createFine` (IN `in_loan_id` INT(11), IN `in_reader_id` INT(11))   BEGIN
DECLARE daysPassed int;
DECLARE amountTimesDays double;
SELECT return_date into @returnDate FROM loan WHERE loan_id = in_loan_id;
SELECT returned_date into @returnedDate FROM loan WHERE loan_id = in_loan_id;
set daysPassed = TIMESTAMPDIFF(DAY, @returnDate, @returnedDate);
set amountTimesDays = 1600 * daysPassed;
INSERT INTO fine (fine_date, amount, paid, loan_id, reader_id)
VALUES (now(), amountTimesDays, "No", in_loan_id, in_reader_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createReader` (IN `in_name` VARCHAR(255), IN `in_email` VARCHAR(255), IN `in_password` VARCHAR(255), IN `in_age` INT(3), IN `in_address` VARCHAR(255), IN `in_phone_no` INT(15))   INSERT INTO reader (name, age, address, phone_no, email, reader.password)
VALUES (in_name, in_age, in_address, in_phone_no, in_email, in_password)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBook` (IN `in_isbn` INT(13))   DELETE FROM book WHERE isbn = in_isbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editBook` (IN `in_isbn` INT(13), IN `in_title` VARCHAR(255), IN `in_author` VARCHAR(255), IN `in_category` VARCHAR(30), IN `in_publisher` VARCHAR(255), IN `in_year_published` INT(4), IN `in_copies` INT(3))   UPDATE book
SET title = in_title, author = in_author, category = in_category, publisher = in_publisher, year_published = in_year_published, copies = in_copies
WHERE isbn = in_isbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editFine` (IN `in_fine_date` DATETIME, IN `in_amount` INT(11), IN `in_fine_id` INT(11))   UPDATE fine
SET fine_date = in_fine_date, amount = in_amount
WHERE fine_id = in_fine_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editProfile` (IN `in_name` VARCHAR(255), IN `in_age` INT(3), IN `in_address` VARCHAR(255), IN `in_phone_no` INT(15), IN `in_reader_id` INT(11))   UPDATE reader
SET name = in_name, age = in_age, address = in_address, phone_no = in_phone_no
WHERE reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fineHistory` (IN `in_reader_id` INT(11))   SELECT f.fine_id as Fine_ID, f.fine_date as Fine_Date, f.amount as Amount, fp.payment_date as Date_Paid, fp.payment_amount as Amount_Paid
FROM fine_payment fp
left JOIN fine f on fp.fine_id = f.fine_id
left JOIN reader r on fp.reader_id = r.reader_id
WHERE fp.reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loanBook` (IN `in_isbn` INT(13), IN `in_reader_id` INT(11), IN `in_days` INT(2))   BEGIN
INSERT INTO loan (loan_date, return_date, reader_id, isbn)
VALUES (now(), date_add(now(), INTERVAL in_days day), in_reader_id, in_isbn);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loanHistory` (IN `in_reader_id` INT(11))   SELECT l.loan_id as Loan_ID, b.title as Book, l.loan_date as Borrowed, l.return_date as Return_Date, l.returned_date as Date_Returned
FROM loan l
left JOIN reader r on l.reader_id = r.reader_id
left JOIN book b on l.isbn = b.isbn
WHERE r.reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `overdueBook` ()   BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE isbN INT;
DECLARE returnDate DATETIME;
DECLARE readerName VARCHAR(255);
DECLARE cur CURSOR FOR SELECT b.isbn, l.return_date, r.name 
FROM loan l
LEFT JOIN book b on b.isbn = l.isbn
LEFT JOIN reader r ON r.reader_id = l.reader_id;
    
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TEMPORARY TABLE IF NOT EXISTS overdue_books (
        isbn INT (13),
        return_date DATETIME,
        reader_name VARCHAR(255)
    );

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO isbN, returnDate, readerName;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF returnDate < NOW() THEN
            INSERT INTO overdue_books (isbn, return_date, reader_name) VALUES (isbN, returnDate, readerName);
        END IF;
    END LOOP;

    CLOSE cur;
    
    -- Query the overdue_books table for the results
    SELECT * FROM overdue_books;
    
    -- Clean up the temporary table
    DROP TABLE IF EXISTS overdue_books;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payFine` (IN `in_reader_id` INT(11), IN `in_fine_id` INT(11))   BEGIN
SELECT amount INTO @amount FROM fine WHERE fine_id = in_fine_id;
INSERT INTO fine_payment (payment_date, payment_amount, reader_id, fine_id)
VALUES (now(), @amount, in_reader_id, in_fine_id);
UPDATE fine
SET paid = "Yes"
WHERE fine_id = in_fine_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readAllFine` (IN `in_reader_id` INT(11))   SELECT * FROM fine WHERE reader_id = in_reader_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readBook` (IN `in_isbn` INT(13))   SELECT * FROM book 
WHERE isbn = in_isbn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `readFine` (IN `in_fine_id` INT(11))   SELECT * FROM fine WHERE fine_id = in_fine_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `returnBook` (IN `in_loan_id` INT(11), IN `in_reader_id` INT(11))   BEGIN
DECLARE daysPassed int;
SELECT return_date into @returnDate FROM loan WHERE loan_id = in_loan_id;

UPDATE loan
SET returned_date = now()
WHERE loan_id = in_loan_id;

set daysPassed = TIMESTAMPDIFF(DAY, @returnDate, NOW());
IF daysPassed > 0 THEN
	call createFine(in_loan_id, in_reader_id);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectAllBook` ()   SELECT * FROM book$$

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
(22, 'asduiu', 'qweo', 'sadiub', 'asdas', 2011, 4),
(11111, 'Laskar Pelangi', 'Andrea Hirata', 'Novel', 'Bentang Pustaka', 2005, 3),
(12345, 'Harry Potter and the Sorcerer Stone', 'J.K. Rowling', 'Fantasy', 'Scholastic', 1997, 5),
(54321, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 'Charles Scribners Sons', 1925, 0),
(67350, 'Negeri 5 Menara', 'Ahmad Fuadi', 'Novel', 'Gramedia Pustaka Utama', 2009, 3),
(67890, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 'J. B. Lippincott & Co.', 1960, 7),
(94890, 'Dilan: Dia adalah Dilanku Tahun 1990', 'Pidi Baiq', 'Romance', 'Pastel Books', 2014, 0),
(12831123, 'Harry Potter', 'JK Rowling', 'Fiction', 'IDK', 2012, 7);

-- --------------------------------------------------------

--
-- Table structure for table `fine`
--

CREATE TABLE `fine` (
  `fine_id` int(11) NOT NULL,
  `fine_date` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `paid` varchar(3) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `reader_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fine`
--

INSERT INTO `fine` (`fine_id`, `fine_date`, `amount`, `paid`, `loan_id`, `reader_id`) VALUES
(1, '2023-06-13 22:41:52', 9600, 'Yes', 4, 1),
(2, '2023-06-13 22:54:40', 0, 'No', 6, 1),
(3, '2023-06-13 22:57:01', 8000, 'No', 7, 1),
(4, '2023-06-13 23:05:46', 1600, 'No', 9, 1);

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

--
-- Dumping data for table `fine_payment`
--

INSERT INTO `fine_payment` (`fine_payment_id`, `payment_date`, `payment_amount`, `reader_id`, `fine_id`) VALUES
(1, '2023-06-13 23:19:27', 9600, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(11) NOT NULL,
  `loan_date` datetime NOT NULL,
  `return_date` datetime NOT NULL,
  `returned_date` datetime DEFAULT NULL,
  `reader_id` int(11) NOT NULL,
  `isbn` int(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `loan_date`, `return_date`, `returned_date`, `reader_id`, `isbn`) VALUES
(3, '2023-06-12 18:26:10', '2023-06-19 18:26:10', '0000-00-00 00:00:00', 1, 22),
(4, '2023-06-13 12:51:59', '2023-06-20 12:51:59', '2023-06-13 22:41:52', 1, 22),
(5, '2023-06-13 13:01:50', '2023-06-13 13:02:00', '2023-06-13 22:49:38', 1, 12831123),
(6, '2023-06-13 22:50:12', '2023-06-13 22:50:50', '2023-06-13 22:51:57', 1, 11111),
(7, '2023-06-07 22:53:50', '2023-06-08 22:54:00', '2023-06-13 22:54:15', 1, 94890),
(8, '2023-06-13 22:59:56', '2023-06-20 22:59:56', '2023-06-13 23:06:01', 1, 67890),
(9, '2023-06-11 23:04:44', '2023-06-12 23:04:44', '2023-06-13 23:05:46', 1, 11111);

--
-- Triggers `loan`
--
DELIMITER $$
CREATE TRIGGER `reduceCopies` AFTER INSERT ON `loan` FOR EACH ROW UPDATE book
SET copies = copies - 1
WHERE isbn = NEW.isbn
$$
DELIMITER ;

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
(1, 'Zalvy', 20, 'Osella', 8138434, 'zlavyw8hd', 'thevandy10'),
(2, 'admin', 11, '1asdz', 1231, 'admin', 'admin');

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
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `fine_payment`
--
ALTER TABLE `fine_payment`
  MODIFY `fine_payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `reader`
--
ALTER TABLE `reader`
  MODIFY `reader_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
