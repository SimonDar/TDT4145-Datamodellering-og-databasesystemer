import sqlite3

db_connect = sqlite3.connect("bane-vest.db")
db = db_connect.cursor()

Togrute=[1,2,3]
Plasser=[24,20,12]

for IDstrekning in range (2, 77):

    db.execute("SELECT IDtogrute FROM Strekning WHERE IDstrekning = {}".format(IDstrekning))
    IDtogrute = db.fetchone()

    if(IDtogrute[0] == 1):
        for setenr in range (1,24):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
    
    if(IDtogrute[0] == 2):  
        for setenr in range (1,13):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
        for setenr in range (13,21):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, True))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, True))

    if(IDtogrute[0] == 3):
        for setenr in range (1,13):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))        

for IDstrekning in range (79, 151):

    db.execute("SELECT IDtogrute FROM Strekning WHERE IDstrekning = {}".format(IDstrekning))
    IDtogrute = db.fetchone()

    if(IDtogrute[0] == 1):
        for setenr in range (1,24):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
    
    if(IDtogrute[0] == 2):  
        for setenr in range (1,13):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
        for setenr in range (13,21):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, True))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, True))

    if(IDtogrute[0] == 3):
        for setenr in range (1,13):
            db.execute("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))
            print("INSERT INTO OkuperteSeter(IDstrekning, Plassnr, Sengeplass) VALUES({},{},{})".format(IDstrekning, setenr, False))        

db_connect.commit()
