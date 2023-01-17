import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:bazy_flutter/ui/widgets/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../routing/app_router.dart';

class NewCommentWidget extends StatelessWidget {
  final Film film;
  final Function()? afterSubmit;
  const NewCommentWidget({Key? key, required this.film, this.afterSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: context.read<DatabaseService>().user != null
              ? _newComment(context, context.read<DatabaseService>().user!)
              : _accessDenied(context),
        ),
      ),
    );
  }

  _newComment(BuildContext context, User user) {
    String comment = '';
    bool professional = user.accessLevel == 1;

    return Container(
      height: 150,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text(professional
                  ? 'Wpisz swoją recenzję...'
                  : 'Wpisz swój komentarz...'),
            ),
            maxLength: 200,
            onChanged: (value) => comment = value,
          ),
          ExpandedButton(
            text: professional ? 'Wyślij recenzję' : 'Wyślij komentarz',
            active: true,
            onTap: () {
              if (comment.isNotEmpty) {
                professional
                    ? context
                        .read<DatabaseService>()
                        .sendOpinion(film.id, comment)
                    : context
                        .read<DatabaseService>()
                        .sendComment(film.id, comment);
                afterSubmit?.call();
              }
            },
          )
        ],
      ),
    );
  }

  _accessDenied(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Żeby dodać komentarz musisz być zalogowany'),
        ExpandedButton(
          text: 'Zaloguj',
          onTap: () => context.router.push(const LoginScreenRoute()),
        ),
      ],
    );
  }
}
