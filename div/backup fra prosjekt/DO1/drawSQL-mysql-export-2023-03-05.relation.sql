CREATE TABLE `table_7`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT
);
ALTER TABLE
    `table_7` ADD PRIMARY KEY `table_7_id_primary`(`id`);
CREATE TABLE `Togrute`(
    `IDtogrute` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `IDoperator` BIGINT NOT NULL,
    `MedBaneRetning` TINYINT(1) NOT NULL,
    `ID` BIGINT NULL
);
ALTER TABLE
    `Togrute` ADD PRIMARY KEY `togrute_idtogrute_primary`(`IDtogrute`);
CREATE TABLE `banestrekning`(
    `IDbanestrekning` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `IDjernbanestasjon` INT NOT NULL,
    `NavnBanestrekning` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `banestrekning` ADD PRIMARY KEY `banestrekning_idbanestrekning_primary`(`IDbanestrekning`);
ALTER TABLE
    `banestrekning` ADD UNIQUE `banestrekning_idjernbanestasjon_unique`(`IDjernbanestasjon`);
CREATE TABLE `jernbanestasjon`(
    `IDjernbanestasjon` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `Geoposisjon` GEOMETRY NOT NULL,
    `NavnJernbanestasjon` VARCHAR(255) NOT NULL,
    `MeterOverHavet` INT NOT NULL
);
ALTER TABLE
    `jernbanestasjon` ADD PRIMARY KEY `jernbanestasjon_idjernbanestasjon_primary`(`IDjernbanestasjon`);
CREATE TABLE `Tidstabell`(
    `IDtidstabell` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `IDrute` BIGINT NOT NULL,
    `IDjernbanestasjon` BIGINT NOT NULL,
    `Klokkeslett` BIGINT NOT NULL,
    `Avgang` TINYINT(1) NOT NULL
);
ALTER TABLE
    `Tidstabell` ADD PRIMARY KEY `tidstabell_idtidstabell_primary`(`IDtidstabell`);
CREATE TABLE `RuteFinner`(
    `IDtogrute` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `FraStasjon` BIGINT NOT NULL,
    `TilStasjon` BIGINT NOT NULL
);
CREATE TABLE `Operator`(
    `IDoperator` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `NavnOperator` BIGINT NOT NULL
);
ALTER TABLE
    `Operator` ADD PRIMARY KEY `operator_idoperator_primary`(`IDoperator`);