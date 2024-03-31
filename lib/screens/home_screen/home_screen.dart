import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/modals/restaurant_model.dart';
import 'package:quick_eats/modals/user_model.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/home_screen/widgets/logout_user_dialog.dart';
import 'package:quick_eats/screens/home_screen/widgets/restaurant_list.dart';
import 'package:quick_eats/services/auth_services.dart';
import 'package:quick_eats/services/restaurant_services.dart';
import 'package:quick_eats/shimmer/restaurant_list_shimmer.dart';
import 'package:quick_eats/utils/asset_constants.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!Hive.isBoxOpen(kRestaurantBox)) {
        await Hive.openBox<RestaurantModel>(kRestaurantBox);
      }

      /// saving user details locally by getting from JSON file
      UserModel? userDetails = await AuthServices().getUserDetails();
      if (userDetails != null && mounted) {
        context.read<AppProvider>().userModel = userDetails;
      }
      await fetchRestaurantData();
    });
  }

  fetchRestaurantData() async {
    setState(() {
      isLoading = true;
    });
    await RestaurantServices.getRestaurantsAndStoreLocally(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AssetConstant.logo,
                  width: 85,
                  color: MyTheme.logoColor,
                ),
                IconButton(
                    onPressed: () => logoutUserDialog(context),
                    icon: const Icon(Icons.logout))
              ],
            ).padXX(15),
            kYGap(10),
            Text("Restaurants", style: MyTheme.normalText()).padXX(20),
            Expanded(
              child: Builder(builder: (context) {
                if (isLoading) {
                  return const RestaurantShimmerList();
                }
                return RestaurantList(retry: () async => fetchRestaurantData());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
