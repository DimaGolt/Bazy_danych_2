import 'package:flutter/material.dart';

import '../../models/film.dart';

class FilmListTile extends StatelessWidget {
  final Film film;
  final Function? onTap;
  const FilmListTile({Key? key, required this.film, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 5,
        child: InkWell(
          onTap: () => onTap?.call(),
          child: ListTile(
            title: Center(child: Text(film.name)),
            subtitle: Column(
              children: [
                if (film.genre != 'NULL') Text('Gatunek: ${film.genre}'),
                if (film.dateOfProd != 'NULL')
                  Text('Data produkcji: ${film.dateOfProd}'),
              ],
            ),
            trailing: Text('${film.length} min'),
          ),
        ),
      ),
    );
  }
}
