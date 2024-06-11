--Oppgave 1
--a)
--Dette kan man gjøre ved hjelp av cascade og fremmednøkkel. 
--Cascade oppdaterer fremmednøkkelen hvis personen endrer sin nøkkel. 
--Ikke alle systemer har støtte for Cascade.

--b) 
-- Se vedlagt bilde

--c)
INSERT INTO artist VALUES (1, "Dua Lipa"); 
INSERT INTO artist VALUES (2, "DaBaby"); 
INSERT INTO album VALUES (1, "Future Nostalgia", 2022, 1);
INSERT INTO song VALUES (1, "Levitating", 203, 2022, 1);
INSERT INTO songOnAlbum VALUES (1, 1);
INSERT INTO featuredOn VALUES (2, 1);    

--d)
UPDATE artistset name = "Jonathan Lyndale Kirk"; 
WHERE artistID = 2

--e)
DELETE FROM artist
WHERE name = "Jonathan Lyndale Kirk"

--Oppgave 2
--a) 
SELECT songID, name, duration, year,  artistID
	FROM song 

--b)
SELECT name, year
FROM album 
WHERE album.year < 2017  

--c)
SELECT name, year
FROM album 
WHERE album.year <2021 AND album.year>2017
ORDER BY album.year ASC 

--d)
-- usikker på om den er riktig 
SELECT artist.name, song.name
FROM artist as  A INNER JOIN featuredOn USING artistID
FROM A as B INNER JOIN song USING songID
ORDER BY artist.name, song.name ASC

--option 2: 
SELECT artist.name, song.name
FROM featuredOn
INNER JOIN artist ON featuredOn.artistID=artist.artistID
INNER JOIN song ON featuredOn.songID=song.songID;
ORDER BY artist.name, song.name ASC

--e)
SELECT song.name, album.name, song.year
FROM song
INNER JOIN album ON (album.artistID = song.artistID)
INNER JOIN artist ON (song.artistID = artist.artistID)
WHERE artist.name = "Ariana Grande"
ORDER by song.year, album.name, song.name ASC

--f)
SELECT song.name,  artist.name 
FROM artist 
INNER JOIN featuredOn ON (featuredOn.artistID = artist.artistID and artist.name ="Ty Dolla Sign") 
INNER JOIN song ON (artist.artistID = song.artistID or featuredOn.songID = song.songID)
ORDER by artist.name, song.name ASC

--g)
SELECT artist.name, song.name
FROM artist
INNER JOIN song on (artist.artistID = song.artistID)
where song.name like '%the%'

--f)- ikke ferdig 
SELECT artist.name, count(*) 
FROM artist
INNER JOIN featuredOn on (artist.artistID = featuredOn.artistID)

--3)
--a)
SELECT artist.name AS artistName, song.name AS songName
FROM song
LEFT JOIN songOnAlbum ON song.songID = songOnAlbum.songID
JOIN artist ON song.artistID = artist.artistID
WHERE albumID IS NULL

--b)
SELECT artist.name AS artistName, song.name AS songName
FROM featuredOn
INNER JOIN song ON featuredOn.songID = song.songID
JOIN artist ON featuredOn.artistID = artist.artistID
WHERE (artist.name LIKE 'B%') OR (song.year BETWEEN 2000 AND 2009)

--c)
SELECT artist.name AS artistName, COUNT(song.songID) AS numSongs
FROM song
JOIN artist ON song.artistID = artist.artistID
GROUP BY song.artistID
ORDER BY numSongs DESC

--4)
--a)
--vi må oppdatere directorID, directorName, og directorBirthYear). Det er 4 kolonner, og 
--siden det er 3 rader av denne regissøren må vi oppdatere 3*4=12 celler

/*
░█─▄▀ █▀▀█ █▀▄▀█ █▀▄▀█ █▀▀ █▀▀▄ ▀▀█▀▀ █▀▀█ █▀▀█ 
░█▀▄─ █──█ █─▀─█ █─▀─█ █▀▀ █──█ ──█── █▄▄█ █▄▄▀ 
░█─░█ ▀▀▀▀ ▀───▀ ▀───▀ ▀▀▀ ▀──▀ ──▀── ▀──▀ ▀─▀▀
-----------------------------------------------


-----------------------------------------------*/


--b)
--forslag: 
--film (filmID, name, year, directorID)
--director (directorID, directorName, directorBirthYear)

--5)
--a)
--1) A -> A Ja, forsi a alltid er lik som seg selv 

--2) A -> B Stemmer ikke, siden de tre siste radene ikke samsvarer med dette. Når A er a3
--er b både b3 og b4, og B er også b4 når a er a4. 

--3) A -> C- Dette stemmer. Alle c-ene i tabeller har samme nummer som sine a-er. 

--4) AB -> C- Kan stemme. I tabellen er det ingen c-verdier som har forskjellige verdier 
--for samme kombinasjon av AB 

--5) C -> D- Stemmer ikke. Eksempelvis er c1 både d1 og d1 i rad 1 og 2. 

--6) D -> C- Det er rader i tabellen
--med forskjellige d- verdier til samme c- verdi så denne stemmer ikke.m

--7) ABCD er en supernøkkel for tabellen- stemmer ikke

--8) ABC er en supernøkkel for tabellen- kan stemme, 
--da det ikke finnes noen duplikater i ABC-kolonnen, og dermed vil 
--ABC-kolonnen være unik for hver rad i tabellen.

--9) D er en kandidatnøkkel for tabellen- usant, siden det finnes duplikater i d-kolonnen

--10) ABD er en kandidatnøkkel for tabellen- sant, det finnes ingen duplikater av 
--abd i tabellen 
