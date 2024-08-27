import 'package:flutter/material.dart';

/// Return theme mode
ThemeMode themeMode(String theme) => ThemeMode.values
    .firstWhere((ThemeMode e) => e.toString().split(".")[1] == theme);

class MaterialTheme {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8f4953),
      surfaceTint: Color(0xff8f4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd9dc),
      onPrimaryContainer: Color(0xff3b0713),
      secondary: Color(0xff8f4c33),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdbcf),
      onSecondaryContainer: Color(0xff380d00),
      tertiary: Color(0xff8b4f26),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdbc8),
      onTertiaryContainer: Color(0xff321300),
      error: Color(0xff904a48),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad8),
      onErrorContainer: Color(0xff3b080a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      onSurfaceVariant: Color(0xff524344),
      outline: Color(0xff847374),
      outlineVariant: Color(0xffd7c1c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2ba),
      background: Colors.white,
      onBackground: Colors.white,
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff440e19),
      surfaceTint: Color(0xff8f4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6d2f38),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff421201),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d321a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3c1800),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6a340c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff440f10),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e2f2e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2d2122),
      outline: Color(0xff4e3f40),
      outlineVariant: Color(0xff4e3f40),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffe6e7),
      background: Colors.black,
      onBackground: Colors.black,
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2ba),
      surfaceTint: Color(0xffffb2ba),
      onPrimary: Color(0xff561d27),
      primaryContainer: Color(0xff72333c),
      onPrimaryContainer: Color(0xffffd9dc),
      secondary: Color(0xffffb59a),
      onSecondary: Color(0xff55200a),
      secondaryContainer: Color(0xff71361e),
      onSecondaryContainer: Color(0xffffdbcf),
      tertiary: Color(0xffffb68a),
      onTertiary: Color(0xff522300),
      tertiaryContainer: Color(0xff6f3810),
      onTertiaryContainer: Color(0xffffdbc8),
      error: Color(0xffffb3af),
      onError: Color(0xff571d1d),
      errorContainer: Color(0xff733332),
      onErrorContainer: Color(0xffffdad8),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfff0dedf),
      onSurfaceVariant: Color(0xffd7c1c3),
      outline: Color(0xff9f8c8d),
      outlineVariant: Color(0xff524344),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff8f4953),
      background: Colors.black,
      onBackground: Colors.black,
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        fontFamily: "Urbanist",
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );
}
