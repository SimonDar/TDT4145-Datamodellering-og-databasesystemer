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

parser = argparse.ArgumentParser(
                    prog='Kjøp billett',
                    description='Kjøp billett',
                    epilog='Her kan du bestille billetter info eller full info. en må sende med informasjon med argumenter, se --help eller -h for guide \n det er også noen kriterien som må overholdes. en kan ikke bestille billett i samme lugar som en med annen kundeID. Dette må bli gjort av samme bruker. En seng vil også være utigjengelig om den brukes av noen andre på hele togture. dette er grunnet helsemessige årsaker')
parser.add_argument('--fromm', type=str, required=True, help="Skriv inn navnet på stasjonen du vil FRA. Lukk disse med \" \"")  
parser.add_argument('--to', type=str, required=True, help="Skriv inn navnet på stasjonen du vil TIL. Lukk disse med \" \"")  
parser.add_argument('--timeUNIX', type=int, required=False, default=time.time(), help="Skriv inn tiden du vil resie fra, dette oppgis i unix tid med GMT+1(Norsk tid). oppgir du ingen klokkeslett, vil du søke på nestkommende tog fra hva klokka er nå. UNIX tid for mandag 3. august 00:00:00 er: 1680476400" ) 
parser.add_argument('--kundeID', type=int, required=True,  help="Skirv talllet for din kunde ID")  
parser.add_argument('--passord', type=str, required=True, help="passord, dette skal være lukket innen \" \", eksepem \"Dette er mitt passord\"")  
args = parser.parse_args()

def SQLsanitation(): #Tanken var SQL sanitaion. Men ser ut argparse allerede fjerner noen av de farligste karkaterene 

    inputsSTR=[args.to, args.fromm, args.passord]
    WhiteList =[
"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","æ","ø","å","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","æ","ø","å","0","1","2","3","4","5","6","7","8","9","@",".","+"," ","_"]
    
    for element in inputsSTR:
        for charakter in range(0, len(element)):
            if(element[charakter] not in WhiteList):
                sys.exit()
    return 1

def SengEidAvSammePerson(StrekningID, SeteValgt):
    db.execute("SELECT IDordre FROM OkuperteSeter WHERE IDstrekning = {} AND Plassnr = {};".format(StrekningID, SeteValgt))
    OrdreID = db.fetchone()

    db.execute("SELECT IDkunde FROM Ordre WHERE IDordre = {};".format(OrdreID[0]))
    KundeSomHarSete = db.fetchone()
    return bool(KundeSomHarSete[0] == args.kundeID)

db.execute("SELECT Passord FROM Kunde Where IDkunde = {}".format(args.kundeID))
checkIfExist = db.fetchone()
if(checkIfExist == None):
    print("Ingen kunde under KundeID", args.kundeID)
    sys.exit()
    
if(checkIfExist[0] != Sha512Hash(args.passord)):
    print("Passord ikke korrekt")
    sys.exit()

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

#print("Tog fra ", *StartBane, " til ",*SluttBane)

if(SluttBane == None):
    print("Ingen stasjon med navn ", args.to)
    sys.exit()

if(SluttBane == None):
    print("Ingen stasjon med navn ", args.fromm)
    sys.exit()

RequestFollowsBaneretning = True


if(StartBane[0] > SluttBane[0]):
    RequestFollowsBaneretning = False
   # print("Ruten kjører motsatt banestrekning")
    strekningToRide = list(range(StartBane[0]-1,SluttBane[0]-1, -1))
else:
    strekningToRide = list(range(StartBane[0],SluttBane[0]+1))

print("Dette tilsier at ruten følge følgende strekninger ",strekningToRide)

db.execute("SELECT IDtogrute FROM Togrute Where Hovedretning = {}".format(RequestFollowsBaneretning))

TogIRiktigBaneretning = db.fetchall()

#print("Togruter som har lik baneretning", TogIRiktigBaneretning)


SQLquereWithTrainID = "( "
for togID in TogIRiktigBaneretning:
 #   print("togID LOOP")
    SQLquereWithTrainID += "IDtogrute = {} OR ".format(togID[0])
SQLquereWithTrainID = SQLquereWithTrainID[:-4]
SQLquereWithTrainID += ")"
#print(SQLquereWithTrainID)

