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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _approuter.delegate(),
      routeInformationParser: _approuter.defaultRouteParser(),
    );
  }
}
