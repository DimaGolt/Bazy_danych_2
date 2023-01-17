import 'package:bazy_flutter/models/person.dart';
import 'package:flutter/material.dart';

class PersonScreen extends StatefulWidget {
  final Person person;
  const PersonScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  Person get person => widget.person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.name} ${person.surname}'),
      ),
    );
  }
}
