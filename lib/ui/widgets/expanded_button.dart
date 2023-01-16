import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final Function? onTap;
  final String? text;

  const ExpandedButton({Key? key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          width: double.infinity,
          child: Center(
            heightFactor: 3,
            child: Text(text ?? ''),
          ),
        ),
      ),
    );
  }
}
