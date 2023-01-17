import 'package:bazy_flutter/models/person.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/prize_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/prize.dart';
import '../widgets/expanded_button.dart';

class PersonScreen extends StatefulWidget {
  final Person person;
  const PersonScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  late Future<List<Prize>> _futurePrizes;
  final prizes = [];

  Person get person => widget.person;

  @override
  void initState() {
    _updatePrizes();
    super.initState();
  }

  _updatePrizes() {
    _futurePrizes = context.read<DatabaseService>().getPersonPrizes(person.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.name} ${person.surname}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ..._description(),
            ..._prizes(),
          ],
        ),
      ),
    );
  }

  _description() {
    return [
      Text('Stanowisko: ${person.role}'),
      Text('Data urodzenia: ${person.dateOfBirth}'),
      if (person.dateOfDeath != null)
        Text('Data śmierci: ${person.dateOfDeath}'),
      Text('Kraj urodzenia: ${person.homeCountry}')
    ];
  }

  _prizes() {
    return [
      if (prizes.isNotEmpty) const Center(child: Text('Nagrody')),
      FutureBuilder(
        future: _futurePrizes,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data!.isNotEmpty) {
              prizes.addAll(snap.data!);
              return SizedBox(
                height: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      return PrizeWidget(prize: snap.data!.elementAt(index));
                    }),
              );
            } else {
              return const SizedBox();
            }
          } else if (snap.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const Text('Coś poszło nie tak. Spróbuj ponownie'),
                  ExpandedButton(
                    onTap: _updatePrizes,
                    text: 'Spróbuj ponownie',
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ];
  }
}
