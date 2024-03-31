import 'package:flutter/material.dart';
import 'package:quick_eats/utils/theme.dart';
import 'package:quick_eats/utils/utils.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isRetry = false,
  });
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool isRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: kScreenX(context) * .30,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            foregroundColor: MyTheme.whiteColor,
            backgroundColor: MyTheme.greyColor,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 3))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(text),
                    if (isRetry) kXGap(8),
                    if (isRetry) const Icon(Icons.repeat),
                  ],
                )),
    );
  }
}
