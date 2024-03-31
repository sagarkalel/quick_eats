import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/screens/auth_screens/widgets/button.dart';
import 'package:quick_eats/screens/home_screen/widgets/restaurant_item.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key, required this.retry});
  final Future<void> Function() retry;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<RestaurantModel>(kRestaurantBox).listenable(),
      builder: (context, value, child) {
        var restaurants = value.values.toList();
        if (restaurants.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Somethig went wrong, please try again!",
                  style: MyTheme.bodyText(),
                ),
                kYGap(20),
                Button(
                  onPressed: () async => await retry(),
                  text: "Retry",
                  isRetry: true,
                ),
              ],
            ),
          );
        }
        return AnimationLimiter(
          child: ListView.builder(
            itemCount: restaurants.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: FlipAnimation(
                  child: RestaurantItem(restaurantItem: restaurants[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
