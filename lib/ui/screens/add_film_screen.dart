import 'package:flutter/material.dart';

class AddFilmScreen extends StatefulWidget {
  const AddFilmScreen({Key? key}) : super(key: key);

  @override
  State<AddFilmScreen> createState() => _AddFilmScreenState();
}

class _AddFilmScreenState extends State<AddFilmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodanie filmu'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
