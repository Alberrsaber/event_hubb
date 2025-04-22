import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color.fromRGBO(86, 105, 255, 1);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color customBlue = Color(0xFF4A90E2);
  static const Color customGreen = Color(0xFF50E3C2);
  static const Color customRed = Color(0xFFD0021B);
  static const Color customYellow = Color(0xFFF5A623);
  static const Color customLightBlue = Color(0xFFADD8E6);

  // ثيم الوضع الفاتح
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black87,
      textColor: Colors.black87,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(primaryColor),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor.withValues(alpha: (0.5 * 255).toDouble());
        }
        return Colors.grey.shade300; // اللون الافتراضي للتبديل
      }),
    ),
  );

  // ثيم الوضع المظلم
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(primaryColor),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor.withValues(alpha: (0.6 * 255).toDouble());
        }
        return Colors.grey.shade700; // اللون الافتراضي للتبديل
      }),
    ),
  );
}
