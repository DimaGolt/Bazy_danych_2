import 'package:bazy_flutter/routing/app_router.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _approuter = AppRouter();

  final Map<int, Color> _green700Map = {
    50: Color(0xFFFFD7C2),
    100: Colors.green[100]!,
    200: Colors.green[200]!,
    300: Colors.green[300]!,
    400: Colors.green[400]!,
    500: Colors.green[500]!,
    600: Colors.green[600]!,
    700: Colors.green[800]!,
    800: Colors.green[900]!,
    900: Colors.green[700]!,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.greenAccent.value, _green700Map),
      ),
      routerDelegate: _approuter.delegate(),
      routeInformationParser: _approuter.defaultRouteParser(),
    );
  }
}
