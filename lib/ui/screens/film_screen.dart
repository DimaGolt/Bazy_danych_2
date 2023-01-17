import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/person_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/person.dart';
import '../widgets/expanded_button.dart';

class FilmScreen extends StatefulWidget {
  final Film film;
  const FilmScreen({Key? key, required this.film}) : super(key: key);

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  late Future<List<Person>> futureCast;
  List<Person> cast = [];

  @override
  void initState() {
    _refreshCast();
    super.initState();
  }

  _refreshCast() {
    futureCast = context.read<DatabaseService>().getPeople(widget.film.id)
      ..then((value) {
        cast.addAll(value);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.film.name),
              SizedBox(height: 20),
              ..._cast(),
            ],
          ),
        ),
      ),
    );
  }

  _cast() {
    return [
      if (cast.isNotEmpty) Text('Obsada'),
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
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Text('Something went wrong. Please, try again'),
                    ExpandedButton(
                      onTap: _refreshCast,
                      text: 'Retry',
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ];
  }
}
