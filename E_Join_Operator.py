import sqlite3

import argparse
import sys
import hashlib

def Sha512Hash(Password):
    return(hashlib.sha512(Password.encode('utf-8')).hexdigest())

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--kundeID', type=int, required=True, help="Skirv talllet for din kunde ID")  
parser.add_argument('--IDoperator', type=int, required=True, help="Skirv talllet for din operatøren du ønsker å bli med")  
parser.add_argument('--passord', type=str, required=True, help="passord, dette skal være lukket innen \" \", eksepem \"Dette er mitt passord\"")  
args = parser.parse_args()

db.execute("SELECT passord FROM Kunde Where IDkunde = {}".format(args.kundeID))
checkIfExist = db.fetchone()
if(checkIfExist == None):
    print("Ingen kunde under KundeID", args.kundeID)
    sys.exit()
    
if(checkIfExist[0] != Sha512Hash(args.passord)):
    print("passord ikke korrekt")
    sys.exit()

db.execute("SELECT * FROM Operator Where IDoperator = {}".format(args.IDoperator))
checkIfExist = db.fetchone()
if(checkIfExist == None):
    print("Ingen operator under OperatorID", args.IDoperator)
    sys.exit()

db.execute("SELECT * FROM Kunderegister Where IDoperator = {} and IDkunde = {} ".format(args.IDoperator, args.kundeID))
checkIfExist = db.fetchone()
if(checkIfExist != None):
    print("Allerede registrert i register")
    sys.exit()

db.execute("INSERT INTO Kunderegister VALUES({0},{1});".format(args.IDoperator,args.kundeID))
print("Du er nå registert")
db_connect.commit()


