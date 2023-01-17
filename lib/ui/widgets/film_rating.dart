import 'package:flutter/material.dart';

import 'expanded_button.dart';

class FilmRating extends StatefulWidget {
  const FilmRating({Key? key}) : super(key: key);

  @override
  State<FilmRating> createState() => _FilmRatingState();
}

class _FilmRatingState extends State<FilmRating> {
  late final ValueNotifier<int> rating;
  final ValueNotifier<bool> beenRated = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    rating = ValueNotifier(0);
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStarsRow(context),
          SizedBox(height: 8),
          _buildBottom(context),
        ],
      ),
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
