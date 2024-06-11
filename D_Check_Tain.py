import sqlite3

from datetime import datetime
import argparse
import time
import sys


db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--fromm', type=str, required=True, help="Skriv inn navnet på stasjonen du vil søke FRA. Lukk disse med \" \"")  
parser.add_argument('--to', type=str, required=True, help="Skriv inn navnet på stasjonen du vil søke TIL. Lukk disse med \" \"")  
parser.add_argument('--timeUNIX', type=int, required=False, default=time.time(), help="Skriv inn tiden du vil resie fra, dette oppgis i unix tid med GMT+1(Norsk tid). oppgir du ingen klokkeslett, vil du søke på nestkommende tog fra hva klokka er nå. UNIX tid for mandag 3. august 00:00:00 er: 1680476400")  
parser.add_argument('--debugmode', type=bool, required=False, default=False, help="Sett verdi som 1 hvis du vil se data under kjøring av kode")  
#parser.add_argument('--timeDate', type=datetime, required=False)  
args = parser.parse_args()

if(args.timeUNIX == None):
    print("Need to pick time, use --help for info")
    sys.exit()




db.execute("SELECT IDdelStrekning FROM Delstrekning Where StasjonFra = '{}'".format(args.fromm))
StartBane = db.fetchone()
if(args.fromm == "Bodo"):
    StartBane = (5,)

db.execute("SELECT IDdelStrekning FROM Delstrekning Where StasjonTil = '{}'".format(args.to))
SluttBane = db.fetchone()
if(args.to == "Trondheim S"):
    SluttBane = (1,)

print("Tog fra ", *StartBane, " til ",*SluttBane)

if(SluttBane == None):
    print("Ingen stasjon med navn ", args.to)
    sys.exit()

if(SluttBane == None):
    print("Ingen stasjon med navn ", args.fromm)
    sys.exit()

RequestFollowsBaneretning = True


if(StartBane[0] > SluttBane[0]):
    RequestFollowsBaneretning = False
    print("Ruten kjører motsatt banestrekning")
    strekningToRide = list(range(StartBane[0]-1,SluttBane[0]-1, -1))
else:
    strekningToRide = list(range(StartBane[0],SluttBane[0]+1))

print("Dette tilsier at ruten følge følgende strekninger ",strekningToRide)

db.execute("SELECT IDtogrute FROM Togrute Where Hovedretning = {}".format(RequestFollowsBaneretning))

TogIRiktigBaneretning = db.fetchall()

print("Togruter som har lik baneretning", TogIRiktigBaneretning)


SQLquereWithTrainID = "( "
for togID in TogIRiktigBaneretning:
    SQLquereWithTrainID += "IDtogrute = {} OR ".format(togID[0])
SQLquereWithTrainID = SQLquereWithTrainID[:-4]
SQLquereWithTrainID += ")"
if(args.debugmode): print(SQLquereWithTrainID)

startrute = []
nextday = False
if(args.debugmode): print("SELECT IDstrekning, UnixAvgang FROM Strekning Where IDdelStrekning = {} AND UnixAvgang > {} AND {} ORDER BY UnixAvgang ASC".format(strekningToRide[0], args.timeUNIX, SQLquereWithTrainID))
db.execute("SELECT IDstrekning, UnixAvgang FROM Strekning Where IDdelStrekning = {} AND UnixAvgang > {} AND {} ORDER BY UnixAvgang ASC".format(strekningToRide[0], args.timeUNIX, SQLquereWithTrainID))
while(nextday == False):
    IDstrekningOGtid = db.fetchone()
    if(args.debugmode): print(IDstrekningOGtid)
    if(args.debugmode): print(args.timeUNIX + (2*24*60*60), " MAX <- Tid -> CURENT ", IDstrekningOGtid[1])
    startrute.append(IDstrekningOGtid[0])
    if(IDstrekningOGtid[1] >= args.timeUNIX + (2*24*60*60)):
        nextday = True

if(args.debugmode): print(startrute)

print("\n\n\t\t\tDu kan ta følge ruter")
for startruteindeks in startrute:
    db.execute("SELECT IDtogrute, UnixAvgang, UnixAnnkomst FROM Strekning Where IDStrekning = {}".format(startruteindeks))
    strekninginfo = db.fetchone()

    print("TogRute\t", strekninginfo[0])
    print("Avgang\t\t", args.fromm,"\t\tTid:",datetime.fromtimestamp(strekninginfo[1]))
    db.execute("SELECT IDtogrute, UnixAvgang, UnixAnnkomst FROM Strekning Where IDStrekning = {}".format(startruteindeks+len(strekningToRide)-1))
    strekninginfo = db.fetchone()
    print("Annkomst\t", args.to,"\t\tTid:",datetime.fromtimestamp(strekninginfo[2]),"\n")
        





#for Delstrekning in strekningToRide:
#    print("test")
#    db.execute("SELECT IDstrekning FROM Strekning Where IDdelStrekning = {} AND UnixAvgang > {} ORDER BY UnixAvgang ASC;".format(Delstrekning[0], args.timeUNIX))
#
#    for togID in TogIRiktigBaneretning:
#        tempValue = db.fetchone()
#        print(tempValue)
#