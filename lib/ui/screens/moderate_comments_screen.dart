import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/comment_dismissible_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/comment.dart';
import '../widgets/expanded_button.dart';

class ModerateCommentsScreen extends StatefulWidget {
  const ModerateCommentsScreen({Key? key}) : super(key: key);

  @override
  State<ModerateCommentsScreen> createState() => _ModerateCommentsScreenState();
}

class _ModerateCommentsScreenState extends State<ModerateCommentsScreen> {
  late Future<List<Comment>> _futureComments;

  @override
  void initState() {
    _refreshComments();
    super.initState();
  }

  _refreshComments() {
    _futureComments = context.read<DatabaseService>().getAllComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderacja komentarzy'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _futureComments,
            builder: (_, snap) {
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) {
                      var comment = snap.data!.elementAt(index);
                      return CommentDismissibleTile(
                        comment: comment,
                        onDismiss: (dir) {
                          context
                              .read<DatabaseService>()
                              .deleteComment(comment.id)
                              .then((value) {
                            _refreshComments();
                            setState(() {
                              snap.data!.removeAt(index);
                            });
                          });
                        },
                      );
                    });
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
                        onTap: () => _refreshComments(),
                        text: 'Spróbuj ponownie',
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
