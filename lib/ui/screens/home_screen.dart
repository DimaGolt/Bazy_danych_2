import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/screens/film_screen.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:bazy_flutter/ui/widgets/film_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.greenAccent,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dataset_outlined)),
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.account_circle_outlined)),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _filmListTab(context),
              Image.asset("assets/pikachu.gif"),
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
            return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  var film = snap.data!.elementAt(index);
                  return FilmListTile(
                    onTap: () =>
                        context.router.push(FilmScreenRoute(film: film)),
                    film: film,
                  );
                });
          } else if (snap.hasError) {
            return Column(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Text('Something went wrong. Please, try again'),
                ExpandedButton(
                  onTap: () {
                    futureFilms = context.read<DatabaseService>().getFilms();
                  },
                  text: 'Retry',
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  _profileTab(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 50,
            ),
            Text(context.read<DatabaseService>().user?.username ??
                'Not logged in'),
          ],
        ),
        ExpandedButton(
          onTap: () {
            context.read<DatabaseService>().deleteUser();
            context.router.pop();
          },
          text: context.read<DatabaseService>().user == null
              ? 'Sign in'
              : 'Logout',
        )
      ],
    );
  }
}