startrute = []
nextday = False
#print("SELECT IDstrekning, UnixAvgang FROM Strekning Where IDdelStrekning = {} AND UnixAvgang > {} AND {} ORDER BY UnixAvgang ASC".format(strekningToRide[0], args.timeUNIX, SQLquereWithTrainID))
db.execute("SELECT IDstrekning, UnixAvgang FROM Strekning Where IDdelStrekning = {} AND UnixAvgang > {} AND {} ORDER BY UnixAvgang ASC".format(strekningToRide[0], args.timeUNIX, SQLquereWithTrainID))
while(nextday == False):
    IDstrekningOGtid = db.fetchone()
    #print(IDstrekningOGtid)
  #  print(args.timeUNIX + (2*24*60*60), " MAX <- Tid -> CURENT ", IDstrekningOGtid[1])
    startrute.append(IDstrekningOGtid[0])
    if(IDstrekningOGtid[1] >= args.timeUNIX + (2*24*60*60)):
        nextday = True

#print(startrute)

print("\n\n\t\t\tDu kan ta følge ruter")

ValgAlternativ = 1
for startruteindeks in startrute:
    db.execute("SELECT IDtogrute, UnixAvgang, UnixAnnkomst FROM Strekning Where IDStrekning = {}".format(startruteindeks))
    strekninginfo = db.fetchone()

    print("ValgAlternativ: ", ValgAlternativ,"\t\t\t\tTogRute: ", strekninginfo[0])
    print("Avgang\t\t", args.fromm,"\t\tTid:",datetime.utcfromtimestamp(strekninginfo[1]+60*60))
    db.execute("SELECT IDtogrute, UnixAvgang, UnixAnnkomst FROM Strekning Where IDStrekning = {}".format(startruteindeks+len(strekningToRide)-1))
    strekninginfo = db.fetchone()
    print("Annkomst\t", args.to,"\t\tTid:",datetime.utcfromtimestamp(strekninginfo[2]+60*60), "\n")
    ValgAlternativ += 1
        
print('Velg Et Alternativ:')
AlernativValgt = int(input())

if(AlernativValgt <= 0 or AlernativValgt > len(startrute)):
    print("ulovelig valg av alternativ")
    sys.exit()

db.execute("SELECT Operator.IDoperator FROM Strekning INNER JOIN Operator ON Strekning.IDtogrute = Operator.IDtogrute WHERE IDstrekning ={}".format(startrute[AlernativValgt-1]))
StrekningIDOperator = db.fetchone()

db.execute("SELECT * FROM Kunderegister WHERE IDoperator = {} AND IDkunde = {}".format(StrekningIDOperator[0], args.kundeID))
checkIfExist = db.fetchone()

if(checkIfExist == None):
    print("\nDu er ikke med i Kunderegisteret til operator: ", StrekningIDOperator[0], "\nFor å legge deg til i registeret, benytt deg av E_Join_Operator")
    sys.exit()



strekningToBuy = []
print("Sjekker bilett for følgende strekning:")
for i in range (0, len(strekningToRide)):
    print("strekning:", startrute[AlernativValgt-1]+i)
    strekningToBuy.append(startrute[AlernativValgt-1]+i)

soveplassWish = input('\nØnsker du soveplass? (y/n): ').lower().strip() == 'y'
#print(soveplassWish)



 
db.execute("SELECT MAX(IDordre) FROM Ordre")
NyOrdreID = db.fetchone()
if(NyOrdreID[0] == None):
    NyOrdreID = 1
else:
    NyOrdreID = NyOrdreID[0] + 1 

ledigePlasserArray = []

if(soveplassWish == False):
    for i in range (0, len(strekningToRide)):
        db.execute("SELECT Plassnr FROM OkuperteSeter Where (Sengeplass = 0 AND IDStrekning = {} AND IDordre IS NULL) ".format(strekningToBuy[i]))
        listeMedLedigeSeter = db.fetchall()
        #print(listeMedLedigeSeter, strekningToBuy[i])
        ledigePlasserArray.append(listeMedLedigeSeter)


    for i in range(1,len(ledigePlasserArray)):
        ledigePlasserArray[0] = list(set(ledigePlasserArray[0]) & set(ledigePlasserArray[1]))
        ledigePlasserArray.pop(1)
    ledigePlasserArray=[i[0] for i in ledigePlasserArray[0]]
    ledigePlasserArray.sort()
    print(ledigePlasserArray)

    if(len(ledigePlasserArray) == 0):
        print("Ingen ledige seter på denne strekningen")
        sys.exit()
        
    SeteValgt = int(input("\nVelg ønsket sete\t"))
    if(SeteValgt not in ledigePlasserArray):
        print("Beklager, du kan ikke velge dette setet")
        sys.exit()



    
    for i in range (0, len(strekningToRide)):    
        db.execute("UPDATE OkuperteSeter SET IDordre = {} WHERE IDstrekning = {} AND Plassnr = {}".format(NyOrdreID ,startrute[AlernativValgt-1]+i, SeteValgt)) 
        print("UPDATE OkuperteSeter SET IDordre = {} WHERE IDstrekning = {} AND Plassnr = {}".format(NyOrdreID ,startrute[AlernativValgt-1]+i, SeteValgt)) 

