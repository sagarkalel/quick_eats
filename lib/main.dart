import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/modals/rating_model.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/auth_screens/signin_screen.dart';
import 'package:quick_eats/screens/home_screen/home_screen.dart';
import 'package:quick_eats/services/auth_services.dart';
import 'package:quick_eats/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final authServices = AuthServices();
  final isLoggedIn = await authServices.isLoggedIn();
  Hive.registerAdapter<RestaurantModel>(RestaurantModelAdapter());
  Hive.registerAdapter<RatingModel>(RatingModelAdapter());
  runApp(ChangeNotifierProvider(
    create: (context) => AppProvider(),
    child: MyApp(isLoggedIn: isLoggedIn),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Eats',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.theme,
      home: isLoggedIn ? const HomeScreen() : const SignInScreen(),
    );
  }
}
