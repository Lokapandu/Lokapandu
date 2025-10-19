import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );

  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
  );
  return textTheme.copyWith(
    headlineSmall: textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 24,
      height: 32 / 24, // Hasilnya sekitar 1.33
      letterSpacing: 0,
    ),
    titleLarge: textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 22,
      height: 28 / 22, // Hasilnya sekitar 1.36
      letterSpacing: 0,
    ),
    titleMedium: textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 24 / 16, // Hasilnya sekitar 1.43
      letterSpacing: 0.15,
    ),
    titleSmall: textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14, // Hasilnya sekitar 1.43
      letterSpacing: 0.1,
    ),
    labelLarge: textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14, // Hasilnya sekitar 1.43
      letterSpacing: 0.1,
    ),
    labelMedium: textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
    ),
    labelSmall: textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
    ),
    bodyLarge: textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
    ),
    bodyMedium: textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14, // Hasilnya sekitar 1.43
      letterSpacing: 0.25,
    ),
    bodySmall: textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
    ),
  );
}
