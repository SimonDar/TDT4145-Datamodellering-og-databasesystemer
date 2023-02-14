/*
Question A

By using foreign key konstants, one will delete relations 
of a atribude when using "on delete cascade"

*/


--Question B

CREATE TABLE artist(
    artistID    INT NOT NULL,
    name_       VARCHAR(256) NOT NULL,

    CONSTRAINT artistPK PRIMARY KEY (artistID)
);

CREATE TABLE album(
    albumID     INT NOT NULL,
    name_       VARCHAR(256) NOT NULL,
    year_       INT NOT NULL,
    artistID    INT NOT NULL,

    CONSTRAINT albumPK PRIMARY KEY (albumID),

    CONSTRAINT artistFK 
        FOREIGN KEY(artistID) 
        REFERENCES artist(artistID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE song(
    songID      INT NOT NULL,
    name_       VARCHAR(256) NOT NULL,
    duration_   INT NOT NULL,
    year_       INT NOT NULL,
    artistID    INT NOT NULL,

    CONSTRAINT songPK PRIMARY KEY (songID),

    CONSTRAINT artistFK 
        FOREIGN KEY(artistID) 
        REFERENCES artist(artistID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE 
);

CREATE TABLE featuredOn(
    artistID    INT NOT NULL,
    songID      INT NOT NULL,

    CONSTRAINT featuredOnPK PRIMARY KEY (artistID, songID),

    CONSTRAINT artistFK 
        FOREIGN KEY(artistID) 
        REFERENCES artist(artistID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,

    CONSTRAINT songFK 
        FOREIGN KEY(songID) 
        REFERENCES song(songID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE songOnAlbum(
    songID      INT NOT NULL,
    albumID     INT NOT NULL,

    CONSTRAINT songOnAlbumPK PRIMARY KEY (songID, albumID),
   
    CONSTRAINT songFK 
        FOREIGN KEY(songID) 
        REFERENCES song(songID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,

    CONSTRAINT artistFK 
        FOREIGN KEY(albumID) 
        REFERENCES album(albumID) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

--Question C


INSERT INTO artist VALUES(1, "Da Lipa");
INSERT INTO artist VALUES(2, "DaBaby");
INSERT INTO album VALUES(1, "Future Nostalgia", 2022, 1);
INSERT INTO song VALUES(1, "Levitating", 203, 2022, 1);
INSERT INTO songOnAlbum VALUES(1, 1);
INSERT INTO featuredOn VALUES(2, 1);


--Question D

UPDATE artist 
SET name_ = "Jonathan Lyndale Kirk" 
WHERE artistID = 2;

--Question E

DELETE FROM artist
WHERE artistID = 2;



