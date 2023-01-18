import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/ui/screens/add_actor_screen.dart';
import 'package:bazy_flutter/ui/screens/add_film_screen.dart';
import 'package:bazy_flutter/ui/screens/home_screen.dart';
import 'package:bazy_flutter/ui/screens/moderate_comments_screen.dart';
import 'package:bazy_flutter/ui/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';

import '../models/film.dart';
import '../models/person.dart';
import '../ui/screens/film_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/person_screen.dart';
import '../ui/screens/welcome_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: WelcomeScreen, initial: true),
  AutoRoute(page: LoginScreen),
  AutoRoute(page: RegisterScreen),
  AutoRoute(page: HomeScreen),
  AutoRoute(page: FilmScreen),
  AutoRoute(page: PersonScreen),
  AutoRoute(page: ModerateCommentsScreen),
  AutoRoute(page: AddActorScreen),
  AutoRoute(page: AddFilmScreen),
  // AutoRoute(page: DeveloperScreen),
])

// extend the generated private router
class AppRouter extends _$AppRouter {}
