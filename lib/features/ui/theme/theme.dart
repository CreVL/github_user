import 'package:flutter/material.dart';

const primaryColor = Colors.cyan;

final themeData = ThemeData(
  primaryColor: primaryColor,
  dividerTheme: DividerThemeData(color: Colors.black38.withOpacity(0.4)),
  scaffoldBackgroundColor: const Color(0x061D21FF),
  colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor, brightness: Brightness.dark),
  useMaterial3: true,
  textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      )),
);

final darkTheme = ThemeData(
  textTheme: _textTheme,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0x061D21FF),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(color: Color(0xFFD6F1F6)),
  textTheme: _textTheme,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFE1EDF1),
  dividerTheme: DividerThemeData(color: Colors.black38.withOpacity(0.4)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryColor,
  ),
);

const _textTheme = TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ));
