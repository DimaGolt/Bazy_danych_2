import 'package:bazy_flutter/models/person.dart';
import 'package:flutter/material.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  final Function()? onTap;
  const PersonListTile({Key? key, required this.person, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 5,
        child: InkWell(
          onTap: () => onTap?.call(),
          child: ListTile(
            title: Center(
              child: Text('${person.name} ${person.surname}'),
            ),
            subtitle: Column(
              children: [
                Text('Rola: ${person.role}'),
                Text('Data urodzenia: ${person.dateOfBirth}'),
                Text('Kraj urodzenia: ${person.homeCountry}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
