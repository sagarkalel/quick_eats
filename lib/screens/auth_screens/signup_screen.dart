import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_eats/provider/app_provider.dart';
import 'package:quick_eats/screens/auth_screens/widgets/button.dart';
import 'package:quick_eats/screens/auth_screens/widgets/input_box.dart';
import 'package:quick_eats/services/auth_services.dart';
import 'package:quick_eats/utils/asset_constants.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: kScreenY(context) * .8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

                  /// confirm password input field
                  InputBox(
                    controller: confirmPasswordController,
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
                  kYGap(20),

                  /// signup button
                  Consumer<AppProvider>(builder: (context, appProvider, child) {
                    return Button(
                      onPressed: () async {
                        await signUpSubmit(appProvider);
                      },
                      isLoading: appProvider.isLoading,
                      text: "Sign Up",
                    );
                  }),

                  /// already have an account >>> text
                  kYGap(20),
                  Text.rich(TextSpan(style: MyTheme.bodyText(), children: [
                    const TextSpan(text: "Already have an account? "),
                    TextSpan(
                        text: "Sign In",
                        style: MyTheme.hyperLink(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
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

  Future<void> signUpSubmit(AppProvider appProvider) async {
    var isValidate = _formKey.currentState?.validate();
    if (isValidate == true) {
      FocusScope.of(context).unfocus();
      appProvider.isLoading = true;
      final result = await AuthServices().signUp(
        context,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      appProvider.isLoading = false;
      if (result == true) {
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      }
    }
  }
}
