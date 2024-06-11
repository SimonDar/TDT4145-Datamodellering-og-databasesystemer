import sqlite3

from datetime import datetime
import argparse
import time
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
parser.add_argument('--start', type=int, required=True) #Send in en unix tid
args = parser.parse_args()

if( (datetime.fromtimestamp(args.start).weekday() or (args.start - 82800) % 86400) != 0 ):
    print("The time you have sendt in, is not a monday, time also has to be 00:00")
    sys.exit()
   
print("You have typed in beginning date: ", datetime.fromtimestamp(args.start))

db.execute("SELECT * FROM Togforekomst")
#print("First row from table Vognoppsett:")

for i in range (0,3):
    db.execute("SELECT * FROM Togforekomst WHERE IDtogrute = {}".format(i+1))
    row = db.fetchall()

    print(dagToUnix[row[1][2]].value)

    #for j in range (0, len(row)):

#db_connect.commit() #Lagrer det vi har i databasen