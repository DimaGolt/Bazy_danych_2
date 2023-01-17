import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final bool active;

  const ExpandedButton({Key? key, this.onTap, this.text, this.active = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        splashColor: active ? null : Colors.transparent,
        highlightColor: active ? null : Colors.transparent,
        onTap: () {
          if (active) onTap?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2.0, 2.0),
              )
            ],
            color: active ? Colors.greenAccent : Colors.green[100],
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
