import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/routing/app_router.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/screens/home_screen.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late DatabaseService dbService;
  final ValueNotifier<bool> _passwordIsObscuredNotifier = ValueNotifier(true);

  final GlobalKey<FormState> _formState = GlobalKey();
  final GlobalKey<FormFieldState<String>> _loginFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dbService = Provider.of<DatabaseService>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logowanie'),
        centerTitle: true,
      ),
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  key: _loginFieldKey,
                  validator: (value) => value!.isEmpty
                      ? 'Nazwa użytkownika nie może być pusta'
                      : null,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(labelText: 'Nazwa użytkownika'),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _passwordIsObscuredNotifier,
                builder: (context, isObscured, _) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      key: _passwordFieldKey,
                      validator: (value) =>
                          value!.isEmpty ? 'Hasło nie może być puste' : null,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () =>
                              _passwordIsObscuredNotifier.value = !isObscured,
                          icon: const Icon(Icons.remove_red_eye_rounded),
                        ),
                        labelText: 'Hasło',
                      ),
                    ),
                  );
                },
              ),
              ExpandedButton(
                onTap: _validateAndLogin,
                text: 'Zaloguj',
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nie masz konta? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.router.popAndPush(const RegisterScreenRoute()),
                    child: const Text(
                      'Zarejestruj się!',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateAndLogin() async {
    if (_formState.currentState!.validate()) {
      var result = await dbService.login(_loginFieldKey.currentState!.value!,
          _passwordFieldKey.currentState!.value!);
      result
          ? context.replaceRoute(const HomeScreenRoute())
          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
              'Nie udało się zalogować. Nazwa użytkownika lub hasło jest niepoprawne.',
              textAlign: TextAlign.center,
            )));
    }
  }
}
