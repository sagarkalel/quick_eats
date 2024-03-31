import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.avgRating});
  final double avgRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: avgRating,
      minRating: 0.5,
      allowHalfRating: true,
      ignoreGestures: true,
      itemSize: 35,
      itemBuilder: (context, _) =>
          const Icon(Icons.star, color: MyTheme.amberColor).padXRight(4),
      onRatingUpdate: (rating) {},
    );
  }
}
