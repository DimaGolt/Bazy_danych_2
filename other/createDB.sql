CREATE TABLE Film (
FilmID int not null,
CzasTrwania int,
RokProdukcji date,
Gatunek varchar(20),
Nazwa varchar(20),
LinkDoPlakatu varchar(20),
PRIMARY KEY (FilmID)
);
CREATE TABLE Obsada (
ObsadaID int not null,
Imie varchar(20) not null,
Nazwisko varchar(20) not null,
DataUrodzenia date,
DataSmierci date,
KrajUrodzenia varchar(20),
PRIMARY KEY (ObsadaID)
);
CREATE TABLE Rola (
RolaID int not null,
ObsadaID int not null,
FilmID int not null,
RodzajRoli varchar(20) not null,
PRIMARY KEY (RolaID),
FOREIGN KEY (ObsadaID) REFERENCES Obsada(ObsadaID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID)
);
CREATE TABLE Uzytkownik (
UzytkownikID int not NULL AUTO_INCREMENT,
Login varchar(20) not NULL,
Haslo varchar(20) not NULL,
PoziomDostepu int not NULL,
PRIMARY KEY (UzytkownikID)
);
CREATE TABLE NagrodaAktor (
NagrodaAktorID int not null,
ObsadaID int not null,
NazwaNagrody varchar(20),
DataPrzyznania date,
MiejscePrzyznania varchar(20),
FilmID int not null,
Kategoria varchar(20),
PRIMARY KEY (NagrodaAktorID),
FOREIGN KEY (ObsadaID) REFERENCES Obsada(ObsadaID)
);
CREATE TABLE Komentarz (
KomentarzID int not null,
FilmID int not null,
UzytkownikID int not null,
Tresc varchar(200) not null,
PRIMARY KEY (KomentarzID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID)
);
--------------------------
CREATE TABLE Ocena (
OcenyID int not NULL,
FilmID int not NULL,
UzytkownikID int not NULL,
Wartosc int not NULL,
PRIMARY KEY (OcenyID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID)
);
CREATE TABLE Recenzja (
RecenzjaID int not NULL,
FilmID int not NULL,
UzytkownikID int not NULL,
Tresc varchar(200) not NULL,
PRIMARY KEY (RecenzjaID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID));
CREATE TABLE KomentarzHistoria (
KomentarzID int not null,
FilmID int not null,
UzytkownikID int not null,
DataUsuniecia DATETIME DEFAULT CURRENT_TIMESTAMP,
Tresc varchar(200) not null,
PRIMARY KEY (KomentarzID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID)
);
CREATE TABLE NagrodaFilm (
NagrodaFilmID int not null,
FilmID int not null,
NazwaNagrody varchar(20) not null,
DataPrzyznania date,
MiejscePrzyznania varchar(20),
Kategoria varchar(20),
PRIMARY KEY (NagrodaFilmID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID)
);
CREATE VIEW FilmyWidok AS
SELECT FilmID as "ID", Nazwa, CzasTrwania, RokProdukcji, Gatunek,
LinkDoPlakatu, (SELECT avg(wartosc) from Ocena o JOIN Film f on o.filmid = f.filmid where o.filmid 
= f.filmid) as "srednia"
FROM Film;
CREATE VIEW RolaWidok AS
SELECT r.FilmID as "ID", r.ObsadaId, r.RodzajRoli, o.Imie, o.Nazwisko, o.DataUrodzenia, o.DataSmierci, o.KrajUrodzenia 
FROM Rola r JOIN Obsada o WHERE r.ObsadaId = o.ObsadaId;
CREATE VIEW AktorzyWidok AS
SELECT Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia
FROM Obsada;
-- CREATE TRIGGER KomentarzUsuniecie
-- AFTER DELETE ON Komentarz
-- FOR EACH ROW
-- Set action = 'update',
-- 	komentarzID = OLD.komentarzID,FilmFilm
--     filmID = OLD.filmId,
--     UzytkownikId = OLD.UzytkownikID,
--     DataUsuniecia = CURRENT_TIMESTAMP,
--     Tresc = OLD.Tresc;
-- 
INSERT INTO Film (FilmID, CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('521232', '162', '2003-04-21', 'Thriller', 'Below Zero', '/plakaty/23859254');
INSERT INTO Film (FilmID, CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('532789', '184', '2004-11-27', 'Komedia', 'Free Guy', '/plakaty/238292236');
INSERT INTO Film (FilmID, CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('523801', '97', '2015-02-03', 'Akcji', 'Nobody', '/plakaty/23859987');
INSERT INTO Film (FilmID, CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('524362', '121', '2013-08-11', 'Fantasy', 'Constantine', '/plakaty/234359254');
INSERT INTO Film (FilmID, CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('523698', '112', '2020-12-27', 'NULL', 'Morbius', 'NULL');
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('andrzejM', 'mandrzej', '1');
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('asfhoais', '1s8f7ds8', '1');
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('hubertT', 'tsvis', '1');
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('agataG', '123578', '1');
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('kfsuvmnsau', '987654321', '2');
INSERT INTO Komentarz (KomentarzID, FilmID, UzytkownikID, Tresc)
VALUES ('328143', '523698', '1', 'fajne');
INSERT INTO Komentarz (KomentarzID, FilmID, UzytkownikID, Tresc)
VALUES ('326743', '524362', '2', 'ok');
INSERT INTO Komentarz (KomentarzID, FilmID, UzytkownikID, Tresc)
VALUES ('323543', '523801', '3', 'zasnalem');
INSERT INTO Komentarz (KomentarzID, FilmID, UzytkownikID, Tresc)
VALUES ('325443', '532789', '4', 'nie polecam');
INSERT INTO Komentarz (KomentarzID, FilmID, UzytkownikID, Tresc)
VALUES ('328033', '521232', '5', 'Część większego dzieła, serdecznie polecam');
INSERT INTO Recenzja (RecenzjaID, FilmID, UzytkownikID, Tresc)
VALUES ('743433', '521232', '3', 'Słaba produkcja, scenografia i muzyka.');
INSERT INTO Recenzja (RecenzjaID, FilmID, UzytkownikID, Tresc)
VALUES ('323353', '521232', '1', 'Bardzo dobra gra aktorska, zasłużony Oskar');
INSERT INTO Recenzja (RecenzjaID, FilmID, UzytkownikID, Tresc)
VALUES ('323073', '521232', '2', 'Główny bohater bez wyrazu, poza tym genialna muzyka i 
scenografia');
INSERT INTO Recenzja (RecenzjaID, FilmID, UzytkownikID, Tresc)
VALUES ('323083', '524362', '2', 'Spory przeskok między pierwszą częścią, niestety na 
niekorzyść twórcy');
INSERT INTO Recenzja (RecenzjaID, FilmID, UzytkownikID, Tresc)
VALUES ('324563', '524362', '4', 'Bardzo dobra gra aktorska, zasłużony Oskar');
INSERT INTO Ocena (OcenyID, FilmID, UzytkownikID, Wartosc)
VALUES ('946523', '521232', '2', '5');
INSERT INTO Ocena (OcenyID, FilmID, UzytkownikID, Wartosc)
VALUES ('943223', '532789', '1', '4');
INSERT INTO Ocena (OcenyID, FilmID, UzytkownikID, Wartosc)
VALUES ('976523', '523801', '3', '3');
INSERT INTO Ocena (OcenyID, FilmID, UzytkownikID, Wartosc)
VALUES ('476523', '524362', '2', '2');
INSERT INTO Ocena (OcenyID, FilmID, UzytkownikID, Wartosc)
VALUES ('947623', '523698', '4', '1');
-----------------------
INSERT INTO Obsada (ObsadaID, Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('787623', 'Andrzej', 'Matysiak', '1967-04-06', NULL, 'Polska');
INSERT INTO Obsada (ObsadaID, Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('797623', 'Marcin', 'Matysiak', '1997-04-08', NULL, 'Polska');
INSERT INTO Obsada (ObsadaID, Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('727623', 'Sławomir', 'Żbik', '1983-09-24', NULL, 'Polska');
INSERT INTO Obsada (ObsadaID, Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('737623', 'Danuta', 'Wajda', '1999-07-12', NULL, 'Polska');
INSERT INTO Obsada (ObsadaID, Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('758623', 'Andrzej', 'Wojciechowski', '2002-10-10', NULL, 'Polska');
INSERT INTO Rola (ObsadaID, RolaID, FilmID, RodzajRoli)
VALUES ('787623', '522398', '521232', 'Scenarzysta');
INSERT INTO Rola (ObsadaID, RolaID, FilmID, RodzajRoli)
VALUES ('797623', '522638', '521232', 'Główny aktor');
INSERT INTO Rola (ObsadaID, RolaID, FilmID, RodzajRoli)
VALUES ('727623', '522000', '521232', 'Reżyser');
INSERT INTO Rola (ObsadaID, RolaID, FilmID, RodzajRoli)
VALUES ('737623', '522001', '521232', 'Scenarzysta');
INSERT INTO Rola (ObsadaID, RolaID, FilmID, RodzajRoli)
VALUES ('758623', '522002', '521232', 'Aktor Drugoplanowy');
----
INSERT INTO NagrodaFilm (NagrodaFilmID, NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('127623', 'Złota Palma', '2001-12-08', NULL, '524362', NULL);
INSERT INTO NagrodaFilm (NagrodaFilmID, NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('137623', 'Złota Palma', '2001-12-08', NULL, '524362', NULL);
INSERT INTO NagrodaFilm (NagrodaFilmID, NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('147623', 'Złota Palma', '2001-12-08', NULL, '524362', NULL);
INSERT INTO NagrodaFilm (NagrodaFilmID, NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('157623', 'Złota Palma', '2001-12-08', NULL, '521232', NULL);
INSERT INTO NagrodaFilm (NagrodaFilmID, NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('167623', 'Złota Palma', '2001-12-08', NULL, '521232', NULL);
INSERT INTO NagrodaAktor (NagrodaAktorID, ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('087623', '758623','521232', 'Oskar', '2014-08-26', NULL, NULL);
INSERT INTO NagrodaAktor (NagrodaAktorID, ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('097623', '737623','532789', 'Oskar', '2014-08-26', NULL, NULL);
INSERT INTO NagrodaAktor (NagrodaAktorID, ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('077623', '727623','523801', 'Oskar', '1967-04-06', NULL, NULL);
INSERT INTO NagrodaAktor (NagrodaAktorID, ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('067623', '797623','524362', 'Oskar', '1967-04-06', NULL, NULL);
INSERT INTO NagrodaAktor (NagrodaAktorID, ObsadaID,FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('057623', '787623', '523698','Oskar', '1967-04-06', NULL, NULL)