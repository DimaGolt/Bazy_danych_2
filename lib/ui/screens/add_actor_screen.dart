import 'package:flutter/material.dart';

class AddActorScreen extends StatefulWidget {
  const AddActorScreen({Key? key}) : super(key: key);

  @override
  State<AddActorScreen> createState() => _AddActorScreenState();
}

class _AddActorScreenState extends State<AddActorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodanie aktora'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
