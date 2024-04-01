import 'package:flutter/material.dart';

/// util constants
const kBaseUrl = "https://quick-eats.free.beeceptor.com";
// const kBaseUrl = "https://quick-eats-new.free.beeceptor.com";
// const kBaseUrl = "https://quick-eats-new-new.free.beeceptor.com";
kScreenX(context) => MediaQuery.of(context).size.width;
kScreenY(context) => MediaQuery.of(context).size.height;
kScreenSize(context) => MediaQuery.of(context).size;
kXGap(double w) => SizedBox(width: w);
kYGap(double h) => SizedBox(height: h);

/// hive box constants
const kRestaurantBox = 'restaurant_box';
final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

/// widget extensions
extension WidgetExtensions on Widget {
  Widget padAll(double all) =>
      Padding(padding: EdgeInsets.all(all), child: this);
  Widget padXX(double xx) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: xx), child: this);
  Widget padYY(double yy) =>
      Padding(padding: EdgeInsets.symmetric(vertical: yy), child: this);
  Widget padYBottom(double y) =>
      Padding(padding: EdgeInsets.only(bottom: y), child: this);
  Widget padYTop(double y) =>
      Padding(padding: EdgeInsets.only(top: y), child: this);
  Widget padXRight(double x) =>
      Padding(padding: EdgeInsets.only(right: x), child: this);
  Widget padXLeft(double x) =>
      Padding(padding: EdgeInsets.only(left: x), child: this);
}

/// textstyle extensions
extension TextStyles on TextStyle {
  TextStyle textColor(Color color) => copyWith(color: color);
  TextStyle textSize(double size) => copyWith(fontSize: size);
  TextStyle textWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle bold() => copyWith(fontWeight: FontWeight.w600);
}

/// navigations
kSlideNavigation(context, Widget child) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(animation),
        child: child,
      ),
    ),
  );
}

kFadeNavigationRemoveUtil(context, Widget child) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeTransition(opacity: animation, child: child)),
    (route) => false,
  );
}
