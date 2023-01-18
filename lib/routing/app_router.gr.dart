// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    WelcomeScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    RegisterScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    FilmScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FilmScreenRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: FilmScreen(
          key: args.key,
          film: args.film,
        ),
      );
    },
    PersonScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PersonScreenRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PersonScreen(
          key: args.key,
          person: args.person,
        ),
      );
    },
    ModerateCommentsScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ModerateCommentsScreen(),
      );
    },
    AddActorScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AddActorScreen(),
      );
    },
    AddFilmScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AddFilmScreen(),
      );
    },
    DBConnectionEditScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DBConnectionEditScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          WelcomeScreenRoute.name,
          path: '/',
        ),
        RouteConfig(
          LoginScreenRoute.name,
          path: '/login-screen',
        ),
        RouteConfig(
          RegisterScreenRoute.name,
          path: '/register-screen',
        ),
        RouteConfig(
          HomeScreenRoute.name,
          path: '/home-screen',
        ),
        RouteConfig(
          FilmScreenRoute.name,
          path: '/film-screen',
        ),
        RouteConfig(
          PersonScreenRoute.name,
          path: '/person-screen',
        ),
        RouteConfig(
          ModerateCommentsScreenRoute.name,
          path: '/moderate-comments-screen',
        ),
        RouteConfig(
          AddActorScreenRoute.name,
          path: '/add-actor-screen',
        ),
        RouteConfig(
          AddFilmScreenRoute.name,
          path: '/add-film-screen',
        ),
        RouteConfig(
          DBConnectionEditScreenRoute.name,
          path: '/d-bconnection-edit-screen',
        ),
      ];
}

/// generated route for
/// [WelcomeScreen]
class WelcomeScreenRoute extends PageRouteInfo<void> {
  const WelcomeScreenRoute()
      : super(
          WelcomeScreenRoute.name,
          path: '/',
        );

  static const String name = 'WelcomeScreenRoute';
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [RegisterScreen]
class RegisterScreenRoute extends PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(
          RegisterScreenRoute.name,
          path: '/register-screen',
        );

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [FilmScreen]
class FilmScreenRoute extends PageRouteInfo<FilmScreenRouteArgs> {
  FilmScreenRoute({
    Key? key,
    required Film film,
  }) : super(
          FilmScreenRoute.name,
          path: '/film-screen',
          args: FilmScreenRouteArgs(
            key: key,
            film: film,
          ),
        );

  static const String name = 'FilmScreenRoute';
}

class FilmScreenRouteArgs {
  const FilmScreenRouteArgs({
    this.key,
    required this.film,
  });

  final Key? key;

  final Film film;

  @override
  String toString() {
    return 'FilmScreenRouteArgs{key: $key, film: $film}';
  }
}

/// generated route for
/// [PersonScreen]
class PersonScreenRoute extends PageRouteInfo<PersonScreenRouteArgs> {
  PersonScreenRoute({
    Key? key,
    required Person person,
  }) : super(
          PersonScreenRoute.name,
          path: '/person-screen',
          args: PersonScreenRouteArgs(
            key: key,
            person: person,
          ),
        );

  static const String name = 'PersonScreenRoute';
}

class PersonScreenRouteArgs {
  const PersonScreenRouteArgs({
    this.key,
    required this.person,
  });

  final Key? key;

  final Person person;

  @override
  String toString() {
    return 'PersonScreenRouteArgs{key: $key, person: $person}';
  }
}

/// generated route for
/// [ModerateCommentsScreen]
class ModerateCommentsScreenRoute extends PageRouteInfo<void> {
  const ModerateCommentsScreenRoute()
      : super(
          ModerateCommentsScreenRoute.name,
          path: '/moderate-comments-screen',
        );

  static const String name = 'ModerateCommentsScreenRoute';
}

/// generated route for
/// [AddActorScreen]
class AddActorScreenRoute extends PageRouteInfo<void> {
  const AddActorScreenRoute()
      : super(
          AddActorScreenRoute.name,
          path: '/add-actor-screen',
        );

  static const String name = 'AddActorScreenRoute';
}

/// generated route for
/// [AddFilmScreen]
class AddFilmScreenRoute extends PageRouteInfo<void> {
  const AddFilmScreenRoute()
      : super(
          AddFilmScreenRoute.name,
          path: '/add-film-screen',
        );

  static const String name = 'AddFilmScreenRoute';
}

/// generated route for
/// [DBConnectionEditScreen]
class DBConnectionEditScreenRoute extends PageRouteInfo<void> {
  const DBConnectionEditScreenRoute()
      : super(
          DBConnectionEditScreenRoute.name,
          path: '/d-bconnection-edit-screen',
        );

  static const String name = 'DBConnectionEditScreenRoute';
}
