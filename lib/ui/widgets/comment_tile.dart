import 'package:flutter/material.dart';

import '../../models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final bool professional;
  const CommentTile(
      {Key? key, required this.comment, this.professional = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: professional
                ? const Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                : const Icon(
                    Icons.account_circle,
                    color: Colors.greenAccent,
                  ),
          ),
          Text(comment.username),
        ],
      ),
      title: Text(comment.description),
    );
  }
}
