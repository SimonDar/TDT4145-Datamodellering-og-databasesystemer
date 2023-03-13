import sqlite3

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()


db.execute("INSERT INTO Togrute VALUES(1, 1, True);")
db.execute("INSERT INTO Togrute VALUES(2, 1, True);")
db.execute("INSERT INTO Togrute VALUES(3, 1, False);") 


db.execute("INSERT INTO Togforekomst VALUES(1, 1, True);")
db.execute("INSERT INTO Togrute VALUES(2, 1, True);")
db.execute("INSERT INTO Togrute VALUES(3, 1, False);") 



db_connect.commit() #Lagrer det vi har i databasen