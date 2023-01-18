import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../models/film.dart';
import '../models/person.dart';
import '../models/prize.dart';
import '../models/user.dart';
import '../models/comment.dart';

class DatabaseService extends ChangeNotifier {
  late MySQLConnection database;
  User? user;

  connectToDB({String? ip}) async {
    database = await MySQLConnection.createConnection(
      host: ip ?? "10.0.2.2",
      port: 3306,
      userName: "root",
      password: "Password1!",
    );

    await database.connect();
  }

  Future<bool> login(String username, String password) async {
    var result = await database.execute(
        "SELECT * FROM Based.Uzytkownik WHERE Login = :username AND Haslo = :password",
        {"username": username, "password": password});
    if (result.rows.isNotEmpty) {
      user = User(int.parse(result.rows.first.colAt(0)!),
          result.rows.first.colAt(1)!, int.parse(result.rows.first.colAt(3)!));
    }

    return user == null ? false : true;
  }

  Future<bool> register(String username, String password) async {
    await database.execute(
        "INSERT INTO Based.Uzytkownik (Login, Haslo, PoziomDostepu) VALUES ('$username', '$password', '2')");
    var result = await database.execute(
        "SELECT * FROM Based.Uzytkownik WHERE Login = :username AND Haslo = :password",
        {"username": username, "password": password});
    if (result.rows.isNotEmpty) {
      user = User(int.parse(result.rows.first.colAt(0)!),
          result.rows.first.colAt(1)!, int.parse(result.rows.first.colAt(3)!));
    }

    return user == null ? false : true;
  }

  Future<List<Film>> getFilms() async {
    var result = await database.execute('SELECT * FROM Based.FilmyWidok;');
    List<Film> films = result.rows
        .map((row) => Film(
              int.parse(row.colAt(0)!),
              int.parse(row.colAt(2)!),
              row.colAt(3)!,
              row.colAt(4)!,
              row.colAt(1)!,
              double.tryParse(row.colAt(6) ?? ''),
            ))
        .toList();
    return films;
  }

  Future<void> addFilm(Film film) async {
    await database.execute(
        'INSERT INTO Based.Film (CzasTrwania, RokProdukcji, Gatunek, Nazwa, LinkDoPlakatu) VALUES (:duration, :dateOfProd, :genre, :name, \'NULL\')',
        {
          'duration': film.length,
          'dateOfProd': film.dateOfProd,
          'genre': film.genre.isNotEmpty ? film.genre : 'NULL',
          'name': film.name,
        });
  }

  Future<List<Person>> getPeopleForFilm(int filmId) async {
    var result = await database.execute(
        'SELECT * FROM Based.RolaWidok where id = :filmId', {"filmId": filmId});
    List<Person> people = result.rows
        .map((row) => Person(int.parse(row.colAt(1)!), row.colAt(2)!,
            row.colAt(3)!, row.colAt(4)!, row.colAt(5)!, row.colAt(7)!,
            dateOfDeath: row.colAt(6)))
        .toList();
    return people;
  }

  Future<List<Person>> getPeople() async {
    var result = await database.execute('SELECT * FROM Based.RolaWidok');
    List<Person> people = result.rows
        .map((row) => Person(int.parse(row.colAt(1)!), row.colAt(2)!,
            row.colAt(3)!, row.colAt(4)!, row.colAt(5)!, row.colAt(7)!,
            dateOfDeath: row.colAt(6)))
        .toList();
    return people;
  }

  Future<List<Comment>> getComments(int filmId) async {
    var result = await database.execute(
        'SELECT * FROM Based.KomentarzeWidok where FilmId = :filmId',
        {"filmId": filmId});
    List<Comment> comments = result.rows
        .map((row) =>
            Comment(int.parse(row.colAt(0)!), row.colAt(2)!, row.colAt(3)!))
        .toList();
    return comments;
  }

  Future<List<Comment>> getAllComments() async {
    var result = await database.execute('SELECT * FROM Based.KomentarzeWidok');
    List<Comment> comments = result.rows
        .map((row) =>
            Comment(int.parse(row.colAt(0)!), row.colAt(2)!, row.colAt(3)!))
        .toList();
    return comments;
  }

  Future<void> deleteComment(int commentId) async {
    await database
        .execute("DELETE FROM Based.Komentarz WHERE KomentarzID = $commentId");
  }

  Future<List<Comment>> getOpinion(int filmId) async {
    var result = await database.execute(
        'SELECT * FROM Based.RecenzjeWidok where FilmId = :filmId',
        {"filmId": filmId});
    List<Comment> comments = result.rows
        .map((row) =>
            Comment(int.parse(row.colAt(0)!), row.colAt(2)!, row.colAt(3)!))
        .toList();
    return comments;
  }

  Future<void> sendComment(int filmId, String desc) async {
    await database.execute(
        "INSERT INTO Based.Komentarz (FilmID, UzytkownikID, Tresc) VALUES ('$filmId', '${user!.userId}', '$desc')");
  }

  Future<void> sendOpinion(int filmId, String desc) async {
    await database.execute(
        "INSERT INTO Based.Recenzja (FilmID, UzytkownikID, Tresc) VALUES ('$filmId', '${user!.userId}', '$desc')");
  }

  Future<void> sendRating(int filmId, int rating) async {
    await database.execute(
        "INSERT INTO Based.Ocena (FilmID, UzytkownikID, Wartosc) VALUES ('$filmId', '${user!.userId}', '$rating')");
  }

  Future<int?> getRating(int filmId) async {
    var result = null;
    if (user != null) {
      result = await database.execute(
          "SELECT * FROM Based.Ocena where UzytkownikID = ${user!.userId} and FilmID = $filmId");
    }
    return int.tryParse(result?.rows.first.colAt(3) ?? '1f');
  }

  Future<List<Prize>> getFilmPrizes(int filmId) async {
    var result = await database
        .execute("SELECT * FROM Based.NagrodaFilm WHERE FilmID = $filmId");
    List<Prize> prizes = result.rows
        .map((row) => Prize(
            filmId: int.parse(row.colAt(1)!), row.colAt(2)!, row.colAt(3)!))
        .toList();
    return prizes;
  }

  Future<List<Prize>> getPersonPrizes(int personId) async {
    var result = await database.execute(
        "SELECT * FROM Based.NagrodyAktorWidok WHERE ObsadaID = $personId");
    List<Prize> prizes = result.rows
        .map((row) => Prize(
              row.colAt(2)!,
              row.colAt(3)!,
              personId: int.parse(row.colAt(1)!),
              filmName: row.colAt(4),
            ))
        .toList();
    return prizes;
  }

  void deleteUser() => user = null;
}
