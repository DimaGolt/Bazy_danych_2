import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/app_router.dart';
import '../../services/database_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late DatabaseService dbService;
  final ValueNotifier<bool> _passwordIsObscuredNotifier = ValueNotifier(true);

  final GlobalKey<FormState> _formState = GlobalKey();
  final GlobalKey<FormFieldState<String>> _usernameFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dbService = Provider.of<DatabaseService>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejestracja'),
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
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  focusNode: _usernameNode,
                  key: _usernameFieldKey,
                  keyboardType: TextInputType.name,
                  validator: (value) => value!.isNotEmpty
                      ? null
                      : 'Nazwa użytkownika nie może być pusta',
                  decoration: InputDecoration(labelText: 'Nazwa użytkownika'),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _passwordIsObscuredNotifier,
                builder: (context, isObscured, _) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      focusNode: _passwordNode,
                      key: _passwordFieldKey,
                      obscureText: isObscured,
                      validator: (value) =>
                          value!.isNotEmpty ? null : "Hasło nie może być puste",
                      decoration: InputDecoration(
                        labelText: 'Hasło',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              _passwordIsObscuredNotifier.value = !isObscured,
                          icon: const Icon(Icons.remove_red_eye_rounded),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ExpandedButton(
                  onTap: _validateAndRegister,
                  text: 'Zarejestruj',
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Masz już konto? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.router.popAndPush(const LoginScreenRoute()),
                    child: const Text(
                      'Zaloguj się!',
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

  void _validateAndRegister() async {
    if (_formState.currentState!.validate()) {
      var result = await dbService.register(
          _usernameFieldKey.currentState!.value!,
          _passwordFieldKey.currentState!.value!);
      result
          ? context.replaceRoute(const HomeScreenRoute())
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Nie udało się zarejestrować')));
    }
  }
}
