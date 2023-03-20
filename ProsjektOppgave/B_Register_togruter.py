import sqlite3

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()



db.execute("INSERT INTO Togrute VALUES(1, 1, True);")
db.execute("INSERT INTO Togrute VALUES(2, 1, True);")
db.execute("INSERT INTO Togrute VALUES(3, 1, False);")


db.execute("INSERT INTO Togforekomst VALUES(1, 1, 'Mandag');")
db.execute("INSERT INTO Togforekomst VALUES(2, 1, 'Tirdag');")
db.execute("INSERT INTO Togforekomst VALUES(3, 1, 'Onsdag');")
db.execute("INSERT INTO Togforekomst VALUES(4, 1, 'Tordag');")
db.execute("INSERT INTO Togforekomst VALUES(5, 1, 'Fredag');")


db.execute("INSERT INTO Togforekomst VALUES(6, 2, 'Mandag');")
db.execute("INSERT INTO Togforekomst VALUES(7, 2, 'Tirdag');")
db.execute("INSERT INTO Togforekomst VALUES(8, 2, 'Onsdag');")
db.execute("INSERT INTO Togforekomst VALUES(9, 2, 'Tordag');")
db.execute("INSERT INTO Togforekomst VALUES(10, 2, 'Fredag');")
db.execute("INSERT INTO Togforekomst VALUES(11, 2, 'Lordag');")
db.execute("INSERT INTO Togforekomst VALUES(12, 2, 'Sondag');")

db.execute("INSERT INTO Togforekomst VALUES(13, 3, 'Mandag');")
db.execute("INSERT INTO Togforekomst VALUES(14, 3, 'Tirdag');")
db.execute("INSERT INTO Togforekomst VALUES(15, 3, 'Onsdag');")
db.execute("INSERT INTO Togforekomst VALUES(16, 3, 'Tordag');")
db.execute("INSERT INTO Togforekomst VALUES(17, 3, 'Fredag');")



db.execute("INSERT INTO VognType VALUES('SJ-sittevogn-1', True, 12);")
db.execute("INSERT INTO VognType VALUES('SJ-sovevogn-1', False, 8);")

db.execute("INSERT INTO Vognoppsett VALUES(1, 1, 1, 12, 1, NULL);")
db.execute("INSERT INTO Vognoppsett VALUES(2, 2, 1, 20, 1, 3);")
db.execute("INSERT INTO Vognoppsett VALUES(3, 2, 1, 20, 2, NULL);")
db.execute("INSERT INTO Vognoppsett VALUES(4, 3, 1, 12, 1, NULL);")




db_connect.commit() #Lagrer det vi har i databasen