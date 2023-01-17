import 'package:bazy_flutter/models/film.dart';
import 'package:flutter/material.dart';

class FilmScreen extends StatelessWidget {
  final Film film;
  const FilmScreen({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(film.name),
            ],
          ),
        ),
      ),
    );
  }
}
