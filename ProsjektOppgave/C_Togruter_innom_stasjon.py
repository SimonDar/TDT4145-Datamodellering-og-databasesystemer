#For en stasjon som oppgis, skal bruker  få ut alle togruter som er innom stasjonen en gitt ukedag. Denne funksjonaliteten skal programmeres.

import sqlite3

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

db_connect.commit() #Kan hende ikke trengs å brukes hvis en kun leser av databasen. Men den må brukes ved skrving i databasen.