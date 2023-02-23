--a)

DROP TABLE songsWithoutAlbums;
CREATE TABLE songsWithoutAlbums as
SELECT artist.name AS artistName, song.name AS songName
FROM song
LEFT JOIN songOnAlbum ON song.songID = songOnAlbum.songID
JOIN artist ON song.artistID = artist.artistID
WHERE albumID IS NULL;
    


--b)
SELECT artist.name AS artistName, song.name AS songName
FROM featuredOn
INNER JOIN song ON featuredOn.songID = song.songID
JOIN artist ON featuredOn.artistID = artist.artistID
WHERE (artist.name LIKE 'B%') OR (song.year BETWEEN 2000 AND 2009);

--c)
SELECT artist.name AS artistName, COUNT(song.songID) AS numSongs
FROM song
JOIN artist ON song.artistID = artist.artistID
GROUP BY song.artistID
ORDER BY numSongs DESC;