

import sqlite3

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()


bane = ["Nordlandsbanen"]
NavnStasjon = ["Trondheim S", "Steinkjer", "Mosjoen", "Mo i Rana", "Fauske", "Bodo"]
Moh = [1.5, 3.6, 6.8, 3.5, 34.0, 4.1]

Enkeltspor= [True, False, False, False, False]
AvstandKM = [120,280,90,170,60]

#Fisk to vonger på togrute = 1


for i in range(0, len(bane)): #Starter først å itterere gjennom banene
    print("INSERT INTO Banestrekning VALUES({0}, '{1}');".format((i+1), bane[i]))
    db.execute("DELETE FROM Banestrekning WHERE IDbaneStrekning = {}".format((i+1)))
    db.execute("INSERT INTO Banestrekning VALUES({0}, '{1}');".format((i+1), bane[i])) 
    
    FirstStasjon = True
    for j in range(0, len(NavnStasjon)): #etterfulgt itterer vi gjennom stasjonene
        print("INSERT INTO Jernbanestasjon VALUES({0}, '{1}', {2});".format((i+1), NavnStasjon[j], Moh[j]))
        db.execute("DELETE FROM Jernbanestasjon WHERE IDbaneStrekning = {}".format((j+1)))
        db.execute("INSERT INTO Jernbanestasjon VALUES({0}, '{1}', {2});".format((i+1), NavnStasjon[j], Moh[j]))

        if j != 0:
            db.execute("DELETE FROM Delstrekning WHERE IDdelStrekning = {}".format((j)))
            db.execute("INSERT INTO Delstrekning VALUES({0},{1},{2},{3},'{4}','{5}');".format(j, AvstandKM[j-1], Enkeltspor[j-1], FirstStasjon, NavnStasjon[j-1], NavnStasjon[j]))
            print("INSERT INTO Delstrekning VALUES({0},{1},{2},{3},'{4}','{5}');".format(j, AvstandKM[j-1], Enkeltspor[j-1], FirstStasjon, NavnStasjon[j-1], NavnStasjon[j]))
            FirstStasjon = False


db_connect.commit() #Lagrer det vi har i databasen 