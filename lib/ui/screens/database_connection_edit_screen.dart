import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DBConnectionEditScreen extends StatelessWidget {
  const DBConnectionEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ip = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Edycja połączenia z bazą danych'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              ip = value;
            },
            keyboardType: TextInputType.text,
          ),
          ExpandedButton(
            text: 'Zmień i zaloguj',
            onTap: () => context.read<DatabaseService>().connectToDB(ip: ip)
              ..then((d) =>
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Zmieniono bazę danych.',
                    textAlign: TextAlign.center,
                  )))),
          )
        ],
      ),
    );
  }
}
