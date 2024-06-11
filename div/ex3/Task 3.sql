--a)

DROP TABLE songsWithoutAlbums; --ikke den av oppgaven, men har med for å ikke måtte kommentere ut 4-9
CREATE TABLE songsWithoutAlbums as
SELECT artist.name AS artistName, song.name AS songName
FROM song
LEFT JOIN songOnAlbum ON song.songID = songOnAlbum.songID
JOIN artist ON song.artistID = artist.artistID
WHERE albumID IS NULL;
    


--b)
SELECT artist.name AS artistName, song.name AS songName, song.year as songYear
FROM featuredOn
INNER JOIN song ON featuredOn.songID = song.songID
JOIN artist ON featuredOn.artistID = artist.artistID
WHERE  2000 <= song.year AND song.year <= 2009
    OR artist.name LIKE 'B%';


--c)
SELECT artist.name AS artistName, COUNT(song.songID) AS numSongs
FROM song
JOIN artist ON song.artistID = artist.artistID
GROUP BY song.artistID
ORDER BY numSongs DESC;
