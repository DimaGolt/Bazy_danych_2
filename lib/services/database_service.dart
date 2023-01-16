import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../models/user.dart';

class DatabaseService extends ChangeNotifier {
  late MySQLConnection database;
  User? user;

  connectToDB() async {
    database = await MySQLConnection.createConnection(
      host: "10.0.2.2",
      port: 3306,
      userName: "root",
      password: "Password1!",
    );

    await database.connect();
  }

  fetchData() async {
    var result = await database.execute('SELECT * FROM Based.Uzytkownik');
    print(result.rows.elementAt(2).colAt(1));
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
        "INSERT INTO Based.Uzytkownik (Login, Haslo, PoziomDostepu) VALUES ('$username', '$password', '1')");
    var result = await database.execute(
        "SELECT * FROM Based.Uzytkownik WHERE Login = :username AND Haslo = :password",
        {"username": username, "password": password});
    if (result.rows.isNotEmpty) {
      user = User(int.parse(result.rows.first.colAt(0)!),
          result.rows.first.colAt(1)!, int.parse(result.rows.first.colAt(3)!));
    }

    return user == null ? false : true;
  }
}
