import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.controller,
    this.validator,
    this.suffix,
    this.isForPassword = false,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final bool isForPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isForPassword,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffix: suffix,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
    );
  }
}