if(soveplassWish == True):

    for i in range (0, len(strekningToRide)):
        db.execute("SELECT Plassnr FROM OkuperteSeter Where (Sengeplass = 1 AND IDStrekning = {} AND IDordre IS NULL) ".format(strekningToBuy[i]))
        listeMedLedigeSeter = db.fetchall()
        #print(listeMedLedigeSeter, strekningToBuy[i])
        ledigePlasserArray.append(listeMedLedigeSeter)


    for i in range(1,len(ledigePlasserArray)): #Gjør om fra list format til array format samt sjekker likheter i se
        ledigePlasserArray[0] = list(set(ledigePlasserArray[0]) & set(ledigePlasserArray[1]))
        ledigePlasserArray.pop(1)
    ledigePlasserArray=[i[0] for i in ledigePlasserArray[0]]
    ledigePlasserArray.sort()
    print(ledigePlasserArray)

    if(len(ledigePlasserArray) == 0):
        print("Ingen ledige senger på denne strekningen")
        sys.exit()

    SengValgt = int(input("\nVelg ønsket seng\t"))
    if(SengValgt not in ledigePlasserArray):
        print("Beklager, du kan ikke velge dette setet")
        sys.exit()


    finnTilhorendeStrekningPaaRute = [startrute[AlernativValgt-1]]
    db.execute("SELECT FirstStrekning  FROM Strekning Where IDstrekning = {};".format(startrute[AlernativValgt-1]))
    SjekkOmForsteStrekning = db.fetchone()
    ForigeStrekning = startrute[AlernativValgt-1]-1
    while(SjekkOmForsteStrekning[0] == 0 and SjekkOmForsteStrekning != None):
        db.execute("SELECT FirstStrekning FROM Strekning Where IDstrekning = {}".format(ForigeStrekning))
        SjekkOmForsteStrekning = db.fetchone()
        finnTilhorendeStrekningPaaRute.append(ForigeStrekning)
        ForigeStrekning -= 1    
    
    NesteStrekning = startrute[AlernativValgt-1]+1
    db.execute("SELECT FirstStrekning FROM Strekning Where IDstrekning = {};".format(NesteStrekning))
    SjekkOmSisteStrekning = db.fetchone()
    while(SjekkOmSisteStrekning[0] != 0 and SjekkOmSisteStrekning != None):
        finnTilhorendeStrekningPaaRute.append(NesteStrekning)
        NesteStrekning += 1
        db.execute("SELECT FirstStrekning  FROM Strekning Where IDstrekning = {};".format(NesteStrekning))
        SjekkOmSisteStrekning = db.fetchone()

    print(finnTilhorendeStrekningPaaRute)

    for strekningID in finnTilhorendeStrekningPaaRute:
        db.execute("SELECT IDordre FROM OkuperteSeter WHERE IDstrekning = {} AND Plassnr = {};".format(strekningID, SengValgt))
        seteUnderStrekingID = db.fetchone()
        if(seteUnderStrekingID[0] != None):
            if(SengEidAvSammePerson(strekningID, SengValgt)):
                print("Utvidelse av billett allerede kjøpt, vil bli vist som to billetter")
            else:
                print("Annen kunde allerede bestilt senga under annet strekning, vi kan derfor ikke selge deg denne senga av helsemessige årsaker")
                sys.exit()
            
    if(SengValgt % 2):
        andreSengILugar = SengValgt + 1
    else:
        andreSengILugar = SengValgt - 1

    for strekningID in strekningToBuy:
        db.execute("SELECT IDordre FROM OkuperteSeter WHERE IDstrekning = {} AND Plassnr = {};".format(strekningID, andreSengILugar))
        andreSengUnderSammeStrekingID = db.fetchone()
        if(andreSengUnderSammeStrekingID[0] != None):
            if(SengEidAvSammePerson(strekningID, andreSengILugar)):
                print("Ved å kjøpe det andre sengen, vil du ha to senger og to billetter")
            else:
                print("Annen kunde allerede bestilt den andre sengen under samme strekning, vi kan derfor ikke selge deg denne sengen")
                sys.exit()
            
        

    for strekningID in strekningToBuy:
        db.execute("UPDATE OkuperteSeter SET IDordre = {} WHERE IDstrekning = {} AND Plassnr = {}".format(NyOrdreID, strekningID, SengValgt))

                
curentTimeInUnix = int(time.time())
db.execute("INSERT INTO Ordre VALUES({}, {}, {})".format(NyOrdreID, curentTimeInUnix, args.kundeID))


if(SQLsanitation):        
    db_connect.commit()
