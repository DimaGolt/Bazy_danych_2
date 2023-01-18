import 'package:bazy_flutter/models/comment.dart';
import 'package:bazy_flutter/ui/widgets/comment_tile.dart';
import 'package:flutter/material.dart';

class CommentDismissibleTile extends StatelessWidget {
  final Comment comment;
  final Function(DismissDirection) onDismiss;
  const CommentDismissibleTile(
      {Key? key, required this.comment, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      key: ValueKey<int>(comment.id),
      child: CommentTile(comment: comment),
      onDismissed: onDismiss,
    );
  }
}
