import sqlite3
db = sqlite3.connect("bane-vest.db").cursor()
var = ["Operator", "Ordre", "Kunderegister", "Banestrekning", "Vognoppsett", "Togforekomst", "OkuperteSeter", "Kunde", "Togrute", "Strekning", "Delstrekning", "VognType", "Jernbanestasjon"]
for i in range(0, len(var)): db.execute("DROP TABLE IF EXISTS %s;" %  (var[i])) 
