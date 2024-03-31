import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/auth_screens/signup_screen.dart';
import 'package:quick_eats/screens/auth_screens/widgets/button.dart';
import 'package:quick_eats/screens/auth_screens/widgets/input_box.dart';
import 'package:quick_eats/services/auth_services.dart';
import 'package:quick_eats/utils/asset_constants.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: kScreenY(context),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// logo image
                  Image.asset(
                    AssetConstant.logo,
                    height: kScreenX(context) * .3,
                    color: MyTheme.logoColor,
                  ),
                  kYGap(10),
                  Text("Quick Eats", style: MyTheme.titleText()),
                  Text("Discover new dining experience nearby!",
                      style: MyTheme.bodyText()),
                  kYGap(20),

                  /// email input field
                  InputBox(
                    controller: emailController,
                    validator: (value) {
                      final RegExp regex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (value == null || !regex.hasMatch(value)) {
                        return "Please enter valid email!";
                      }
                      return null;
                    },
                  ),
                  kYGap(10),

                  /// password entering input field
                  InputBox(
                    controller: passwordController,
                    isForPassword: isPassword,
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return "Password should be more that 5 digits.";
                      }
                      return null;
                    },
                    suffix: InkWell(
                        onTap: () => setState(() {
                              isPassword = !isPassword;
                            }),
                        child: Icon(
                          isPassword
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: MyTheme.inactiveColor,
                          size: 16,
                        )),
                  ),
                  kYGap(10),

                  /// not given any action here below, but added tooltip to show
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: "Not given any action here",
                        child: Text("Forgot your password?",
                            style: MyTheme.bodyText()),
                      )
                    ],
                  ),
                  kYGap(20),

                  /// signup button
                  Consumer<AppProvider>(builder: (context, appProvider, child) {
                    return Button(
                      onPressed: () async {
                        await signInSubmit(appProvider);
                      },
                      isLoading: appProvider.isLoading,
                      text: "Sign In",
                    );
                  }),

                  /// don't have an account >>> text
                  kYGap(20),
                  Text.rich(TextSpan(style: MyTheme.bodyText(), children: [
                    const TextSpan(text: "Don't have an account yet? "),
                    TextSpan(
                        text: "Sign Up",
                        style: MyTheme.hyperLink(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).unfocus();
                            kSlideNavigation(context, const SignUpScreen());
                          }),
                  ])),
                ],
              ).padAll(20),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInSubmit(AppProvider appProvider) async {
    var isValidate = _formKey.currentState?.validate();
    if (isValidate == true) {
      FocusScope.of(context).unfocus();
      appProvider.isLoading = true;
      final result = await AuthServices().signIn(
        context,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      appProvider.isLoading = false;
      if (result == true) {
        emailController.clear();
        passwordController.clear();
      }
    }
  }
}
