import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/film_rating.dart';
import 'package:bazy_flutter/ui/widgets/person_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/person.dart';
import '../../models/comment.dart';
import '../widgets/comment_tile.dart';
import '../widgets/expanded_button.dart';
import '../widgets/new_comment_widget.dart';

class FilmScreen extends StatefulWidget {
  final Film film;
  const FilmScreen({Key? key, required this.film}) : super(key: key);

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  late Future<List<Person>> futureCast;
  late Future<List<Comment>> futureComments;
  late Future<int?> futureRating;
  List<Person> cast = [];

  Film get film => widget.film;

  @override
  void initState() {
    _refreshCast();
    _refreshComments();
    _getPreviousRating();
    super.initState();
  }

  _refreshCast() {
    futureCast = context.read<DatabaseService>().getPeople(film.id)
      ..then((value) {
        cast.addAll(value);
        setState(() {});
      });
  }

  _refreshComments() {
    futureComments = context.read<DatabaseService>().getComments(film.id);
  }

  _getPreviousRating() {
    futureRating = context.read<DatabaseService>().getRating(film.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.name),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: NewCommentWidget(
          film: film,
          afterSubmit: () {
            _refreshComments();
            setState(() {});
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ..._filmDesc(),
              _filmRating(),
              const SizedBox(height: 20),
              ..._cast(),
              ..._comments(),
            ],
          ),
        ),
      ),
    );
  }

  _filmDesc() {
    return [
      Text('Czas trwania: ${film.length}'),
      Text('Rok produkcji: ${film.dateOfProd}'),
      if (film.genre != 'NULL') Text('Gatunek: ${film.genre}'),
      Text('Średnia ocena: ${film.rating.toStringAsFixed(2)}')
    ];
  }

  _filmRating() {
    return FutureBuilder(
      future: futureRating,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return FilmRating(
            previousValue: snap.data,
            film: film,
          );
        } else if (snap.hasError) {
          return Center(
            child: Column(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                const Text('Something went wrong. Please, try again'),
                ExpandedButton(
                  active: true,
                  onTap: _getPreviousRating(),
                  text: 'Retry',
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _cast() {
    return [
      if (cast.isNotEmpty) const Center(child: Text('Obsada')),
      SizedBox(
        height: 150,
        child: FutureBuilder(
          future: futureCast,
          builder: (context, snap) {
            if (snap.hasData) {
              cast.addAll(snap.data!);
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return PersonWidget(person: snap.data!.elementAt(index));
                  });
            } else if (snap.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    const Text('Something went wrong. Please, try again'),
                    ExpandedButton(
                      onTap: _refreshCast,
                      text: 'Retry',
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ];
  }

  _comments() {
    return [
      const Center(child: Text('Komentarze')),
      FutureBuilder(
        future: futureComments,
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data!.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snap.data!
                        .map((comment) => CommentTile(comment: comment))
                        .toList(),
                  )
                : const Center(
                    child: Text(' Nie ma komentarzy'),
                  );
          } else if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const Text('Something went wrong. Please, try again'),
                  ExpandedButton(
                    onTap: _refreshComments,
                    text: 'Retry',
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ];
  }
}
