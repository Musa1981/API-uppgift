-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1
-- Tid vid skapande: 07 dec 2023 kl 09:22
-- Serverversion: 10.4.28-MariaDB
-- PHP-version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `jensen2023`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `email`) VALUES
(1, 'kalleanka', '$2b$10$htYEJJAbyt49Cn.Ljquadu5.nmrgoZ/XQP8sHPKiS.FYGCU54jgES', 'Donald Duck', 'kalle@anka.se'),
(4, 'Pirate1', '$2b$10$pa1CZozbWmkGkpv17kiV6OejzdwIVCjFpQ51U2oAkuNZSMVumXGh6', 'Silver', 'silver@gold.se'),
(5, 'Musa1981', '$2b$10$ArQKk/g9IB94SSKz5qCliuXQTBD934HFTb8z5fhjLXIAyuGbVeR/y', 'Musa Vakilov', 'kakusi@mail.com'),
(6, 'Pirate', '$2b$10$M2NBVS7d0ka5JlSWpNtcXebAvbHsakB25ApKpoNhWZthfWCQwjt/O', 'John Silver', 'silver@john.se'),
(10, 'minipig', 'Piip', 'Musse Anka', 'musse@anka.se'),
(11, 'Caster Troy', 'code', 'Gangster', 'shonarcher@mail.com'),
(13, 'Ali', '22dc2ea850577c6c560cbfd6422efa8f0d6c0071c4ebe67ac87c2033e821d24f', 'Aladdin', 'aladdin@disney.se'),
(17, 'Abxaziya', 'Tbilisi', 'Malaka', 'chubaka'),
(33, 'Arab', 'Shazaam!', 'Aladdin', 'jasmine@disney.com'),
(34, 'Mamuka', 'Musa1981', 'Moses', 'det@gorbra.se'),
(38, 'caribean', 'grotan55', 'suliko', 'suliko@moya.com'),
(46, 'caribean5', '0070f10dada7cbbf442d30ea1e3a7bbc465f896db1d5d5b7cf67c3c05eaf3e0c', 'Silver', 'silver@john.com'),
(47, 'mimino', '0b221d7bafc240d08d6555deee3f09c786056db2edac1b68bd0103129318ad2a', 'suliko', 'suliko@moya.com'),
(51, 'Bagdad', '$2b$10$h9GHh9veRsSK7KOR3jFWQO9qevqGoczyI1wEUwgq2ATOxIFRzM7T6', 'Jasmine', 'jasmine@disney.com'),
(53, 'Arabica', '$2b$10$EOhyXuUzErc0Rd12V9ZgcOs7FV8ur0sA7rYqZUvobMFYQZZtB59Oy', 'Abu', 'camel@disney.com'),
(54, 'california', '$2b$10$IWVSZunlFQqSLci6QlIdNuHdUklIWwhawj/wWyOpke.HRfl9PBG5y', 'Santa-barbara', 'los@angeles.com'),
(55, 'malaka', '$2b$10$YNfMWhz6Jp7AGBG9CJQd6O40ApXzV/8Fgl165Gn/4t1Lb0DijgzuO', 'Muza', 'muza@mail.com'),
(56, 'Musa', '$2b$10$upNtfY0AgKR8TDK5oWjcheoSjt4iiN5cYaG/jY9JFx2AyzxZGahJW', 'Vakilov', 'mulan@mail.com'),
(58, 'Georgia', '$2b$10$ZzIggU7YJO5BJ1bXK.YnWuQY.sYM3092Je88oj3BJ.ZZkfzW3y3gi', 'Miminoshka', 'suli@mail.com');

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Unique` (`username`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
