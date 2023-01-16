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
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      focusNode: _usernameNode,
                      key: _usernameFieldKey,
                      keyboardType: TextInputType.name,
                      validator: (value) => value!.isNotEmpty
                          ? null
                          : 'Nazwa użytkownika nie może być pusta', //TODO: check unique username
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _passwordIsObscuredNotifier,
                    builder: (context, isObscured, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          focusNode: _passwordNode,
                          key: _passwordFieldKey,
                          obscureText: isObscured,
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : "Hasło nie może być puste",
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => _passwordIsObscuredNotifier
                                  .value = !isObscured,
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
                  )
                ],
              ),
            ),
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
      result ? context.replaceRoute(const HomeScreenRoute()) : print('bruh');
    }
  }
}
