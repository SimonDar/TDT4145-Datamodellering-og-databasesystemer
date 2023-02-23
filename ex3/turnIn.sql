----Task 2----

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



----Task 2----

--Question A
SELECT songID, name, duration, year, artistID FROM song;

--Question B
SELECT name, year FROM album WHERE year < 2017; 

--Question C
SELECT name, year FROM song WHERE 2018 < year AND year <= 2020; 

--Question D
SELECT artist.name, song.name
FROM featuredOn
INNER JOIN artist ON featuredOn.artistID=artist.artistID
INNER JOIN song ON featuredOn.songID=song.songID
ORDER BY artist.name, song.name ASC;

--Question E
SELECT DISTINCT song.name as songName, album.name as albumName, song.year
FROM song
INNER JOIN album ON song.artistID = album.artistID
INNER JOIN artist ON song.artistID = artist.artistID
WHERE artist.name = "Ariana Grande"
ORDER BY song.year, album.name, song.name  DESC;

--Question F
SELECT song.name as songName, artist.name as artistName
FROM artist
INNER JOIN song on artist.artistID = song.artistID 
INNER JOIN featuredOn on featuredOn.artistID = artist.artistID
WHERE artist.name = "Ty Dolla Sign"
ORDER BY artist.name, song.name ASC;

--Question G
SELECT song.name as songName, artist.name as artistName
FROM album 
INNER JOIN  song ON album.artistID = song.artistID
INNER JOIN artist ON album.artistID = artist.artistID
WHERE song.name = "%the%";

--Question H
SELECT artist.name, count(featuredOn.artistID) as amount
FROM featuredOn
INNER JOIN artist ON featuredOn.artistID = artist.artistID
GROUP BY artist.name
ORDER by amount DESC;

----Task 3----

----Task 4----


--Qustion A

/*
We would need to change eight  cells, four cells chaing 
the year, and four cells chaning the name.
*/

--Question B

/*
We could implement a directorDatabase
*/


CREATE TABLE director(
    directorID          INT NOT NULL,
    directorName        VARCHAR(256) NOT NULL,
    directorBirthYear   INT NOT NULL,

    CONSTRAINT directorNamePK PRIMARY KEY (directorNameID),
);

----Task 5----

/*
Q1: A -> A
A:Yes - An = An

Q2: A-> B
A:No An =/= Bn 

Q3: A-> C
A:Yes Cn = An

Q4: AB -> C
A:No, if Cn = An * Bn * Kn 

Q5: C -> D
A:No Cn =/= Dn

Q6: D -> C
A:No Dn =/= Cn

Q7: ABCD is a superkey for the table
A:True

Q8: ABC is a superkey for the table
A:

Q9: D is a candidate key for the table
A:

Q:10 ABD is a candidate key for the table
A:

*/


--Question B