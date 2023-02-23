/*
████████  █████  ███████ ██   ██      ██ 
   ██    ██   ██ ██      ██  ██      ███ 
   ██    ███████ ███████ █████        ██ 
   ██    ██   ██      ██ ██  ██       ██ 
   ██    ██   ██ ███████ ██   ██      ██                                          
*/


------------ Question A Start ------------
/*
By using foreign key konstants, one will delete relations 
of a atribude when using "on delete cascade"
*/

------------ Question B Start ------------


CREATE TABLE artist(
    artistID    INT NOT NULL,
    name       VARCHAR(256) NOT NULL,

    CONSTRAINT artistPK PRIMARY KEY (artistID)
);

CREATE TABLE album(
    albumID     INT NOT NULL,
    name        VARCHAR(256) NOT NULL,
    year       INT NOT NULL,
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
    name       VARCHAR(256) NOT NULL,
    duration   INT NOT NULL,
    year       INT NOT NULL,
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

------------ Question C Start ------------
INSERT INTO artist VALUES(1, "Da Lipa");
INSERT INTO artist VALUES(2, "DaBaby");
INSERT INTO album VALUES(1, "Future Nostalgia", 2022, 1);
INSERT INTO song VALUES(1, "Levitating", 203, 2022, 1);
INSERT INTO songOnAlbum VALUES(1, 1);
INSERT INTO featuredOn VALUES(2, 1);


------------ Question D Start ------------
UPDATE artist 
SET name = "Jonathan Lyndale Kirk" 
WHERE artistID = 2;

------------ Question E Start ------------
DELETE FROM artist
WHERE artistID = 2;




/*
████████  █████  ███████ ██   ██     ██████  
   ██    ██   ██ ██      ██  ██           ██ 
   ██    ███████ ███████ █████        █████  
   ██    ██   ██      ██ ██  ██      ██      
   ██    ██   ██ ███████ ██   ██     ███████ 
                                             
*/

------------ Question A Start ------------
SELECT songID, name, duration, year, artistID FROM song;

------------ Question B Start ------------
SELECT name, year FROM album WHERE year < 2017; 

------------ Question C Start ------------
SELECT name, year FROM song WHERE 2018 < year AND year <= 2020; 

------------ Question D Start ------------
SELECT artist.name, song.name
FROM featuredOn
INNER JOIN artist ON featuredOn.artistID=artist.artistID
INNER JOIN song ON featuredOn.songID=song.songID
ORDER BY artist.name, song.name ASC;

------------ Question E Start ------------
SELECT DISTINCT song.name as songName, album.name as albumName, song.year
FROM song
INNER JOIN album ON song.artistID = album.artistID
INNER JOIN artist ON song.artistID = artist.artistID
WHERE artist.name = "Ariana Grande"
ORDER BY song.year, album.name, song.name  DESC;

------------ Question F Start ------------
SELECT song.name as songName, artist.name as artistName
FROM artist
INNER JOIN song on artist.artistID = song.artistID 
INNER JOIN featuredOn on featuredOn.artistID = artist.artistID
WHERE artist.name = "Ty Dolla Sign"
ORDER BY artist.name, song.name ASC;

------------ Question G Start ------------
SELECT song.name as songName, artist.name as artistName
FROM album 
INNER JOIN  song ON album.artistID = song.artistID
INNER JOIN artist ON album.artistID = artist.artistID
WHERE song.name = "%the%";

------------ Question A Start ------------
SELECT artist.name, count(featuredOn.artistID) as amount
FROM featuredOn
INNER JOIN artist ON featuredOn.artistID = artist.artistID
GROUP BY artist.name
ORDER by amount DESC;




/*
████████  █████  ███████ ██   ██     ██████  
   ██    ██   ██ ██      ██  ██           ██ 
   ██    ███████ ███████ █████        █████  
   ██    ██   ██      ██ ██  ██           ██ 
   ██    ██   ██ ███████ ██   ██     ██████                                                                                 
*/

------------ Question A Start ------------
DROP TABLE songsWithoutAlbums; --ikke den av oppgaven, men har med for å kunne kompilere flere ganger
CREATE TABLE songsWithoutAlbums as
SELECT artist.name AS artistName, song.name AS songName
FROM song
LEFT JOIN songOnAlbum ON song.songID = songOnAlbum.songID
JOIN artist ON song.artistID = artist.artistID
WHERE albumID IS NULL;
    


------------ Question B Start ------------
SELECT artist.name AS artistName, song.name AS songName, song.year as songYear
FROM featuredOn
INNER JOIN song ON featuredOn.songID = song.songID
JOIN artist ON featuredOn.artistID = artist.artistID
WHERE  2000 <= song.year AND song.year <= 2009
    OR artist.name LIKE 'B%';


------------ Question C Start ------------
SELECT artist.name AS artistName, COUNT(song.songID) AS numSongs
FROM song
JOIN artist ON song.artistID = artist.artistID
GROUP BY song.artistID
ORDER BY numSongs DESC;




/*
████████  █████  ███████ ██   ██     ██   ██ 
   ██    ██   ██ ██      ██  ██      ██   ██ 
   ██    ███████ ███████ █████       ███████ 
   ██    ██   ██      ██ ██  ██           ██ 
   ██    ██   ██ ███████ ██   ██          ██ 
*/


------------ Question A Start ------------
/*
We would need to change eight  cells, four cells chaing 
the year, and four cells chaning the name.
*/


------------ Question B Start ------------
/*
We could implement a directorDatabase
*/
CREATE TABLE director(
    directorID          INT NOT NULL,
    directorName        VARCHAR(256) NOT NULL,
    directorBirthYear   INT NOT NULL,

    CONSTRAINT directorNamePK PRIMARY KEY (directorNameID),
);




/*
████████  █████  ███████ ██   ██     ███████ 
   ██    ██   ██ ██      ██  ██      ██      
   ██    ███████ ███████ █████       ███████ 
   ██    ██   ██      ██ ██  ██           ██ 
   ██    ██   ██ ███████ ██   ██     ███████ 
*/

------------ Question A Start ------------
/*
Q1: A -> A
A1: Yes - An = An
A2: A -> A Ja, forsi a alltid er lik som seg selv 

Q2: A-> B
A1: No An =/= Bn 
A2: A -> B Stemmer ikke, siden de tre siste radene ikke samsvarer med dette. Når A er a3er b både b3 og b4, og B er også b4 når a er a4. 

Q3: A-> C
A1: Yes Cn = An
A2: A -> C- Dette stemmer. Alle c-ene i tabeller har samme nummer som sine a-er. 

Q4: AB -> C
A1: No, if Cn = An * Bn * Kn 
A2: AB -> C- Kan stemme. I tabellen er det ingen c-verdier som har forskjellige verdier  for samme kombinasjon av AB 

Q5: C -> D
A1: No Cn =/= Dn
A2: C -> D- Stemmer ikke. Eksempelvis er c1 både d1 og d1 i rad 1 og 2. 

Q6: D -> C
A1: No Dn =/= Cn
A2: D -> C- Det er rader i tabellen med forskjellige d- verdier til samme c- verdi så denne stemmer ikke.m

Q7:     ABCD is a superkey for the table
A:      ABCD er en supernøkkel for tabellen- stemmer ikke

Q8:     ABC is a superkey for the table
A:      ABC er en supernøkkel for tabellen- kan stemme, da det ikke finnes noen duplikater i ABC-kolonnen, og dermed vil ABC-kolonnen være unik for hver rad i tabellen.

Q9:     D is a candidate key for the table
A:      D er en kandidatnøkkel for tabellen- usant, siden det finnes duplikater i d-kolonnen

Q10:    ABD is a candidate key for the table
A:      ABD er en kandidatnøkkel for tabellen- sant, det finnes ingen duplikater av abd i tabellen 
/*


------------ Question B Start ------------
Given the table R = {A, B, C, D} and F = {D -> A, B-> D, ABD -> C}.
Find D+, BC+, AB+, BD+. How many candidate keys does R have?

D+  =    D -> A     =   {A, D}
BC+ =       =   ABCD
AB+ =       =   ABCD
BD+ =       =   ABCD

