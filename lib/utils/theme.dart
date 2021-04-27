import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared/utils/constants.dart';

class AppTheme {
  static ThemeData init() {
    // ratio for fontSize
    final double size = min(window.physicalSize.width, window.physicalSize.height); //orientation
    final double ratio = size > 0 ? size / 720.0 : 1.0;
    // colors
    final ColorScheme colorSheme = ColorScheme.fromSwatch(
      primarySwatch: AppColors.primarySwatch,
      accentColor: AppColors.accent,
      errorColor: AppColors.red,
    );
    // theme
    // TODO calculate ratio for tablet/web
    const IconThemeData iconTheme = IconThemeData(color: Colors.black);
    final TextTheme textTheme = const TextTheme(
      headline1: TextStyle(fontSize: 32, color: Colors.red),
      headline2: TextStyle(fontSize: 26, color: Colors.green),
      headline3: TextStyle(fontSize: 22, color: Colors.yellow),
      headline4: TextStyle(fontSize: 18, color: Colors.purple),
      headline5: TextStyle(fontSize: 14, color: AppColors.accent),
      headline6: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ), // AppBar()
      subtitle1: TextStyle(fontSize: 14, color: Colors.grey),
      subtitle2: TextStyle(fontSize: 13, color: Colors.grey),
      bodyText1: TextStyle(fontSize: 13, color: Colors.grey),
      bodyText2: TextStyle(fontSize: 13, color: Colors.black), // Text()
      button: TextStyle(
        fontSize: 14,
        color: AppColors.accent,
        fontWeight: FontWeight.w600,
      ),
      caption: TextStyle(fontSize: 12, color: Colors.black),
      overline: TextStyle(fontSize: 12, color: Colors.black),
    ).apply(fontSizeFactor: ratio);
    final ThemeData theme = ThemeData(
      colorScheme: colorSheme,
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: textTheme,
      primaryIconTheme: iconTheme,
      brightness: Brightness.light,
      textTheme: textTheme,
      // colors
      accentColor: AppColors.accent,
      primaryColor: AppColors.primary,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey.shade200,
      highlightColor: Colors.transparent,
      // widgets
      iconTheme: iconTheme,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.accent,
        splashColor: Colors.white.withOpacity(0.33),
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.accent,
          padding: const EdgeInsets.symmetric(
            horizontal: Edges.medium,
            vertical: Edges.verySmall + Edges.ultraSmall,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Edges.large),
            ),
          ),
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Edges.verySmall),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.accent,
        iconTheme: const IconThemeData(color: Colors.white),
        // titleTextStyle: TextStyle(fontSize: FontSizes.large * ratio, color: Colors.black),
        titleTextStyle: textTheme.headline6,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        contentTextStyle: textTheme.bodyText2,
        titleTextStyle: textTheme.subtitle1,
      ),
    );
    return theme;
  }
}
