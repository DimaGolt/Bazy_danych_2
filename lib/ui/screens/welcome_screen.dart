import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../routing/app_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _connectDb();
  }

  _connectDb() {
    Provider.of<DatabaseService>(context, listen: false).connectToDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpandedButton(
            text: 'Logowanie',
            onTap: () => context.router.push(const LoginScreenRoute()),
          ),
          ExpandedButton(
            text: 'Rejestracja',
            onTap: () => context.router.push(const RegisterScreenRoute()),
          ),
          ExpandedButton(
            onTap: () => context.router.push(const HomeScreenRoute()),
            text: 'Pomiń',
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => context.router.push(const DBConnectionEditScreenRoute()),
          child: TextLiquidFill(
            text: 'Bazy danych 2',
            waveColor: Colors.greenAccent,
            boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            textStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
