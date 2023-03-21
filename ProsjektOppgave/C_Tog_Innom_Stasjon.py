import sqlite3

from datetime import datetime
import argparse
import time
import sys
import re
from enum import Enum

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

parser = argparse.ArgumentParser()
parser.add_argument('--stasjon', type=str, required=False) #Send in en unix tid
args = parser.parse_args()

InputStation = args.stasjon

db.execute("SELECT DISTINCT IDtogrute FROM Strekning")
rows = db.fetchall()

for  IDtogrute in rows:
    print(IDtogrute[0])

    db.execute("SELECT DISTINCT IDdelStrekning FROM Strekning WHERE IDtogrute = {}".format(IDtogrute[0]))
    IDDelstrekning = db.fetchall()
    print(IDDelstrekning)

    for i in range (1, len(IDDelstrekning[IDtogrute]+1)):
        print("test")