--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


DROP TABLE IF EXISTS Operator;
DROP TABLE IF EXISTS Ordre;
DROP TABLE IF EXISTS Kunderegister;
DROP TABLE IF EXISTS Banestrekning;
DROP TABLE IF EXISTS Vognoppsett;
DROP TABLE IF EXISTS Togforekomst;
DROP TABLE IF EXISTS OkuperteSeter;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Togrute;
DROP TABLE IF EXISTS Strekning;
DROP TABLE IF EXISTS Delstrekning;
DROP TABLE IF EXISTS VognTyoe;
DROP TABLE IF EXISTS Jernbanestasjon;
DROP INDEX IF EXISTS okuperteseter_idstrekning_index;
DROP INDEX IF EXISTS strekning_idtogrute_idstrekning_index;
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--DETTE OVER DENNE LINJEN !!MÅ!! FJENRES FØR VI STARTER PRAKTISK TESTING AV DATABASEN
--det er kun med for å kunne debugge denne spesifikke filen
--og vil slette ALT av innhold i databasene når den kjøres
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


CREATE TABLE Operator(
    IDtogrute INT NOT NULL,
    IDoperator INT NOT NULL,
    Vogntypeer INT NOT NULL,
    PRIMARY KEY(IDoperator),
    CONSTRAINT operator_idtogrute_unique UNIQUE(IDtogrute),
    CONSTRAINT operator_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute)
);


CREATE TABLE Ordre(
    IDordre INT NOT NULL,
    UnixTid INT NOT NULL,
    Setenr INT NOT NULL,
    IDkunde INT NOT NULL,
    PRIMARY KEY(IDordre),
    CONSTRAINT ordre_idkunde_foreign FOREIGN KEY(IDkunde) REFERENCES Kunde(IDkunde)
);
CREATE INDEX ordre_idkunde_unixtid_index ON
    Ordre(IDkunde, UnixTid);
CREATE INDEX ordre_idkunde_index ON
    Ordre(IDkunde);
CREATE TABLE Kunderegister(
    IDoperator INT NOT NULL,
    IDkunde INT NOT NULL,
    CONSTRAINT kunderegister_idkunde_foreign FOREIGN KEY(IDkunde) REFERENCES Kunde(IDkunde),
    CONSTRAINT kunderegister_idoperator_foreign FOREIGN KEY(IDoperator) REFERENCES Operator(IDoperator)
);
CREATE TABLE Banestrekning(
    IDbaneStrekning INT NOT NULL,
    NavnBaneStrekning INT NOT NULL,
    CONSTRAINT PKbaneStrekning PRIMARY KEY(IDbaneStrekning)
);

CREATE TABLE Vognoppsett(
    IDvognOppsett INT NOT NULL,
    IDtogrute INT NOT NULL,
    AntallVogner INT NOT NULL,
    AntallSoveplasser INT NOT NULL,
    AntallSitteplasser INT NOT NULL,
    totalplasser INT NOT NULL,
     PRIMARY KEY(IDvognOppsett),
     CONSTRAINT vognoppsett_idtogrute_unique UNIQUE(IDtogrute),
     CONSTRAINT vognoppsett_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute)
);

CREATE TABLE Togforekomst(
    IDtogrute INT NOT NULL,
    klokkeslettStart INT NOT NULL,
    man BOOLEAN NOT NULL,
    tir BOOLEAN NOT NULL,
    ons BOOLEAN NOT NULL,
    tor BOOLEAN NOT NULL,
    fre BOOLEAN NOT NULL,
    lor BOOLEAN NOT NULL,
    son BOOLEAN NOT NULL,
    CONSTRAINT togforekomst_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute)
);
CREATE TABLE OkuperteSeter(
    IDstrekning INT NOT NULL,
    IDordre INT NOT NULL,
    Setenummer INT NOT NULL,
    CONSTRAINT okuperteseter_idstrekning_foreign FOREIGN KEY(IDstrekning) REFERENCES Strekning(IDstrekning),
    CONSTRAINT okuperteseter_setenummer_foreign FOREIGN KEY(Setenummer) REFERENCES Ordre(Setenr),
    CONSTRAINT okuperteseter_idordre_foreign FOREIGN KEY(IDordre) REFERENCES Ordre(IDordre)
);
CREATE INDEX okuperteseter_idstrekning_index ON
    OkuperteSeter(IDstrekning);

CREATE TABLE Kunde(
    IDkunde INT NOT NULL,
    NavnKunde VARCHAR(255) NOT NULL,
    Epost VARCHAR(255) NOT NULL,
    Telefon INT NOT NULL,
    PRIMARY KEY(IDkunde)
);

CREATE TABLE Togrute(
    IDtogrute INT NOT NULL,
    IDbaneStrekning INT NOT NULL,
    Hovedretning BOOLEAN NOT NULL,
    Hastighet BIGINT NOT NULL,
    PRIMARY KEY(IDtogrute),
    CONSTRAINT togrute_idbanestrekning_foreign FOREIGN KEY(IDbaneStrekning) REFERENCES Banestrekning(IDbaneStrekning)
);

CREATE TABLE Strekning(
    IDtogrute INT NOT NULL,
    IDstrekning INT NOT NULL,
    Dag INT NOT NULL,
    FirstStrekning BOOLEAN NOT NULL,
    IDdelstrekFra INT NOT NULL,
    IDdelstrekTil INT NULL,
    totalplasser INT NOT NULL,
    PRIMARY KEY(IDstrekning),
    CONSTRAINT strekning_iddelstrekfra_foreign FOREIGN KEY(IDdelstrekFra) REFERENCES Delstrekning(StasjonFra),
    CONSTRAINT strekning_iddelstrektil_foreign FOREIGN KEY(IDdelstrekTil) REFERENCES Delstrekning(StasjonTil),
    CONSTRAINT strekning_totalplasser_foreign FOREIGN KEY(totalplasser) REFERENCES Vognoppsett(totalplasser),
    CONSTRAINT strekning_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute)
);
CREATE INDEX strekning_idtogrute_idstrekning_index ON
    Strekning(IDtogrute, IDstrekning);


