import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_eats/screens/auth_screens/signin_screen.dart';
import 'package:quick_eats/screens/auth_screens/widgets/button.dart';
import 'package:quick_eats/services/auth_services.dart';
import 'package:quick_eats/utils/display_snackbar.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';
import 'dart:developer' as dev;

logoutUserDialog(context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shadowColor: MyTheme.inactiveColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Attention!", style: MyTheme.bodyText().bold())
          .padXX(20)
          .padYTop(10),
      children: [
        const Divider(),
        const Icon(FontAwesomeIcons.triangleExclamation,
            size: 50, color: MyTheme.amberColor),
        kYGap(10),
        Center(
          child:
              Text("Do you really want to logout?", style: MyTheme.smallText()),
        ),
        kYGap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              onPressed: () {
                Navigator.pop(context);
              },
              isLoading: false,
              text: 'Cancel',
            ),
            Button(
              onPressed: () async {
                try {
                  await AuthServices().clearUserDetails();
                  Hive.close();
                  if (context.mounted) {
                    kFadeNavigationRemoveUtil(context, const SignInScreen());
                    return;
                  }
                } catch (e) {
                  dev.log("error while logging out user: $e");
                  if (context.mounted) {
                    Navigator.pop(context);
                    displaySnackbar(
                        context, "Something went wrong, please try again!");
                  }
                }
              },
              isLoading: false,
              text: 'Logout',
            )
          ],
        ).padXX(20),
        kYGap(10),
        const Divider(),
      ],
    ),
  );
}
