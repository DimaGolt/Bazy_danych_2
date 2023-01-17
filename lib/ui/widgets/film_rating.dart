import 'package:auto_route/auto_route.dart';
import 'package:bazy_flutter/models/film.dart';
import 'package:bazy_flutter/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routing/app_router.dart';
import 'expanded_button.dart';

class FilmRating extends StatefulWidget {
  final int? previousValue;
  final Film film;
  const FilmRating({Key? key, this.previousValue, required this.film})
      : super(key: key);

  @override
  State<FilmRating> createState() => _FilmRatingState();
}

class _FilmRatingState extends State<FilmRating> {
  late final ValueNotifier<int> rating;
  late final ValueNotifier<bool> beenRated;

  @override
  void initState() {
    super.initState();
    rating = ValueNotifier(widget.previousValue ?? 0);
    beenRated = ValueNotifier(widget.previousValue == null ? false : true);
  }

  @override
  void dispose() {
    rating.dispose();
    beenRated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
      child: context.read<DatabaseService>().user != null
          ? Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStarsRow(context),
                  SizedBox(height: 8),
                  _buildBottom(context),
                ],
              ),
            )
          : _accessDenied(context),
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

  _buildStarsRow(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rating,
        builder: (context, _, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                List.generate(5, (index) => _buildRatingStar(context, index)),
          );
        });
  }

  _buildBottom(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: beenRated,
      builder: (context, rated, __) {
        return AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(child: child, opacity: animation);
          },
          duration: const Duration(milliseconds: 500),
          child: rated
              ? ExpandedButton(
                  active: false,
                  text: 'Dziękuję',
                )
              : ExpandedButton(
                  onTap: () {
                    context
                        .read<DatabaseService>()
                        .sendRating(widget.film.id, rating.value);
                    beenRated.value = true;
                  },
                  text: 'Oceń',
                ),
        );
      },
    );
  }

  _buildRatingStar(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (rating.value == index + 1) {
          rating.value--;
        } else {
          rating.value = index + 1;
        }
      },
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(child: child, opacity: animation);
        },
        duration: const Duration(milliseconds: 200),
        child: index + 1 <= rating.value
            ? Icon(
                Icons.star,
                color: Colors.greenAccent,
                key: ValueKey<String>('Active$index'),
              )
            : Icon(
                Icons.star_border,
                color: Colors.greenAccent,
                key: ValueKey<String>('Deactivated$index'),
              ),
      ),
    );
  }
}
