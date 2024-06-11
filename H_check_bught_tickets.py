import sqlite3

from datetime import datetime
import argparse
import time
import sys
import re
from enum import Enum
import hashlib

def Sha512Hash(Password):
    return(hashlib.sha512(Password.encode('utf-8')).hexdigest())




db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser(
                    prog='Billet Sjekker',
                    description='Sjekker info om billeter',
                    epilog='Her kan du enten se enkel info eller full info. en må sende med informasjon med argumenter, se --help eller -h for guide')
parser.add_argument('--kundeID', type=int, required=True, help="Skirv talllet for din kunde ID")  
parser.add_argument('--passord', type=str, required=True, help="passord, dette skal være lukket innen \" \", eksepem \"Dette er mitt passord\"")  
parser.add_argument('--allinfo', type=bool, required=False, default=False, help='Ved å sette flag til True, vil du få full info')  

args = parser.parse_args()

#Tanken var SQL sanitaion. Men ser ut argparse allerede fjerner noen av de farligste karkaterene 
inputsSTR=[args.passord]
WhiteList =[
"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","æ","ø","å","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","æ","ø","å","0","1","2","3","4","5","6","7","8","9","@",".","+"," ","_"]

for element in inputsSTR:
    for charakter in range(0, len(element)):
        if(element[charakter] not in WhiteList):
            sys.exit()

db.execute("SELECT Passord FROM Kunde WHERE IDkunde = {}".format(args.kundeID))
passwordFromDatabase = db.fetchone()

if(passwordFromDatabase == None):
    print("Ingen bruker funnet")
    sys.exit()

if (Sha512Hash(args.passord) != passwordFromDatabase[0]):
    print("Feil passord")
    sys.exit() 


if(args.allinfo):
    def unixToDateInTupple(typple):
        lst = list(typple)
        lst[4] = str(datetime.fromtimestamp(int(typple[4])))
        lst[7] = str(datetime.fromtimestamp(int(typple[7])))
        lst[8] = str(datetime.fromtimestamp(int(typple[8])))
        return lst

    db.execute("SELECT OkuperteSeter.IDordre, OkuperteSeter.IDstrekning, OkuperteSeter.Plassnr, OkuperteSeter.Sengeplass, Ordre.UnixKjopt, Ordre.IDkunde, Strekning.IDtogrute, Strekning.UnixAnnkomst, Strekning.UnixAvgang FROM OkuperteSeter  INNER JOIN Ordre ON Ordre.IDordre = OkuperteSeter.IDordre INNER JOIN Strekning ON Strekning.IDstrekning = OkuperteSeter.IDstrekning where IDkunde = {} ORDER BY Strekning.UnixAvgang DESC;".format(args.kundeID))
    allkundeinfo = db.fetchone()

    if(allkundeinfo == None):
        print("Ingen info funnet om kunde med ID, Bruk G_kjop_billett for å gjøre ditt første kjøp")
        sys.exit()

    print("(OkuperteSeter, IDordre, IDstrekning, Plassnr, Sengeplass, UnixKjopt, IDkunde, IDtogrute, UnixAnnkomst, UnixAvgang)")
    while(allkundeinfo != None):
        print(unixToDateInTupple(allkundeinfo))
        allkundeinfo = db.fetchone()
else:
    curentUnixTime = 1679577000#int(time.time())

    db.execute("SELECT DISTINCT Ordre.IDordre, Plassnr FROM OkuperteSeter INNER JOIN Ordre ON Ordre.IDordre = OkuperteSeter.IDordre INNER JOIN Strekning ON Strekning.IDstrekning = OkuperteSeter.IDstrekning where IDkunde = {} and Strekning.UnixAnnkomst >= {} ORDER BY Strekning.UnixAvgang, OkuperteSeter.IDordre ASC;".format(args.kundeID, curentUnixTime))
    ListMedIDordreOgPlassnr = db.fetchall()

    for spesifikkOrdre in ListMedIDordreOgPlassnr:
        db.execute("SELECT MIN(Strekning.UnixAvgang), MAX(Strekning.UnixAnnkomst) FROM OkuperteSeter INNER JOIN Strekning ON Strekning.IDstrekning = OkuperteSeter.IDstrekning WHERE OkuperteSeter.IDordre = {} ".format(spesifikkOrdre[0]))
        TogTider = db.fetchone()

        db.execute("SELECT CASE WHEN Togrute.Hovedretning = 1 THEN Delstrekning.StasjonFra ELSE Delstrekning.StasjonTil END as 'Start' FROM Strekning INNER JOIN Togrute ON Strekning.IDtogrute = Togrute.IDtogrute INNER JOIN Delstrekning on Strekning.IDdelStrekning = Delstrekning.IDdelStrekning where Strekning.UnixAvgang={};".format(TogTider[0]))

        stasjonNavnFra = db.fetchone()

        db.execute("SELECT CASE WHEN Togrute.Hovedretning = 0 THEN Delstrekning.StasjonFra ELSE Delstrekning.StasjonTil END as 'Slutt' FROM Strekning INNER JOIN Togrute ON Strekning.IDtogrute = Togrute.IDtogrute INNER JOIN Delstrekning on Strekning.IDdelStrekning = Delstrekning.IDdelStrekning where Strekning.UnixAnnkomst={};".format(TogTider[1]))

        stasjonNavnTil = db.fetchone()

        print("\n\nOrdreID: ", spesifikkOrdre[0], "\t Plass på toget: ", spesifikkOrdre[1])
        print("Avgang:\t\t",datetime.fromtimestamp(TogTider[0]),"\t", stasjonNavnFra[0])
        print("Annkomst:\t",datetime.fromtimestamp(TogTider[1]),"\t", stasjonNavnTil[0])


    