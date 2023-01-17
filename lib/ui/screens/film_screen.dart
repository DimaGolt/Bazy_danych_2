import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/film_rating.dart';
import 'package:bazy_flutter/ui/widgets/person_widget.dart';
import 'package:bazy_flutter/ui/widgets/prize_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/person.dart';
import '../../models/comment.dart';
import '../../models/prize.dart';
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
  late Future<List<Comment>> futureProfessionalOpinion;
  late Future<int?> futureRating;
  late Future<List<Prize>> futurePrizes;
  List<Person> cast = [];

  Film get film => widget.film;

  @override
  void initState() {
    _refreshCast();
    _refreshComments();
    _refreshOpinion();
    _getPreviousRating();
    _getPrizes();
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

  _refreshOpinion() {
    futureProfessionalOpinion =
        context.read<DatabaseService>().getOpinion(film.id);
  }

  _getPreviousRating() {
    futureRating = context.read<DatabaseService>().getRating(film.id);
  }

  _getPrizes() {
    futurePrizes = context.read<DatabaseService>().getFilmPrizes(film.id);
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
            _refreshOpinion();
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
              ..._prizes(),
              ..._cast(),
              ..._comments(),
              ..._professionalOpinion(),
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
                const Text('Coś poszło nie tak. Spróbuj ponownie'),
                ExpandedButton(
                  active: true,
                  onTap: _getPreviousRating(),
                  text: 'Spróbuj ponownie',
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
      FutureBuilder(
        future: futureCast,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data!.isNotEmpty) {
              cast.addAll(snap.data!);
              return SizedBox(
                height: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      return PersonWidget(person: snap.data!.elementAt(index));
                    }),
              );
            } else {
              return const SizedBox();
            }
          } else if (snap.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const Text('Coś poszło nie tak. Spróbuj ponownie'),
                  ExpandedButton(
                    onTap: _refreshCast,
                    text: 'Spróbuj ponownie',
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
                  const Text('Coś poszło nie tak. Spróbuj ponownie'),
                  ExpandedButton(
                    onTap: _refreshComments,
                    text: 'Spróbuj ponownie',
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

  _professionalOpinion() {
    return [
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Recenzje',
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
            )
          ],
        ),
      ),
      FutureBuilder(
        future: futureProfessionalOpinion,
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data!.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snap.data!
                        .map((comment) => CommentTile(
                              comment: comment,
                              professional: true,
                            ))
                        .toList(),
                  )
                : Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(' Nie ma recenzji'),
                      ],
                    ),
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
                  const Text('Coś poszło nie tak. Spróbuj ponownie'),
                  ExpandedButton(
                    onTap: _refreshComments,
                    text: 'Spróbuj ponownie',
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

  _prizes() {
    return [
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Nagrody',
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.diamond_outlined,
              color: Colors.blue,
            )
          ],
        ),
      ),
      FutureBuilder(
        future: futurePrizes,
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data!.isNotEmpty
                ? SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, index) {
                          return PrizeWidget(
                              prize: snap.data!.elementAt(index));
                        }),
                  )
                : Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(' Nie ma recenzji'),
                      ],
                    ),
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
                  const Text('Coś poszło nie tak. Spróbuj ponownie'),
                  ExpandedButton(
                    onTap: _getPrizes(),
                    text: 'Spróbuj ponownie',
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
