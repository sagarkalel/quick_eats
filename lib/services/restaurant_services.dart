import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/modals/rating_model.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/services/api_services.dart';
import 'package:quick_eats/utils/display_snackbar.dart';
import 'package:quick_eats/utils/utils.dart';

class RestaurantServices {
  static final RestaurantServices _instance = RestaurantServices._internal();
  factory RestaurantServices() => _instance;
  RestaurantServices._internal();

  /// get restaurant list
  static Future<List<RestaurantModel>> _getRestaurantList(
      BuildContext context) async {
    try {
      final response = await ApiServices.getRestaurantsApi();
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => RestaurantModel.fromMap(e))
            .toList();
      } else {
        if (context.mounted) {
          displaySnackbar(context, "Somethig went wrong, please try again!");
        }
        dev.log(
            "failing to get restaurants, status code is: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      if (context.mounted) {
        displaySnackbar(context, "Somethig went wrong, please try again!");
      }
      dev.log("error while getting restaurants: $e");
      return [];
    }
  }

  /// store recived restaurant list in hive
  static Future<void> getRestaurantsAndStoreLocally(
      BuildContext context) async {
    final dataList = await _getRestaurantList(context);
    Box<RestaurantModel> box = Hive.box(kRestaurantBox);
    await box.clear();
    box.addAll(dataList);
    dev.log("this is the length of restaurant box: ${box.values.length}");
  }

  /// checking current restaurant is rated or not by current user
  static bool isCurrentItemRated(
      BuildContext context, RestaurantModel restaurantItem) {
    String email = context.read<AppProvider>().userModel.email;
    final ratingList = restaurantItem.ratings
        .where((element) => element.uid == email)
        .toList();
    if (ratingList.isEmpty) {
      return false;
    }
    return true;
  }

  /// get average rating
  static double averageRating(RestaurantModel restaurantItem) {
    final ratingList = restaurantItem.ratings;
    if (ratingList.isEmpty) {
      return 0.0;
    }
    double totalRating = 0.0;
    for (var ratingItem in ratingList) {
      totalRating += ratingItem.rating;
    }
    return totalRating / ratingList.length;
  }

  /// get given rating by current user to current restaurant
  static double givenRating(
      BuildContext context, RestaurantModel restaurantItem) {
    String email = context.read<AppProvider>().userModel.email;
    final ratingList = restaurantItem.ratings
        .where((element) => element.uid == email)
        .toList();
    if (ratingList.isEmpty) {
      return 0.0;
    }
    return ratingList.last.rating;
  }

  /// update current user's rating to restaurant
  static Future<void> updateRating(BuildContext context,
      RestaurantModel restaurantItem, double newRating, String email) async {
    try {
      final itemToUpdateList = restaurantItem.ratings
          .where((element) => element.uid == email)
          .toList();

      if (itemToUpdateList.isNotEmpty) {
        /// update rating
        restaurantItem.ratings
            .where((element) => element.uid == email)
            .toList()
            .first
            .rating = newRating;
      } else {
        /// add rating item
        restaurantItem.ratings.add(RatingModel(rating: newRating, uid: email));
      }
      final response =
          await ApiServices.updateRatingApi(restaurantItem.toMap());
      if (response.statusCode == 200) {
        await _updateHiveAfterGivingRating(restaurantItem);
        if (context.mounted) {
          displaySnackbar(context,
              "Thank you for your feedback! Your rating has been updated");
        }
      } else {
        if (context.mounted) {
          displaySnackbar(context, "Something went wrong, please try again!");
        }
        dev.log(
            "failing to patch rating value, status code is: ${response.statusCode}");
      }
    } catch (e) {
      if (context.mounted) {
        displaySnackbar(context, "Something went wrong, please try again!");
      }
    }
  }

  /// update hive box after updating rating
  static Future<void> _updateHiveAfterGivingRating(
      RestaurantModel newRestaurantItem) async {
    var restaurantsBox = Hive.box<RestaurantModel>(kRestaurantBox);
    var restaurants = restaurantsBox.values.toList();
    var index =
        restaurants.indexWhere((element) => element.id == newRestaurantItem.id);
    await restaurantsBox.putAt(index, newRestaurantItem);
    dev.log(
        "this is updated value here =>>>>>${restaurantsBox.values.firstWhere((element) => element.id == newRestaurantItem.id).ratings.map((e) => e.toMap().toString())}");
  }
}
