import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_eats/modals/user_model.dart';
import 'package:quick_eats/screens/home_screen/home_screen.dart';
import 'package:quick_eats/services/api_services.dart';
import 'package:quick_eats/utils/display_snackbar.dart';
import 'package:quick_eats/utils/utils.dart';

class AuthServices {
  static final AuthServices _instance = AuthServices._internal();
  factory AuthServices() => _instance;
  AuthServices._internal();

  /// get local file
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/user_details.json");
  }

  /// save user details to JSON file
  Future<void> saveUserDetails(UserModel userModel) async {
    final file = await _getLocalFile();
    file.writeAsStringSync(jsonEncode(userModel.toMap()));
  }

  /// retrive user details from JSON file
  Future<UserModel?> getUserDetails() async {
    try {
      final file = await _getLocalFile();
      final data = await file.readAsString();
      return UserModel.fromMap(jsonDecode(data));
    } catch (e) {
      dev.log("error while getting user details from JSON file: $e");
      return null;
    }
  }

  /// clear user details from JSON file when user logs out or clears cache/data
  Future<void> clearUserDetails() async {
    final file = await _getLocalFile();
    file.deleteSync();
    return;
  }

  /// check user is logged in or not from JSON file
  Future<bool> isLoggedIn() async {
    final userDetails = await getUserDetails();
    return userDetails != null;
  }

  /// signup user
  Future<bool?> signUp(
    BuildContext context, {
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      displaySnackbar(
          context, "Confirm password is not matching, please check again!");
      return null;
    }
    UserModel userModel = UserModel(email: email, password: password);
    Map<String, dynamic> data = userModel.toMap();
    try {
      final response = await ApiServices.signUpUserApi(data);
      if (response.statusCode == 200) {
        await saveUserDetails(userModel);
        if (context.mounted) {
          kFadeNavigationRemoveUtil(context, const HomeScreen());
          return true;
        }
        dev.log("context is not mounted here.");
      } else {
        if (context.mounted) {
          displaySnackbar(context, "Somethig went wrong, please try again!");
          dev.log("failing to sign up, status code is: ${response.statusCode}");
          return null;
        }
        dev.log("context is not mounted here.");
      }
    } catch (e) {
      dev.log("error while getting signed up: $e");
      return null;
    }
    return null;
  }

  /// signin user
  Future<bool?> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    UserModel userModel = UserModel(email: email, password: password);
    try {
      final response = await ApiServices.signInUserApi();
      dev.log(
          "this is get response data ${response.data}, and status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<UserModel> usersList =
            (response.data as List).map((e) => UserModel.fromMap(e)).toList();
        final existance = await _checkUserExistance(usersList, email);

        /// if user acount is not exist
        if (!existance) {
          if (context.mounted) {
            displaySnackbar(
                context, "Your acount is not exist, please sign up!");
          }
          return null;
        }

        /// validating password
        final validatePswrd =
            await _validatePasswordIfUserExist(usersList, email, password);
        if (!validatePswrd) {
          if (context.mounted) {
            displaySnackbar(context, "Please enter correct password!");
          }
          return null;
        }

        /// if everything is okay, then saving user details in JSON file and navigating to home screen
        await saveUserDetails(userModel);
        if (context.mounted) {
          kFadeNavigationRemoveUtil(context, const HomeScreen());
          return true;
        }
        dev.log("context is not mounted here.");
      } else {
        if (context.mounted) {
          displaySnackbar(context, "Somethig went wrong, please try again!");
          dev.log("failing to sign up, status code is: ${response.statusCode}");
          return null;
        }
        dev.log("context is not mounted here.");
      }
    } catch (e) {
      dev.log("error while getting signed in: $e");
      return null;
    }
    return null;
  }

  /// check user existance
  Future<bool> _checkUserExistance(
      List<UserModel> usersList, String email) async {
    var list = usersList.where((user) => user.email == email).toList();
    if (list.isEmpty) {
      return false;
    }
    return true;
  }

  /// validate password if user exist
  Future<bool> _validatePasswordIfUserExist(
    List<UserModel> usersList,
    String email,
    String password,
  ) async {
    var list = usersList.where((user) => user.email == email).toList();
    if (list.isEmpty) {
      /// means user is not exist here
      return false;
    }
    if (list.first.password == password) {
      /// means password is matching to the existing user's password
      return true;
    }
    return false;
  }
}
