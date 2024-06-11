INSERT INTO Togrute VALUES(1, 1, True);
INSERT INTO Togrute VALUES(2, 1, True);
INSERT INTO Togrute VALUES(3, 1, False);


INSERT INTO Togforekomst VALUES(1, 1, "Mandag");
INSERT INTO Togforekomst VALUES(2, 1, "Tirdag");
INSERT INTO Togforekomst VALUES(3, 1, "Onsdag");
INSERT INTO Togforekomst VALUES(4, 1, "Tordag");
INSERT INTO Togforekomst VALUES(5, 1, "Fredag");


INSERT INTO Togforekomst VALUES(6, 2, "Mandag");
INSERT INTO Togforekomst VALUES(7, 2, "Tirdag");
INSERT INTO Togforekomst VALUES(8, 2, "Onsdag");
INSERT INTO Togforekomst VALUES(9, 2, "Tordag");
INSERT INTO Togforekomst VALUES(10, 2, "Fredag");
INSERT INTO Togforekomst VALUES(11, 2, "Lordag");
INSERT INTO Togforekomst VALUES(12, 2, "Sondag");

INSERT INTO Togforekomst VALUES(13, 3, "Mandag");
INSERT INTO Togforekomst VALUES(14, 3, "Tirdag");
INSERT INTO Togforekomst VALUES(15, 3, "Onsdag");
INSERT INTO Togforekomst VALUES(16, 3, "Tordag");
INSERT INTO Togforekomst VALUES(17, 3, "Fredag");



INSERT INTO VognType VALUES("SJ-sittevogn-1", True, 12);
INSERT INTO VognType VALUES("SJ-sovevogn-1", False, 8);

INSERT INTO Vognoppsett VALUES(1, 1, 1, 24, 1, 2);
INSERT INTO Vognoppsett VALUES(2, 1, 1, 24, 1, NULL);
--
INSERT INTO Vognoppsett VALUES(3, 2, 1, 20, 1, 3);
INSERT INTO Vognoppsett VALUES(4, 2, 1, 20, 2, NULL);
--
INSERT INTO Vognoppsett VALUES(5, 3, 1, 12, 1, NULL);