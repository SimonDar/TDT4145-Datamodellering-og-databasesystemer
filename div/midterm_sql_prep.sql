SELECT Regnr, Navn, Rase
FROM Hund
WHERE Pnr = 1 OR Pnr = 2;


--Distinct fjerne duplikater
select DISTINCT navn
from Hund

--% er samme som * i bash
select DISTINCT rase
from Hund
Where rase Like "P%"



--Spørring med on 
SELECT Hund.Regnr, Navn 
FROM Hund INNER JOIN BittAv ON Hund.Regnr = BittAv.Regnr 
WHERE Rase = ’Schæfer’ 

--Alternativ med naturlig join 
SELECT Hund.Regnr, Navn 
FROM Hund 
NATURAL INNER JOIN BittAv 
WHERE Rase = ’Schæfer’ 

--Alternativ med using 
SELECT Hund.Regnr, Navn 
FROM Hund INNER JOIN BittAv USING Regnr 
WHERE Rase = ’Schæfer’

select peron.pnr as pnr, person.navn as pnavn, hund.regnr as regnr, hund.navn as hnavn
from hund
inner join person on hund.eierpnr = person.regn
inner join BittAv on hund.eierpnr = bittav.Pnr
where   blittav.pnr = bittav.regnr;

SELECT distingt avn, rase
From Hund
CROSS JOIN Hund 