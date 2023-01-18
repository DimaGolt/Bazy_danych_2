import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/models/person.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:bazy_flutter/ui/widgets/film_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../routing/app_router.dart';
import '../widgets/person_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final User? _user;

  @override
  void initState() {
    _user = context.read<DatabaseService>().user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.greenAccent,
          child: const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.dataset_outlined)),
              Tab(icon: Icon(Icons.people_sharp)),
              Tab(icon: Icon(Icons.account_circle_outlined)),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _filmListTab(context),
              _peopleListTab(context),
              _profileTab(context),
            ],
          ),
        ),
      ),
    );
  }

  _filmListTab(BuildContext context) {
    Future<List<Film>> futureFilms = context.read<DatabaseService>().getFilms();
    return FutureBuilder(
        future: futureFilms,
        builder: (_, snap) {
          if (snap.hasData) {
            return RefreshIndicator(
              onRefresh: () =>
                  futureFilms = context.read<DatabaseService>().getFilms()
                    ..then((value) => setState(() {})),
              child: ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    var film = snap.data!.elementAt(index);
                    return FilmListTile(
                      onTap: () =>
                          context.router.push(FilmScreenRoute(film: film)),
                      film: film,
                    );
                  }),
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
                    onTap: () {
                      futureFilms = context.read<DatabaseService>().getFilms();
                    },
                    text: 'Spróbuj ponownie',
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _peopleListTab(BuildContext context) {
    Future<List<Person>> futurePeople =
        context.read<DatabaseService>().getPeople();
    return FutureBuilder(
        future: futurePeople,
        builder: (_, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  var person = snap.data!.elementAt(index);
                  return PersonListTile(
                    onTap: () =>
                        context.router.push(PersonScreenRoute(person: person)),
                    person: person,
                  );
                });
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
                    onTap: () {
                      futurePeople =
                          context.read<DatabaseService>().getPeople();
                    },
                    text: 'Spróbuj ponownie',
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _profileTab(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(1.5, 1.5),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(_user?.username ?? 'Nie zalogowany'),
                ],
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_user != null && _user?.accessLevel == 0) ...[
              ExpandedButton(
                text: 'Moderacja komentarzy',
                onTap: () =>
                    context.router.push(const ModerateCommentsScreenRoute()),
              ),
              ExpandedButton(
                text: 'Dodanie filmów',
                onTap: () => context.router.push(const AddFilmScreenRoute()),
              ),
              // ExpandedButton(
              //   text: 'Dodanie aktorów',
              //   onTap: () => context.router.push(const AddActorScreenRoute()),
              // )
            ],
            ExpandedButton(
              onTap: () {
                context.read<DatabaseService>().deleteUser();
                context.router.pop();
              },
              text: _user == null ? 'Zaloguj' : 'Wyloguj',
            ),
            const SizedBox(height: 10),
          ],
        )
      ],
    );
  }
}
