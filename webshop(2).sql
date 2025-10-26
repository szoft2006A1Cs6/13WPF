-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Okt 25. 19:53
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `webshop`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kategoria`
--

CREATE TABLE `kategoria` (
  `id` int(11) NOT NULL,
  `nev` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kategoria`
--

INSERT INTO `kategoria` (`id`, `nev`) VALUES
(1, 'Elektronika'),
(2, 'Könyvek'),
(3, 'Ruházat'),
(4, 'Konyha'),
(5, 'Sport');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles`
--

CREATE TABLE `rendeles` (
  `id` int(11) NOT NULL,
  `vasarloId` int(11) NOT NULL,
  `datum` date NOT NULL,
  `osszeg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendeles`
--

INSERT INTO `rendeles` (`id`, `vasarloId`, `datum`, `osszeg`) VALUES
(1, 1, '2024-11-15', 404998),
(2, 2, '2024-12-02', 22998);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelestetel`
--

CREATE TABLE `rendelestetel` (
  `id` int(11) NOT NULL,
  `rendelesId` int(11) NOT NULL,
  `termekId` int(11) NOT NULL,
  `mennyiseg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendelestetel`
--

INSERT INTO `rendelestetel` (`id`, `rendelesId`, `termekId`, `mennyiseg`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 2, 4, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termek`
--

CREATE TABLE `termek` (
  `id` int(11) NOT NULL,
  `nev` varchar(128) NOT NULL,
  `leiras` text DEFAULT NULL,
  `ar` int(11) NOT NULL,
  `keszlet` int(11) NOT NULL,
  `kategoriaId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `termek`
--

INSERT INTO `termek` (`id`, `nev`, `leiras`, `ar`, `keszlet`, `kategoriaId`) VALUES
(1, 'Laptop', '14 colos laptop 16GB RAM-mal', 399999, 12, 1),
(2, 'Okosóra', 'Bluetooth okosóra pulzusméréssel', 49999, 25, 1),
(3, 'Regény', 'Klasszikus magyar irodalmi mű', 2999, 50, 2),
(4, 'Férfi póló', '100% pamut, különböző méretek', 4999, 30, 3),
(5, 'Konyhai robotgép', '500W teljesítmény, 3 sebességfokozat', 24999, 10, 4),
(6, 'Futócipő', 'Kényelmes sportcipő kültéri futáshoz', 19999, 15, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vasarlo`
--

CREATE TABLE `vasarlo` (
  `id` int(11) NOT NULL,
  `nev` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `cim` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `vasarlo`
--

INSERT INTO `vasarlo` (`id`, `nev`, `email`, `cim`) VALUES
(1, 'Kiss Péter', 'peter.kiss@example.com', 'Budapest, Fő utca 10.'),
(2, 'Nagy Anna', 'anna.nagy@example.com', 'Debrecen, Piac utca 22.');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `kategoria`
--
ALTER TABLE `kategoria`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `rendeles`
--
ALTER TABLE `rendeles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vasarloId` (`vasarloId`);

--
-- A tábla indexei `rendelestetel`
--
ALTER TABLE `rendelestetel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rendelesId` (`rendelesId`),
  ADD KEY `termekId` (`termekId`);

--
-- A tábla indexei `termek`
--
ALTER TABLE `termek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategoriaId` (`kategoriaId`);

--
-- A tábla indexei `vasarlo`
--
ALTER TABLE `vasarlo`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `kategoria`
--
ALTER TABLE `kategoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `rendeles`
--
ALTER TABLE `rendeles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `rendelestetel`
--
ALTER TABLE `rendelestetel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `termek`
--
ALTER TABLE `termek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `vasarlo`
--
ALTER TABLE `vasarlo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `rendeles`
--
ALTER TABLE `rendeles`
  ADD CONSTRAINT `FK_rendeles_vasarlo` FOREIGN KEY (`vasarloId`) REFERENCES `vasarlo` (`id`);

--
-- Megkötések a táblához `rendelestetel`
--
ALTER TABLE `rendelestetel`
  ADD CONSTRAINT `FK_rendelestetel_rendeles` FOREIGN KEY (`rendelesId`) REFERENCES `rendeles` (`id`),
  ADD CONSTRAINT `FK_rendelestetel_termek` FOREIGN KEY (`termekId`) REFERENCES `termek` (`id`);

--
-- Megkötések a táblához `termek`
--
ALTER TABLE `termek`
  ADD CONSTRAINT `FK_termek_kategoria` FOREIGN KEY (`kategoriaId`) REFERENCES `kategoria` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
