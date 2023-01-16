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
      appBar: AppBar(),
      body: Form(
        key: _formState,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _usernameNode,
                  key: _loginFieldKey,
                  validator: (value) => value!.isEmpty
                      ? 'Nazwa użytkownika nie może być pusta'
                      : null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _passwordIsObscuredNotifier,
                builder: (context, isObscured, _) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _passwordNode,
                      key: _passwordFieldKey,
                      validator: (value) =>
                          value!.isEmpty ? 'Hasło nie może być puste' : null,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () =>
                              _passwordIsObscuredNotifier.value = !isObscured,
                          icon: Icon(Icons.remove_red_eye_rounded),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  );
                },
              ),
              ExpandedButton(
                onTap: _validateAndLogin,
                text: 'Login',
              )
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
      result ? context.replaceRoute(const HomeScreenRoute()) : print('bruh');
    }
  }
}
