import 'package:bazy_flutter/models/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  final Person person;
  const PersonWidget({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${person.name} ${person.surname}'),
                Text('Stanowisko: ${person.role}'),
                Text('Data urodzenia: ${person.dateOfBirth}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
