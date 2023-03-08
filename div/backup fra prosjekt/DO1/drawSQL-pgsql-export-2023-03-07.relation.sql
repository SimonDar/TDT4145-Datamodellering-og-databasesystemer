CREATE TABLE "Operator"(
    "IDtogrute" INTEGER NOT NULL,
    "IDoperator" INTEGER NOT NULL,
    "Vogntypeer" INTEGER NOT NULL
);
ALTER TABLE
    "Operator" ADD CONSTRAINT "operator_idtogrute_unique" UNIQUE("IDtogrute");
ALTER TABLE
    "Operator" ADD PRIMARY KEY("IDoperator");
CREATE TABLE "Ordre"(
    "IDordre" INTEGER NOT NULL,
    "UnixTid" INTEGER NOT NULL,
    "Setenr" INTEGER NOT NULL,
    "IDkunde" INTEGER NOT NULL
);
CREATE INDEX "ordre_idkunde_unixtid_index" ON
    "Ordre"("IDkunde", "UnixTid");
ALTER TABLE
    "Ordre" ADD PRIMARY KEY("IDordre");
CREATE INDEX "ordre_idkunde_index" ON
    "Ordre"("IDkunde");
CREATE TABLE "Kunderegister"(
    "IDoperator" INTEGER NOT NULL,
    "IDkunde" INTEGER NOT NULL
);
CREATE TABLE "Banestrekning"(
    "IDbaneStrekning" INTEGER NOT NULL,
    "NavnBaneStrekning" INTEGER NOT NULL
);
ALTER TABLE
    "Banestrekning" ADD PRIMARY KEY("IDbaneStrekning");
CREATE TABLE "Vognoppsett"(
    "IDvognOppsett" INTEGER NOT NULL,
    "IDtogrute" INTEGER NOT NULL,
    "AntallVogner" INTEGER NOT NULL,
    "AntallSoveplasser" INTEGER NOT NULL,
    "AntallSitteplasser" INTEGER NOT NULL,
    "totalplasser" INTEGER NOT NULL
);
ALTER TABLE
    "Vognoppsett" ADD PRIMARY KEY("IDvognOppsett");
ALTER TABLE
    "Vognoppsett" ADD CONSTRAINT "vognoppsett_idtogrute_unique" UNIQUE("IDtogrute");
CREATE TABLE "Togforekomst"(
    "IDtogrute" INTEGER NOT NULL,
    "klokkeslettStart" INTEGER NOT NULL,
    "man" BOOLEAN NOT NULL,
    "tir" BOOLEAN NOT NULL,
    "ons" BOOLEAN NOT NULL,
    "tor" BOOLEAN NOT NULL,
    "fre" BOOLEAN NOT NULL,
    "lor" BOOLEAN NOT NULL,
    "son" BOOLEAN NOT NULL
);
CREATE TABLE "OkuperteSeter"(
    "IDstrekning" INTEGER NOT NULL,
    "IDordre" INTEGER NOT NULL,
    "Setenummer" INTEGER NOT NULL
);
CREATE INDEX "okuperteseter_idstrekning_index" ON
    "OkuperteSeter"("IDstrekning");
CREATE INDEX "okuperteseter_idstrekning_index" ON
    "OkuperteSeter"("IDstrekning");
CREATE TABLE "Kunde"(
    "IDkunde" INTEGER NOT NULL,
    "NavnKunde" VARCHAR(255) NOT NULL,
    "Epost" VARCHAR(255) NOT NULL,
    "Telefon" INTEGER NOT NULL
);
ALTER TABLE
    "Kunde" ADD PRIMARY KEY("IDkunde");
CREATE TABLE "Togrute"(
    "IDtogrute" INTEGER NOT NULL,
    "IDbaneStrekning" INTEGER NOT NULL,
    "Hovedretning" BOOLEAN NOT NULL,
    "Hastighet" BIGINT NOT NULL
);
ALTER TABLE
    "Togrute" ADD PRIMARY KEY("IDtogrute");
CREATE TABLE "Strekning"(
    "IDtogrute" INTEGER NOT NULL,
    "IDstrekning" INTEGER NOT NULL,
    "Dag" INTEGER NOT NULL,
    "FirstStrekning" BOOLEAN NOT NULL,
    "IDdelstrekFra" INTEGER NOT NULL,
    "IDdelstrekTil" INTEGER NULL,
    "totalplasser" INTEGER NOT NULL
);
CREATE INDEX "strekning_idtogrute_idstrekning_index" ON
    "Strekning"("IDtogrute", "IDstrekning");
ALTER TABLE
    "Strekning" ADD PRIMARY KEY("IDstrekning");
