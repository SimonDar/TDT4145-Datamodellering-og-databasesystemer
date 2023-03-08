CREATE TABLE `banestrekninger`(
    `StarterStasjon` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `SluttStasjon` BIGINT NOT NULL,
    `Antall stopp/delstrekninger` BIGINT NOT NULL,
    `Navn` BIGINT NOT NULL
);
CREATE TABLE `Ordre`(
    `TogRute` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Sete` BIGINT NOT NULL,
    `OrdreNr` BIGINT NOT NULL,
    `KundeNr` BIGINT NOT NULL,
    `Dato og Tid for kjøp` BIGINT NOT NULL
);
ALTER TABLE
    `Ordre` ADD PRIMARY KEY `ordre_togrute_primary`(`TogRute`);
CREATE TABLE `Jernbanestasjon`(
    `Tilhørende banestrekning` BIGINT NOT NULL,
    `Lengde fra stasjon før og etter` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `navn` BIGINT NOT NULL,
    `meter over havet` BIGINT NOT NULL
);
CREATE TABLE `Kunde`(
    `kundenummer` BIGINT NOT NULL,
    `Hvilken operatør` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `navn` BIGINT NOT NULL,
    `e- postadresse` BIGINT NOT NULL,
    `mobilnummer` BIGINT NOT NULL,
    `billetterkjøp` BIGINT NOT NULL
);
CREATE TABLE `Togruter`(
    `startstasjonen` BIGINT NOT NULL,
    `operatør` BIGINT NOT NULL,
    `Stasjoner på strekningen` BIGINT NOT NULL,
    `Med eller mot banestrekning` BIGINT NOT NULL,
    `KlokkeSlettPåStasjoner` BIGINT NOT NULL,
    `endestasjonen` BIGINT NOT NULL,
    `TogType` BIGINT NOT NULL,
    `Dager den kjører` BIGINT NOT NULL
);
CREATE TABLE `TogType`(
    `TogRute` BIGINT NOT NULL,
    `operatør` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `VognTyper` BIGINT NOT NULL,
    `fremdriftsenergi` BIGINT NOT NULL,
    `Ledige seter` BIGINT NOT NULL,
    `Okkuperte seter` BIGINT NOT NULL,
    `vognoppsett` BIGINT NOT NULL
);
CREATE TABLE `Klokkeslett`(
    `TogRute` BIGINT NOT NULL,
    `AnkomstTid` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `AvGangstid` BIGINT NOT NULL,
    `Stasjon` BIGINT NOT NULL
);
ALTER TABLE
    `Kunde` ADD CONSTRAINT `kunde_kundenummer_foreign` FOREIGN KEY(`kundenummer`) REFERENCES `Ordre`(`Sete`);
ALTER TABLE
    `Togruter` ADD CONSTRAINT `togruter_startstasjonen_foreign` FOREIGN KEY(`startstasjonen`) REFERENCES `Jernbanestasjon`(`meter over havet`);
ALTER TABLE
    `Klokkeslett` ADD CONSTRAINT `klokkeslett_togrute_foreign` FOREIGN KEY(`TogRute`) REFERENCES `Togruter`(`Stasjoner på strekningen`);
ALTER TABLE
    `TogType` ADD CONSTRAINT `togtype_togrute_foreign` FOREIGN KEY(`TogRute`) REFERENCES `Togruter`(`endestasjonen`);
ALTER TABLE
    `Togruter` ADD CONSTRAINT `togruter_med eller mot banestrekning_foreign` FOREIGN KEY(`Med eller mot banestrekning`) REFERENCES `Ordre`(`TogRute`);
ALTER TABLE
    `Jernbanestasjon` ADD CONSTRAINT `jernbanestasjon_tilhørende banestrekning_foreign` FOREIGN KEY(`Tilhørende banestrekning`) REFERENCES `banestrekninger`(`StarterStasjon`);