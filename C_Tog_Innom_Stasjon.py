import sqlite3

from datetime import datetime
import argparse
import sys

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--stasjon', type=str, required=True, help = "Søk på jernbanestasjoner, søkene må lukkes med \" \"")  
args = parser.parse_args()

InputStation = args.stasjon

db.execute("SELECT * FROM Jernbanestasjon WHERE NavnStasjon = '{}'".format(InputStation))
CheckIfExist = db.fetchone()
if(CheckIfExist == None):
    print("ingen jernbanestasjon med navnet: ", InputStation)
    sys.exit()

db.execute("SELECT DISTINCT IDtogrute FROM Strekning")
rows = db.fetchall()

print("Følgende tog kjører gjennom ", InputStation, ":")

for  IDtogrute in rows:
    #print("TOGID-",IDtogrute[0])
    firstStrekning = True

    db.execute("SELECT DISTINCT IDdelStrekning FROM Strekning WHERE IDtogrute = {}".format(IDtogrute[0]))
    dbDelstrekning = db.fetchall()

    firstStrekning = True
    for i in range (0, len(dbDelstrekning)):
        #print(dbDelstrekning[i][0])

        if(firstStrekning):
            db.execute("SELECT StasjonFra FROM Delstrekning Where IDdelStrekning = {}".format(dbDelstrekning[i][0]))
            stasjonFra = db.fetchone()
            #print("test", stasjonFra[0])
            firstStrekning = False
            if(stasjonFra[0] == InputStation):
                print("TogID",IDtogrute[0])

        db.execute("SELECT StasjonTil FROM Delstrekning Where IDdelStrekning = {}".format(dbDelstrekning[i][0]))
        stasjonTil = db.fetchone()
        #print("test", stasjonTil[0])
        if(stasjonTil[0] == InputStation):
            print("TogID",IDtogrute[0]) 
        

    

