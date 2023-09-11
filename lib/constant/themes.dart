import 'package:flutter/material.dart';

class Themes {
  static MaterialColor primaryColor() {
    // Return a primary color as light blue shade
    return const MaterialColor(
      0xFF03A9F4, // Change the color code to the light blue you want
      <int, Color>{
        50: Color(0xFFE1F5FE),
        100: Color(0xFFB3E0FC),
        200: Color(0xFF81C8FA),
        300: Color(0xFF4FA3F7),
        400: Color(0xFF1FA0E8),
        500: Color(0xFF03A9F4),
        600: Color(0xFF039BE5),
        700: Color(0xFF0288D1),
        800: Color(0xFF0277BD),
        900: Color(0xFF01579B),
      },
    );
  }

  static String fontFamily() {
    return 'quickSand';
  }
}
