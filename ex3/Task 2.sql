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
SELECT song.name as songName, album.name as albumName, song.year
FROM song
INNER JOIN album ON song.artistID = album.artistID
INNER JOIN artist ON song.artistID = artist.artistID
WHERE artist.name = "Ariana Grande"
ORDER BY song.name, album.name, song.year DESC;

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
INNER JOIN  song ON album.songID = song.songID
INNER JOIN artist ON album.artistID = artist.artistID;