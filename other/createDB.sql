CREATE TABLE Film (
FilmID int not null AUTO_INCREMENT,
CzasTrwania int,
RokProdukcji date,
Gatunek varchar(20),
Nazwa varchar(20),
LinkDoPlakatu varchar(20),
PRIMARY KEY (FilmID)
);
CREATE TABLE Obsada (
ObsadaID int not null AUTO_INCREMENT,
Imie varchar(20) not null,
Nazwisko varchar(20) not null,
DataUrodzenia date,
DataSmierci date,
KrajUrodzenia varchar(20),
PRIMARY KEY (ObsadaID)
);
CREATE TABLE Rola (
RolaID int not null AUTO_INCREMENT,
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
NagrodaAktorID int not null AUTO_INCREMENT,
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
KomentarzID int not null AUTO_INCREMENT,
FilmID int not null,
UzytkownikID int not null,
Tresc varchar(200) not null,
PRIMARY KEY (KomentarzID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID)
);
--------------------------
CREATE TABLE Ocena (
OcenyID int not NULL AUTO_INCREMENT,
FilmID int not NULL,
UzytkownikID int not NULL,
Wartosc int not NULL,
PRIMARY KEY (OcenyID),
FOREIGN KEY (FilmID) REFERENCES Film(FilmID),
FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownik(UzytkownikID)
);
CREATE TABLE Recenzja (
RecenzjaID int not NULL AUTO_INCREMENT,
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
NagrodaFilmID int not null AUTO_INCREMENT,
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
SELECT r.FilmID as "ID", r.ObsadaId, r.RodzajRoli, o.Imie, o.Nazwisko,
 o.DataUrodzenia, o.DataSmierci, o.KrajUrodzenia 
FROM Rola r JOIN Obsada o WHERE r.ObsadaId = o.ObsadaId;

CREATE VIEW KomentarzeWidok AS
SELECT k.KomentarzId as "Id", k.FilmId, u.Login, k.Tresc
FROM Komentarz k JOIN Uzytkownik u WHERE k.UzytkownikId = u.UzytkownikId;

CREATE VIEW RecenzjeWidok AS
SELECT k.RecenzjaID as "Id", k.FilmId, u.Login, k.Tresc
FROM Recenzja k JOIN Uzytkownik u WHERE k.UzytkownikId = u.UzytkownikId;

CREATE VIEW NagrodyAktorWidok AS
SELECT a.NagrodaAktorID as "Id", a.ObsadaID, a.NazwaNagrody, a.DataPrzyznania, f.Nazwa
FROM NagrodaAktor a JOIN Film f WHERE a.FilmID = f.FilmID;

CREATE VIEW AktorzyWidok AS
SELECT Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia
FROM Obsada;

INSERT INTO Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('162', '2003-04-21', 'Thriller', 'Below Zero', '/plakaty/23859254');
INSERT INTO Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('184', '2004-11-27', 'Komedia', 'Free Guy', '/plakaty/238292236');
INSERT INTO Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('97', '2015-02-03', 'Akcji', 'Nobody', '/plakaty/23859987');
INSERT INTO Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('121', '2013-08-11', 'Fantasy', 'Constantine', '/plakaty/234359254');
INSERT INTO Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu)
VALUES ('112', '2020-12-27', 'NULL', 'Morbius', 'NULL');
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
INSERT INTO Uzytkownik (Login, Haslo, PoziomDostepu)
VALUES ('admin', 'root', '0');
INSERT INTO Komentarz (FilmID, UzytkownikID, Tresc)
VALUES ('5', '1', 'fajne');
INSERT INTO Komentarz (FilmID, UzytkownikID, Tresc)
VALUES ('4', '2', 'ok');
INSERT INTO Komentarz (FilmID, UzytkownikID, Tresc)
VALUES ( '3', '3', 'zasnalem');
INSERT INTO Komentarz (FilmID, UzytkownikID, Tresc)
VALUES ( '2', '4', 'nie polecam');
INSERT INTO Komentarz (FilmID, UzytkownikID, Tresc)
VALUES ( '1', '5', 'Część większego dzieła, serdecznie polecam');
INSERT INTO Recenzja (FilmID, UzytkownikID, Tresc)
VALUES ('1', '3', 'Słaba produkcja, scenografia i muzyka.');
INSERT INTO Recenzja (FilmID, UzytkownikID, Tresc)
VALUES ('1', '1', 'Bardzo dobra gra aktorska, zasłużony Oskar');
INSERT INTO Recenzja (FilmID, UzytkownikID, Tresc)
VALUES ('1', '2', 'Główny bohater bez wyrazu, poza tym genialna muzyka i 
scenografia');
INSERT INTO Recenzja (FilmID, UzytkownikID, Tresc)
VALUES ('4', '2', 'Spory przeskok między pierwszą częścią, niestety na 
niekorzyść twórcy');
INSERT INTO Recenzja (FilmID, UzytkownikID, Tresc)
VALUES ('4', '4', 'Bardzo dobra gra aktorska, zasłużony Oskar');
INSERT INTO Ocena (FilmID, UzytkownikID, Wartosc)
VALUES ('1', '2', '5');
INSERT INTO Ocena (FilmID, UzytkownikID, Wartosc)
VALUES ('2', '1', '4');
INSERT INTO Ocena (FilmID, UzytkownikID, Wartosc)
VALUES ('3', '3', '3');
INSERT INTO Ocena (FilmID, UzytkownikID, Wartosc)
VALUES ('4', '2', '2');
INSERT INTO Ocena (FilmID, UzytkownikID, Wartosc)
VALUES ('5', '4', '1');
-----------------------
INSERT INTO Obsada (Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('Andrzej', 'Matysiak', '1967-04-06', NULL, 'Polska');
INSERT INTO Obsada (Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('Marcin', 'Matysiak', '1997-04-08', NULL, 'Polska');
INSERT INTO Obsada (Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('Sławomir', 'Żbik', '1983-09-24', NULL, 'Polska');
INSERT INTO Obsada (Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('Danuta', 'Wajda', '1999-07-12', NULL, 'Polska');
INSERT INTO Obsada (Imie, Nazwisko, DataUrodzenia, DataSmierci, KrajUrodzenia)
VALUES ('Andrzej', 'Wojciechowski', '2002-10-10', NULL, 'Polska');
INSERT INTO Rola (ObsadaID, FilmID, RodzajRoli)
VALUES ('1', '1', 'Scenarzysta');
INSERT INTO Rola (ObsadaID, FilmID, RodzajRoli)
VALUES ('2', '1', 'Główny aktor');
INSERT INTO Rola (ObsadaID, FilmID, RodzajRoli)
VALUES ('3', '1', 'Reżyser');
INSERT INTO Rola (ObsadaID, FilmID, RodzajRoli)
VALUES ('4', '1', 'Scenarzysta');
INSERT INTO Rola (ObsadaID,  FilmID, RodzajRoli)
VALUES ('5', '1', 'Aktor Drugoplanowy');
----
INSERT INTO NagrodaFilm (NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('Złota Palma', '2001-12-08', NULL, '1', NULL);
INSERT INTO NagrodaFilm (NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('Złota Palma', '2001-12-08', NULL, '2', NULL);
INSERT INTO NagrodaFilm (NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('Złota Palma', '2001-12-08', NULL, '3', NULL);
INSERT INTO NagrodaFilm (NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('Złota Palma', '2001-12-08', NULL, '4', NULL);
INSERT INTO NagrodaFilm (NazwaNagrody, DataPrzyznania, MiejscePrzyznania, 
FilmID, Kategoria)
VALUES ('Złota Palma', '2001-12-08', NULL, '5', NULL);
INSERT INTO NagrodaAktor (ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('5','1', 'Oskar', '2014-08-26', NULL, NULL);
INSERT INTO NagrodaAktor (ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('4','1', 'Oskar', '2014-08-26', NULL, NULL);
INSERT INTO NagrodaAktor (ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('3','1', 'Oskar', '1967-04-06', NULL, NULL);
INSERT INTO NagrodaAktor (ObsadaID, FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('2','1', 'Oskar', '1967-04-06', NULL, NULL);
INSERT INTO NagrodaAktor (ObsadaID,FilmID, NazwaNagrody, DataPrzyznania, 
MiejscePrzyznania, Kategoria)
VALUES ('1', '1','Oskar', '1967-04-06', NULL, NULL)