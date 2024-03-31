import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/home_screen/widgets/rating_stars.dart';
import 'package:quick_eats/screens/home_screen/widgets/show_rating_dialog.dart';
import 'package:quick_eats/services/restaurant_services.dart';
import 'package:quick_eats/shimmer/shimmer_widget.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurantItem});
  final RestaurantModel restaurantItem;

  @override
  Widget build(BuildContext context) {
    bool isRated =
        RestaurantServices.isCurrentItemRated(context, restaurantItem);
    double avgRating = RestaurantServices.averageRating(restaurantItem);
    double givenRating =
        RestaurantServices.givenRating(context, restaurantItem);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// image url
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: restaurantItem.imageUrl,
            placeholder: (_, url) =>
                const ShimmerWidget.rectangular(height: 150),
            errorWidget: (context, url, error) =>
                const ShimmerWidget.rectangular(height: 150),
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),

          // child: FadeInImage(
          //   placeholder: MemoryImage(kTransparentImage),
          //   image: NetworkImage(restaurantItem.imageUrl),
          //   fit: BoxFit.cover,
          //   height: 150,
          //   width: double.infinity,
          // ),
        ),
        kYGap(5),
        Text(restaurantItem.name, style: MyTheme.bodyText().bold()),
        Text(restaurantItem.description, style: MyTheme.extraSmallText()),
        Text(avgRating.toStringAsFixed(1), style: MyTheme.titleText()),
        Text("Based on ${restaurantItem.ratings.length} reviews",
            style: MyTheme.smallText().textColor(MyTheme.greyColor)),

        /// rating stars and give rating button
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingStars(avgRating: givenRating),
              Consumer<AppProvider>(builder: (context, appProvider, child) {
                return TextButton(
                  onPressed: () async {
                    appProvider.newRating = givenRating;
                    await showRatingDialog(
                      context,
                      initialRating: givenRating,
                      appProvider: appProvider,
                      restaurantItem: restaurantItem,
                    );
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: MyTheme.hyperLinkColor),
                  child: Text(isRated ? "Change Rating" : "Rate Now",
                      style: MyTheme.hyperLink()),
                );
              })
            ]),
        const Divider().padYY(10),
        kYGap(10),
      ],
    );
  }
}
