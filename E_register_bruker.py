import sqlite3

from datetime import datetime
import argparse
import time
import sys
import re
import hashlib

def Sha512Hash(Password):
    return(hashlib.sha512(Password.encode('utf-8')).hexdigest())

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--Navn', type=str, required=True, help= "passord, dette skal være lukket innen \" \", eksepem \"pom pom purin\"")  
parser.add_argument('--Epost', type=str, required=True, help ="Skriv inn eposten din")  
parser.add_argument('--Telefon', type=int, required=True, help="skriv inn telefonummeret ditt som tall. skal du ha med ladskode, bruk 00 istenfor +")  
parser.add_argument('--Passord', type=str, required=True, help="passord, dette skal være lukket innen \" \", eksepem \"Dette er mitt passord\"")  
args = parser.parse_args()

#Ja, vi tillater en person med samme info å ha flere brukere. Dette er fordi en kanskje
#Vil lage en konto til unga med under eget navn grunet jurudisk. 

db.execute("SELECT MAX(IDkunde) FROM Kunde")

NyKundeID = db.fetchone()
if(NyKundeID[0] == None):
    NyKundeID = [0]
    print("Gratulerer som vår første bruker! Bruk rabattkode: TDT4145 for 41.45 kroner av ditt første kjøp")

KryptertPassord = Sha512Hash(args.Passord)

db.execute("INSERT INTO Kunde VALUES({0},'{1}','{2}',{3}, '{4}');".format(NyKundeID[0]+1, args.Navn, args.Epost, args.Telefon , KryptertPassord))

db_connect.commit()

print("Gratulerer {}, du er nå registert med kundeID: {}, du kan finne kundeID på hjemmesiden(som ikke eksisterer foreløpig ;)) du kommer til å bruke den senere.". format(args.Navn, NyKundeID[0]+1))

