-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 27, 2019 at 05:04 PM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thecodingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(40) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone_no` varchar(40) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `msg` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_no`, `date`, `msg`) VALUES
(1, 'first', 'first@gmail.com', '123456789', '2019-06-18 13:00:55', 'firstpost'),
(11, 'rakesh', 'rakesh@gmail.com', '3747393977', '2019-06-21 23:26:57', '2nd message'),
(12, 'rakesh', 'rakesh@gmail.com', '3747393977', '2019-06-21 23:39:35', '2nd message');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `tagline` varchar(40) NOT NULL,
  `img_file` varchar(50) NOT NULL,
  `date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`sno`, `title`, `slug`, `content`, `tagline`, `img_file`, `date`) VALUES
(1, 'About Coding', 'pehla-post', 'Computer programming is the process of designing and building an executable computer program for accomplishing a specific computing task. Programming involves tasks such as: analysis, generating algorithms, profiling algorithms\' accuracy and resource consumption, and the implementation of algorithms in a chosen programming language (commonly referred to as coding)[1][2]. The source code of a program is written in one or more languages that are intelligible to programmers, rather than machine code, which is directly executed by the central processing unit. The purpose of programming is to find a sequence of instructions that will automate the performance of a task (which can be as complex as an operating system) on a computer, often for solving a given problem. The process of programming thus often requires expertise in several different subjects, including knowledge of the application domain, specialized algorithms, and formal logic.\r\n\r\nTasks accompanying and related to programming include: testing, debugging, source code maintenance, implementation of build systems, and management of derived artifacts, such as the machine code of computer programs. These might be considered part of the programming process, but often the term software development is used for this larger process with the term programming, implementation, or coding reserved for the actual writing of code. Software engineering combines engineering techniques with software development practices. Reverse engineering is the opposite process. A hacker is any skilled computer expert that uses their technical knowledge to overcome a problem, but it can also mean a security hacker in common language. ', 'Overview', 'home-bg.jpg', '2019-06-24 00:00:00.000000'),
(2, '2nd post', 'dusra-post', 'Edited Frontal view of the Bayerische Staatskanzlei (Bavarian State Chancellery), Hofgarten, Munich, Germany. The institution is serving as the executive office of the Minister-President as head of government. The State Chancellery is represented by Bavarian missions in the German capital Berlin and to the European Union in Brussels.   \r\n', 'Code1', 'code1.jpg', '2019-06-27 00:24:05.211222'),
(3, '3rd post', 'teesra-post', 'On February 2, 2018, it was announced that CBS had given the production a pilot order.[4] The pilot script was set to be written by Craig Sweeny who was also set as an executive producer along with Craig Turk, Carl Beverly and Sarah Timberman. Production companies involved with the pilot include CBS Television Studios and Timberman-Beverly Productions. On February 9, 2018, it was reported that Marc Webb would direct the pilot episode.[5] \r\nOn May 11, 2018, it was announced that CBS had given the production a series order. A few days later, it was announced that the series would premiere in the spring of 2019 as a mid-season replacement. On January 15, 2019, it was announced that the series would be held back from mid-season with a premiere date of April 9, 2019.[6] It was scheduled to air weekly on Tuesdays during the 9 PM time slot. ', 'Code2', 'code2.jpg', '2019-06-25 00:00:00.000000'),
(4, '4th post', 'fourth-post', 'On Rotten Tomatoes, the series holds an approval rating of 30% based on reviews from 10 critics, with an average rating of 6.5/10. The website\'s critical consensus reads, \"Despite its pedigree, The Code does little to differentiate itself in a crowded field.\"[23] On Metacritic, it has a weighted average score of 56 out of 100, based on reviews from 5 critics, indicating \"mixed or average reviews', 'Code3', 'code3.jpg', '2019-06-25 00:00:00.000000'),
(5, '5th post', 'fivth-post', 'A computer is a machine that can be instructed to carry out sequences of arithmetic or logical operations automatically via computer programming. Modern computers have the ability to follow generalized sets of operations, called programs. These programs enable computers to perform an extremely wide range of tasks. A \"complete\" computer including the hardware, the operating system (main software), and peripheral equipment required and used for \"full\" operation can be referred to as a computer system. This term may as well be used for a group of computers that are connected and work together, in particular a computer network or computer cluster. ', 'Code4', 'code4.jpg', '2019-06-26 00:00:00.000000'),
(6, '6th post', 'sixth-post', 'd fnsmskjsnfnsj\r\nfsfksgksk\r\nfbsbgfksgbjskg\r\nsfjskslgjsljsl', 'code5', 'code5.jpg', '0000-00-00 00:00:00.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
