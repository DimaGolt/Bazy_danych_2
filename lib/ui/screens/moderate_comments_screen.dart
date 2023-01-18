import 'package:flutter/material.dart';

class ModerateCommentsScreen extends StatefulWidget {
  const ModerateCommentsScreen({Key? key}) : super(key: key);

  @override
  State<ModerateCommentsScreen> createState() => _ModerateCommentsScreenState();
}

class _ModerateCommentsScreenState extends State<ModerateCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderacja komentarzy'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
