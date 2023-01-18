import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/expanded_button.dart';

class AddFilmScreen extends StatefulWidget {
  const AddFilmScreen({Key? key}) : super(key: key);

  @override
  State<AddFilmScreen> createState() => _AddFilmScreenState();
}

class _AddFilmScreenState extends State<AddFilmScreen> {
  final GlobalKey<FormState> _formState = GlobalKey();
  final GlobalKey<FormFieldState<int>> _durationFieldKey = GlobalKey();
  int duration = 0;
  final GlobalKey<FormFieldState<String>> _dateOfProdFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _genreFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _nameFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodanie filmu'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formState,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  key: _nameFieldKey,
                  validator: (value) =>
                      value!.isEmpty ? 'Nazwa nie może być pusta' : null,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Nazwa filmu'),
                ),
                TextFormField(
                  key: _genreFieldKey,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Gatunek'),
                ),
                TextFormField(
                  key: _dateOfProdFieldKey,
                  validator: (value) => value!.isEmpty
                      ? 'Data produkcji nie może być pusta'
                      : _checkDateFormat(value),
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(labelText: 'Data produkcji'),
                ),
                TextFormField(
                  key: _durationFieldKey,
                  validator: (value) {
                    value!.isEmpty ? 'Czas trwania nie może być pusty' : null;
                    duration = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Czas trwania'),
                ),
                ExpandedButton(
                  onTap: _validateAndLogin,
                  text: 'Dodaj film',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _checkDateFormat(String input) {
    if (RegExp(
            r'([1-2][0-9][0-9][0-9])-(0?[1-9]|1[012])-([12][0-9]|3[01]|0?[1-9])')
        .hasMatch(input)) {
      return null;
    } else {
      return 'Niepoprawny format. Przykład: 2001-04-12';
    }
  }

  _validateAndLogin() async {
    if (_formState.currentState!.validate()) {
      Film film = Film(
          1,
          duration,
          _dateOfProdFieldKey.currentState!.value!,
          _genreFieldKey.currentState!.value ?? 'NULL',
          _nameFieldKey.currentState!.value!,
          2);
      context.read<DatabaseService>().addFilm(film);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Dodano film.',
        textAlign: TextAlign.center,
      )));
    }
  }
}