CREATE TABLE "Delstrekning"(
    "IDdelStrekning" INTEGER NOT NULL,
    "AvstandKM" DOUBLE PRECISION NOT NULL,
    "Enkeltspor" BOOLEAN NOT NULL,
    "StasjonFirst" BOOLEAN NOT NULL,
    "StasjonFra" VARCHAR(255) NOT NULL,
    "StasjonTil" VARCHAR(255) NOT NULL
);
CREATE TABLE "VognTyoe"(
    "IDvognOppsett" INTEGER NOT NULL,
    "Sitteplass" BOOLEAN NOT NULL,
    "FirstVogn" BOOLEAN NOT NULL,
    "IDvognTypeNeste" INTEGER NULL
);
CREATE INDEX "vogntyoe_idvognoppsett_index" ON
    "VognTyoe"("IDvognOppsett");
CREATE INDEX "vogntyoe_idvognoppsett_index" ON
    "VognTyoe"("IDvognOppsett");
CREATE TABLE "Jernbanestasjon"(
    "IDbaneStrekning" INTEGER NOT NULL,
    "NavnStasjon" VARCHAR(255) NOT NULL,
    "MOH" INTEGER NOT NULL
);
ALTER TABLE
    "Jernbanestasjon" ADD PRIMARY KEY("NavnStasjon");
ALTER TABLE
    "OkuperteSeter" ADD CONSTRAINT "okuperteseter_idstrekning_foreign" FOREIGN KEY("IDstrekning") REFERENCES "Strekning"("IDstrekning");
ALTER TABLE
    "Delstrekning" ADD CONSTRAINT "delstrekning_stasjonfra_foreign" FOREIGN KEY("StasjonFra") REFERENCES "Jernbanestasjon"("NavnStasjon");
ALTER TABLE
    "Ordre" ADD CONSTRAINT "ordre_idkunde_foreign" FOREIGN KEY("IDkunde") REFERENCES "Kunde"("IDkunde");
ALTER TABLE
    "VognTyoe" ADD CONSTRAINT "vogntyoe_idvogntypeneste_foreign" FOREIGN KEY("IDvognTypeNeste") REFERENCES "VognTyoe"("IDvognOppsett");
ALTER TABLE
    "Kunderegister" ADD CONSTRAINT "kunderegister_idkunde_foreign" FOREIGN KEY("IDkunde") REFERENCES "Kunde"("IDkunde");
ALTER TABLE
    "Operator" ADD CONSTRAINT "operator_idtogrute_foreign" FOREIGN KEY("IDtogrute") REFERENCES "Togrute"("IDtogrute");
ALTER TABLE
    "Strekning" ADD CONSTRAINT "strekning_iddelstrekfra_foreign" FOREIGN KEY("IDdelstrekFra") REFERENCES "Delstrekning"("StasjonFra");
ALTER TABLE
    "OkuperteSeter" ADD CONSTRAINT "okuperteseter_setenummer_foreign" FOREIGN KEY("Setenummer") REFERENCES "Ordre"("Setenr");
ALTER TABLE
    "Togforekomst" ADD CONSTRAINT "togforekomst_idtogrute_foreign" FOREIGN KEY("IDtogrute") REFERENCES "Togrute"("IDtogrute");
ALTER TABLE
    "VognTyoe" ADD CONSTRAINT "vogntyoe_idvognoppsett_foreign" FOREIGN KEY("IDvognOppsett") REFERENCES "Vognoppsett"("IDvognOppsett");
ALTER TABLE
    "Kunderegister" ADD CONSTRAINT "kunderegister_idoperator_foreign" FOREIGN KEY("IDoperator") REFERENCES "Operator"("IDoperator");
ALTER TABLE
    "Delstrekning" ADD CONSTRAINT "delstrekning_stasjontil_foreign" FOREIGN KEY("StasjonTil") REFERENCES "Jernbanestasjon"("NavnStasjon");
ALTER TABLE
    "Jernbanestasjon" ADD CONSTRAINT "jernbanestasjon_idbanestrekning_foreign" FOREIGN KEY("IDbaneStrekning") REFERENCES "Banestrekning"("IDbaneStrekning");
ALTER TABLE
    "OkuperteSeter" ADD CONSTRAINT "okuperteseter_idordre_foreign" FOREIGN KEY("IDordre") REFERENCES "Ordre"("IDordre");
ALTER TABLE
    "Strekning" ADD CONSTRAINT "strekning_iddelstrektil_foreign" FOREIGN KEY("IDdelstrekTil") REFERENCES "Delstrekning"("StasjonTil");
ALTER TABLE
    "Strekning" ADD CONSTRAINT "strekning_totalplasser_foreign" FOREIGN KEY("totalplasser") REFERENCES "Vognoppsett"("totalplasser");
ALTER TABLE
    "Vognoppsett" ADD CONSTRAINT "vognoppsett_idtogrute_foreign" FOREIGN KEY("IDtogrute") REFERENCES "Togrute"("IDtogrute");
ALTER TABLE
    "Togrute" ADD CONSTRAINT "togrute_idbanestrekning_foreign" FOREIGN KEY("IDbaneStrekning") REFERENCES "Banestrekning"("IDbaneStrekning");
ALTER TABLE
    "Strekning" ADD CONSTRAINT "strekning_idtogrute_foreign" FOREIGN KEY("IDtogrute") REFERENCES "Togrute"("IDtogrute");