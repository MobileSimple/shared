import 'package:flutter/material.dart';

class FontSizes {
  static const double verySmall = 10;
  static const double small = 12;
  static const double medium = 14;
  static const double large = 16;
  static const double veryLarge = 18;
}

class Edges {
  static const double ultraSmall = 2;
  static const double verySmall = 5;
  static const double small = 10;
  static const double medium = 15;
  static const double large = 20;
  static const double veryLarge = 25;
  static const double ultraLarge = 30;
}

mixin AppColors {
  static const Color primary = Color(0xff27253f);
  static const Color accent = Color(0xff2dafe6);

  static const Color redDark = Color(0xffa9120a);

  ///Kolor wykorzystywany do elemtnów listy
  static const Color lightGrey = Color(0xffFAFAFD);

  ///Kolor wykorzystywany do oddzielenia appBar od zawartosci ekranu
  static const Color blueGrey = Color(0xff8BABC4);

  static const Color redLight = Color(0xffDB001C);

  static const Color green = Color(0xff3E859B);
  static const Color grey = Color(0xffCED9E5);

  ///Kolor wykorzystywany do drawer
  static const Color violet = Color(0xff27253F);

  static MaterialColor primarySwatch = createMaterialColor(primary);
  static MaterialColor accentSwatch = createMaterialColor(accent);

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
