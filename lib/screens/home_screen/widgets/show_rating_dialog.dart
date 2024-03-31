import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/auth_screens/widgets/button.dart';
import 'package:quick_eats/services/restaurant_services.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

showRatingDialog(
  context, {
  required double initialRating,
  required AppProvider appProvider,
  required RestaurantModel restaurantItem,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shadowColor: MyTheme.inactiveColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Rate Now", style: MyTheme.bodyText().bold()).padXX(20),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      children: [
        const Divider(),
        Center(
          child: Text("Share your review to help others",
              style: MyTheme.smallText()),
        ),
        kYGap(10),
        Center(
          child: RatingBar.builder(
            minRating: 0.5,
            initialRating: initialRating,
            allowHalfRating: false,
            itemSize: 35,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: MyTheme.amberColor).padXRight(4),
            onRatingUpdate: (rating) {
              appProvider.newRating = rating;
            },
          ),
        ),
        kYGap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<AppProvider>(builder: (context, appProvider, child) {
              return Button(
                onPressed: () async {
                  /// logic of saving rating
                  appProvider.isLoading = true;
                  await RestaurantServices.updateRating(context, restaurantItem,
                      appProvider.newRating, appProvider.userModel.email);
                  appProvider.isLoading = false;
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                isLoading: appProvider.isLoading,
                text: 'Submit',
              ).padXRight(20);
            })
          ],
        ),
        const Divider(),
      ],
    ),
  );
}