CREATE TABLE Delstrekning(
    IDdelStrekning INT NOT NULL,
    AvstandKM INT NOT NULL,
    Enkeltspor BOOLEAN NOT NULL,
    StasjonFirst BOOLEAN NOT NULL,
    StasjonFra VARCHAR(255) NOT NULL,
    StasjonTil VARCHAR(255) NOT NULL,
    CONSTRAINT delstrekning_stasjonfra_foreign FOREIGN KEY(StasjonFra) REFERENCES Jernbanestasjon(NavnStasjon),
    CONSTRAINT delstrekning_stasjontil_foreign FOREIGN KEY(StasjonTil) REFERENCES Jernbanestasjon(NavnStasjon)
);
CREATE TABLE VognTyoe(
    IDvognOppsett INT NOT NULL,
    Sitteplass BOOLEAN NOT NULL,
    FirstVogn BOOLEAN NOT NULL,
    IDvognTypeNeste INT NULL,
    CONSTRAINT vogntyoe_idvogntypeneste_foreign FOREIGN KEY(IDvognTypeNeste) REFERENCES VognTyoe(IDvognOppsett),
    CONSTRAINT vogntyoe_idvognoppsett_foreign FOREIGN KEY(IDvognOppsett) REFERENCES Vognoppsett(IDvognOppsett)
);
CREATE INDEX vogntyoe_idvognoppsett_index ON
    VognTyoe(IDvognOppsett);

CREATE TABLE Jernbanestasjon(
    IDbaneStrekning INT NOT NULL,
    NavnStasjon VARCHAR(255) NOT NULL,
    MOH INT NOT NULL,
    PRIMARY KEY(NavnStasjon),
    CONSTRAINT jernbanestasjon_idbanestrekning_foreign FOREIGN KEY(IDbaneStrekning) REFERENCES Banestrekning(IDbaneStrekning)
);
/*
ALTER TABLE
    OkuperteSeter ADD CONSTRAINT okuperteseter_idstrekning_foreign FOREIGN KEY(IDstrekning) REFERENCES Strekning(IDstrekning);
ALTER TABLE
    Delstrekning ADD CONSTRAINT delstrekning_stasjonfra_foreign FOREIGN KEY(StasjonFra) REFERENCES Jernbanestasjon(NavnStasjon);
ALTER TABLE
    Ordre ADD CONSTRAINT ordre_idkunde_foreign FOREIGN KEY(IDkunde) REFERENCES Kunde(IDkunde);
ALTER TABLE
    VognTyoe ADD CONSTRAINT vogntyoe_idvogntypeneste_foreign FOREIGN KEY(IDvognTypeNeste) REFERENCES VognTyoe(IDvognOppsett);
ALTER TABLE
    Kunderegister ADD CONSTRAINT kunderegister_idkunde_foreign FOREIGN KEY(IDkunde) REFERENCES Kunde(IDkunde);
ALTER TABLE
    Operator ADD CONSTRAINT operator_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute);
ALTER TABLE
    Strekning ADD CONSTRAINT strekning_iddelstrekfra_foreign FOREIGN KEY(IDdelstrekFra) REFERENCES Delstrekning(StasjonFra);
ALTER TABLE
    OkuperteSeter ADD CONSTRAINT okuperteseter_setenummer_foreign FOREIGN KEY(Setenummer) REFERENCES Ordre(Setenr);
ALTER TABLE
    Togforekomst ADD CONSTRAINT togforekomst_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute);
ALTER TABLE
    VognTyoe ADD CONSTRAINT vogntyoe_idvognoppsett_foreign FOREIGN KEY(IDvognOppsett) REFERENCES Vognoppsett(IDvognOppsett);
ALTER TABLE
    Kunderegister ADD CONSTRAINT kunderegister_idoperator_foreign FOREIGN KEY(IDoperator) REFERENCES Operator(IDoperator);
ALTER TABLE
    Delstrekning ADD CONSTRAINT delstrekning_stasjontil_foreign FOREIGN KEY(StasjonTil) REFERENCES Jernbanestasjon(NavnStasjon);
ALTER TABLE
    Jernbanestasjon ADD CONSTRAINT jernbanestasjon_idbanestrekning_foreign FOREIGN KEY(IDbaneStrekning) REFERENCES Banestrekning(IDbaneStrekning);
ALTER TABLE
    OkuperteSeter ADD CONSTRAINT okuperteseter_idordre_foreign FOREIGN KEY(IDordre) REFERENCES Ordre(IDordre);
ALTER TABLE
    Strekning ADD CONSTRAINT strekning_iddelstrektil_foreign FOREIGN KEY(IDdelstrekTil) REFERENCES Delstrekning(StasjonTil);
ALTER TABLE
    Strekning ADD CONSTRAINT strekning_totalplasser_foreign FOREIGN KEY(totalplasser) REFERENCES Vognoppsett(totalplasser);
ALTER TABLE
    Vognoppsett ADD CONSTRAINT vognoppsett_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute);
ALTER TABLE
    Togrute ADD CONSTRAINT togrute_idbanestrekning_foreign FOREIGN KEY(IDbaneStrekning) REFERENCES Banestrekning(IDbaneStrekning);
ALTER TABLE
    Strekning ADD CONSTRAINT strekning_idtogrute_foreign FOREIGN KEY(IDtogrute) REFERENCES Togrute(IDtogrute);
*/