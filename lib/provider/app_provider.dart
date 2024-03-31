import 'package:flutter/foundation.dart';
import 'package:quick_eats/modals/user_model.dart';

class AppProvider extends ChangeNotifier {
  static final AppProvider _instance = AppProvider._internal();
  factory AppProvider() => _instance;
  AppProvider._internal();

  /// button loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// storing update rating value
  double _newRating = 0.0;
  double get newRating => _newRating;
  set newRating(double value) {
    _newRating = value;
    notifyListeners();
  }

  /// user details
  UserModel _userModel = const UserModel(email: 'none', password: 'none');
  UserModel get userModel => _userModel;
  set userModel(UserModel value) {
    _userModel = value;
    notifyListeners();
  }
}
