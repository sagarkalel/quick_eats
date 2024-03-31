import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    background: const Color.fromARGB(255, 248, 244, 255),
  );
  static final theme = ThemeData(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: _colorScheme.background,
    colorScheme: _colorScheme,
    appBarTheme: const AppBarTheme()
        .copyWith(backgroundColor: const Color.fromARGB(255, 248, 244, 255)),
  );

  static final placeHolderColor = Colors.grey[400];
  static final inactiveColor = Colors.grey[500];
  static final whiteColor = _colorScheme.secondaryContainer;
  static final greyColor = Colors.grey.shade700;
  static const logoColor = Color.fromARGB(255, 149, 85, 189);
  static const hyperLinkColor = Colors.blue;
  static const amberColor = Colors.amber;
  static TextStyle extraSmallText() => GoogleFonts.merienda(fontSize: 10);
  static TextStyle smallText() => GoogleFonts.merienda(fontSize: 12);
  static TextStyle bodyText() => GoogleFonts.merienda(fontSize: 14);
  static TextStyle normalText() =>
      GoogleFonts.merienda(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle titleText() =>
      GoogleFonts.merienda(fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle hyperLink() => GoogleFonts.merienda(
        fontSize: 14,
        decoration: TextDecoration.underline,
        color: hyperLinkColor,
      );
}
