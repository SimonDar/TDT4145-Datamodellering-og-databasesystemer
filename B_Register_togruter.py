import sqlite3

from datetime import datetime
import argparse
import sys
from enum import Enum

class dagToUnix(Enum):
    Mandag = 0
    Tirdag = 24*60*60
    Onsdag = 24*60*60 * 2
    Tordag = 24*60*60 * 3
    Fredag = 24*60*60 * 4
    Lordag = 24*60*60 * 5
    Sondag = 24*60*60 * 6


db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--start', type=int, required=True, help="Tider generes uke for uke. for å genere en hel uke, må en mandag oppgis. tiden skal også være 00:00:00 lokal tid i norge som er GMT+1. UNIX tid for mandag 3. august 00:00:00 er: 1680476400")  
args = parser.parse_args()

if( (datetime.fromtimestamp(args.start).weekday() or (args.start - 82800) % 86400) != 0 ):
    print("The time you have sendt in, is not a monday, time also has to be 00:00")
    sys.exit()
   

print("You have typed in beginning date: ", datetime.fromtimestamp(args.start))


db.execute("SELECT * FROM Togforekomst")
#print("First row from table Vognoppsett:")

DelstrekningRute1 = [1,2,3,4,5]
TimeHardCodeRute1 = [
    7*60*60+49*60,
    9*60*60+51*60,
    13*60*60+20*60,
    14*60*60+31*60,
    16*60*60+49*60,
    17*60*60+34*60
]

DelstrekningRute2 = [1,2,3,4,5]
TimeHardCodeRute2 = [
    23*60*60+5*60,
    (24+0)*60*60+57*60,
    (24+4)*60*60+41*60,
    (24+5)*60*60+55*60,
    (24+8)*60*60+19*60,
    (24+9)*60*60+5*60
]

DelstrekningRute3 = [3,2,1]
TimeHardCodeRute3 = [
    8*60*60+11*60,
    9*60*60+14*60,
    12*60*60+31*60,
    14*60*60+13*60
]

TotalPlasserArray = [24, 20, 12]
delstrekningArray = [DelstrekningRute1,DelstrekningRute2,DelstrekningRute3]
TimeHardCodeArray = [TimeHardCodeRute1,TimeHardCodeRute2,TimeHardCodeRute3]

db.execute("SELECT MAX(IDstrekning) FROM Strekning")
IndeksIDstrekning = db.fetchone() #Sjekker indeksen slik at den kan forsette
if (IndeksIDstrekning[0] == None):
    IndeksIDstrekning = 1
else:
    IndeksIDstrekning = IndeksIDstrekning[0]+1

IDstrekning = 1
for Togrute in range (1,4):
    print(delstrekningArray[Togrute-1][0], Togrute)
    db.execute("SELECT * FROM Togforekomst WHERE IDtogrute = {}".format(Togrute))
    row = db.fetchall()

    

    for dagIndeks in range (0,len(row)):
        print("Ny Dag")
        FirstStrekning = True

        for DelstrekningIndeks in range(0, len(delstrekningArray[Togrute-1])):
            print("Ny delstrek")
            avgang = args.start + TimeHardCodeArray[Togrute-1][DelstrekningIndeks] + dagToUnix[row[dagIndeks][2]].value
            annkomst = args.start + TimeHardCodeArray[Togrute-1][DelstrekningIndeks+1] + dagToUnix[row[dagIndeks][2]].value - 180
            
            print(datetime.fromtimestamp(avgang))
            print(datetime.fromtimestamp(annkomst))
            print(FirstStrekning)
            skalidatabase = "INSERT INTO Strekning VALUES({}, {}, {}, {}, {}, {}, {});".format((IDstrekning+IndeksIDstrekning), Togrute, avgang, annkomst, FirstStrekning , delstrekningArray[Togrute-1][DelstrekningIndeks], TotalPlasserArray[Togrute-1])
            IDstrekning += 1
            print(skalidatabase)

            db.execute(skalidatabase) 
            FirstStrekning = False



db_connect.commit() #Lagrer det vi har i databasen