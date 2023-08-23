# Notason

## x: Databaseobjekt, post eller blokk
	
	r(x): read - leser x
	w(x): skriver - skriver til x
	c: commit
	a: abort

# errorer

## Dirty read: 
	Leser data som ikke er blitt commitet

## lost update: 
Det blir T2 som får data i databasern, T1 blir lost 

				T1: W1(a)				W1(b)C	
				T2:			W2(a)W2(b)C

## Unrepeatable read: 
	Dataen blir endret mellom to ganger en leser den.


## Incorect summerary: 
	En person gjør beregninger på dataen som en annen gjør oppdateringer på

# Recovery - egenslaåer
**Strict > aca > Gjennoppretbar > alle**
## Strict: 
	Hverken lese eller skrive til data som er endret av transaksjoner som ikke er commitet. 

## ACA: 
	Kan ikke lese fra data til tranaskasjoner som ikke er commitet. 

## Gjenopprettbar: 
	Transaksjoner som leser endringer gjort av andre, må committe etter de andre.
	
	Den som først leser av en verdi som er endret, er den siste til å committe hvis de T går til 2

## Ikke - gjennnopprettbar
	Tilfredstiller ingen av de over

# Serialiserbarhet

## Seriell historie
Ingen fletting av tranaksjoner, personer gjør endringer sekvensielt
		
		T1 -> T2 -> T3 -> ... -> Tn

## Serielserbar historie
	Kjører som om den skulle vært seriell. Dette finner en ut av om den er konflikt-serialiserbar

## Presedensgraf

<img src="https://i.imgur.com/Iz0Sx9z.png"/>


# Låser
En måte å få til serialiserbarheter, er å bruke låser.
Setter transaksjoner låst i blokker/klosser.

	Hvis en setter Read/Write-locked på en blokk. Så kan ingen skrive til den når en er ferdig med å lese

## Read_Lock(x)
	Delt låst. Flere transaksjoner kan sette Read_Lock sammtidig
## Write_Lock(x)
	Write_Lock er ekslusiv, bare en som kan sette den om gangen. 

## 2PL - ToFaseLåsing
	Alle låse opperasjoner skjer før alle opplåsningssituvasjoner.
	2PL impliserer serialiserbarhet

- Basic
- Konservativ
- Strict
- Rigoroless

## Basic
1. låser igjen fortløpende
2. låser opp forløpende

## Konservativ
1. Låser igjen alle momentalt
2. låser opp forløpende

## Strict
1. låser igjen fortløpende
2. oppløse leselåser gradvis 
3. oppløse skrivelpser mpmentalt

## Rigorous
1. Låser gradvis igjen
2. Låser opp alt på en gang

<img src="https://i.imgur.com/zw0zluf.png"/>

## Vranglås
	To eller flere transasksjoner venter på hverandre.

kan løses på tre måter
- Unngå vrangslås
- Oppdage vranglås
- Timeout
\

		Når en committer, så slipper den låsene sine.

# Recovery og ARIES
Transaksjoner
- Atomic -> Enten kjører hele transaksjonen eller ingenting
- Consistency 
- Isolation
- Durability -> Når den har commitet så skal den være der.

## Ved kærsj
>Vinnere er de som har fått gjort commiten

>Tapere som ikke får commitet må aborteres

## ARIES
Algoritme for recovery. Aries logger underveis.

***ARIES = No-Steal og steal*** 

	Dette betyr at transaksjoner må ikke skrives til disk en gang, men den kan skrive til disken hvis arbeidsminnet blir fult, selcom de ikke er commitet.




en loggpost = en endring

	Force = Transaksjoner som er commitet må skrives til disk med en gang. Tryggere

	no-Force = Ikke må skrives til disk med en gang. Kjappere

	Stael = Hvis arbeidsminnet er fult, så kan du stjele plass i arbeidsminnet, ved å skrive transaksjoner som ikke er commitet til disk likevell
	
	no-Steal = Ikke skrivver transasksjoner til disk som ikke er commitet. 


## WAL
Write-Ahead logging
		
	Hver endring en gjør i ARIES lagres i loggen


Regler
- Skriver loggpost til disken før en skrive datablokken.
- Skriver loggen til disk før en transaksjons comitter.

## WAL i ARIES
	LSN: loggsekvensnr
	
	Denne skrives som poster

	Flushed LSN: LSN nr til nyeste skrevede loggpost til disk

	Datablogg innholder pageLSN
	PageLSN: LSN nr til siste endring i en spesifikk blikk. 

	Transaksjonstabell vil ha et element per aktive transaksjon
	
	Dirty Page Table: Et element per "skitten blokk" i bufferet
	Skitten blokk: 