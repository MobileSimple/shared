import 'package:flutter/material.dart';

class FontSizes {
  static const double kVerySmall = 10;
  static const double kSmall = 12;
  static const double kMedium = 14;
  static const double kLarge = 16;
  static const double kVeryLarge = 18;
}

class Edges {
  static const double kVerySmall = 5;
  static const double kSmall = 10;
  static const double kMedium = 15;
  static const double kLarge = 20;
  static const double kVeryLarge = 25;
}

class Colors {
  static const Color kPrimaryColor = Color(0xff27253f);
  static const Color kAccentColor = Color(0xff2dafe6);

  MaterialColor kPrimarySwatch = createMaterialColor(kPrimaryColor);

  static MaterialColor createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (int i = 0; i < strengths.length; i++) {
      final double ds = 0.5 - strengths[i];
      swatch[(strengths[i] * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
