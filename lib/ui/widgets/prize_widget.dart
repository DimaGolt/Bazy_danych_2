import 'package:bazy_flutter/models/prize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrizeWidget extends StatelessWidget {
  final Prize prize;
  const PrizeWidget({Key? key, required this.prize}) : super(key: key);

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
                Text(prize.name),
                Text('Data przyznania: ${prize.dateOfSuccess}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
