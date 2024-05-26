-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2024 at 05:08 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exp_sys_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tabel_gejala`
--

CREATE TABLE `tabel_gejala` (
  `kode_gejala` char(20) DEFAULT NULL,
  `nama_gejala` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tabel_gejala`
--

INSERT INTO `tabel_gejala` (`kode_gejala`, `nama_gejala`) VALUES
('G0001', 'Batuk'),
('G0002', 'Sesak Nafas'),
('G0003', 'Nyeri Dada'),
('G0004', 'Demam'),
('G0005', 'Menggigil'),
('G0006', 'Batuk dahak berdarah'),
('G0007', 'Kelelahan'),
('G0008', 'Berat badan turun'),
('G0009', 'Pernapasan bunyi'),
('G0010', 'Pembengkakan kaki/pergelangan'),
('G0011', 'Dahak berlebihan'),
('G0012', 'Kesulitan tidur'),
('G0013', 'Penurunan kemampuan fisik');

-- --------------------------------------------------------

--
-- Table structure for table `tabel_penyakit`
--

CREATE TABLE `tabel_penyakit` (
  `kode_penyakit` varchar(6) NOT NULL,
  `nama_penyakit` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tabel_penyakit`
--

INSERT INTO `tabel_penyakit` (`kode_penyakit`, `nama_penyakit`) VALUES
('P00001', 'Pneumonia'),
('P00002', 'Tuberkulosis'),
('P00003', 'Asma'),
('P00004', 'Kanker Paru-Paru'),
('P00005', 'Bronkitis'),
('P00006', 'PPOK'),
('P00007', 'Emboli Paru-Paru'),
('P00008', 'Tuberkulosis Ekstra Paru'),
('P00009', 'Asbestosis');

-- --------------------------------------------------------

--
-- Table structure for table `tabel_pertanyaan`
--

CREATE TABLE `tabel_pertanyaan` (
  `kode_pertanyaan` varchar(6) NOT NULL,
  `pertanyaan` varchar(50) NOT NULL,
  `kode_gejala` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tabel_pertanyaan`
--

INSERT INTO `tabel_pertanyaan` (`kode_pertanyaan`, `pertanyaan`, `kode_gejala`) VALUES
('T00001', 'Apakah anda menderita batuk-batuk?', 'G0001'),
('T00002', 'Apakah nafas anda terasa sesak?', 'G0002'),
('T00003', 'Apakah dada anda terasa nyeri?', 'G0003'),
('T00004', 'Apakah anda merasa demam?', 'G0004'),
('T00005', 'Apakah anda merasa menggigil?', 'G0005'),
('T00006', 'Apakah anda batuk dengan dahak berdarah?', 'G0006'),
('T00007', 'Apakah anda merasa kelelahan?', 'G0007'),
('T00008', 'Apakah berat badan anda mengalami penurunan?', 'G0008'),
('T00009', 'Apakah pernapasan anda berbunyi?', 'G0009'),
('T00010', 'Apakah kaki/pergelangan anda bengkak?', 'G0010'),
('T00011', 'Apakah anda mengeluarkan dahak yang berlebihan?', 'G0011'),
('T00012', 'Apakah anda merasa kesulitan tidur?', 'G0012'),
('T00013', 'Apakah anda mengalami penurunan kemampuan fisik?', 'G0013');

-- --------------------------------------------------------

--
-- Table structure for table `tabel_rule`
--

CREATE TABLE `tabel_rule` (
  `kode_rule` varchar(6) NOT NULL,
  `kode_pertanyaan` varchar(100) NOT NULL,
  `kode_penyakit` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tabel_rule`
--

INSERT INTO `tabel_rule` (`kode_rule`, `kode_pertanyaan`, `kode_penyakit`) VALUES
('R0001', 'T00001,T00002,T00003,T00004,T00005,T00006,T00007,T00008,T00009,T00011,T00012,T00013', 'P00001'),
('R0002', 'T00001,T00002,T00004,T00005,T00006,T00007,T00008,T00010,T00011,T00012,T00013', 'P00002'),
('R0003', 'T00001,T00002,T00003,T00009,T00011,T00012', 'P00003'),
('R0004', 'T00001,T00002,T00003,T00006,T00007,T00008,T00012,T00013', 'P00004'),
('R0005', 'T00001,T00002,T00003,T00004,T00005,T00007,T00008,T00009,T00011,T00012,T00013', 'P00005'),
('R0006', 'T00001,T00002,T00003,T00007,T00008,T00009,T00010,T00011,T00012,T00013', 'P00006'),
('R0007', 'T00001,T00002,T00003,T00004', 'P00007'),
('R0008', 'T00001,T00002,T00003,T00004,T00005,T00006,T00007,T00008,T00011,T00012,T00013', 'P00008'),
('R0009', 'T00001,T00002,T00003', 'P00009');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
