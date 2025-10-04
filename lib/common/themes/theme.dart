import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff07AEAF),
      onPrimary: Color(0xffF8FFFF),
      secondary: Color(0xff196B81),
      onSecondary: Color(0xffF8FFFF),
      tertiary: Color(0xffFBC02D),
      onTertiary: Color(0xFF083132),
      error: Color(0xffeF3F26),
      onError: Color(0xffF8F8FF),
      errorContainer: Color(0xffFDECE9),
      onErrorContainer: Color(0xff5A2727),
      surface: Color(0xffF8FFFF),
      surfaceContainer: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xFFEDFFFF),
      onSurface: Color(0xff083132),
      onSurfaceVariant: Color(0xff083132),
      outline: Color(0xffC4D0D0),
      outlineVariant: Color(0xffECECEC),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2E3036),
      inversePrimary: Color(0xff0D9697),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff07AEAF),
      onPrimary: Color(0xffF8FFFF),
      secondary: Color(0xff196B81),
      onSecondary: Color(0xffF8FFFF),
      tertiary: Color(0xffFBC02D),
      onTertiary: Color(0xFF083132),
      error: Color(0xffeF3F26),
      onError: Color(0xff1C1C1C),
      errorContainer: Color(0xff5A2727),
      onErrorContainer: Color(0xffFDECE9),
      surface: Color(0xff1E1E1E),
      surfaceContainer: Color(0xff2C2C2C),
      onSurface: Color(0xffF8F8FF),
      onSurfaceVariant: Color(0xffD0D0D0),
      outline: Color(0xff444444),
      outlineVariant: Color(0xff2C2C2C),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffF8F8FF),
      inversePrimary: Color(0xff0D9697),
    );
  }

  ThemeData dark() => theme(darkScheme());

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),

    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
