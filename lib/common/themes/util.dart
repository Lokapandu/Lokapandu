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
      height: 24/32,
      letterSpacing: 0,
    ),
    titleLarge: textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 22,
      height: 22/28,
      letterSpacing: 0,
    ),
    titleMedium: textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 16/24,
      letterSpacing: 0.15,
    ),
    titleSmall: textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 14,
      height: 14/20,
      letterSpacing: 0.1,
    ),
    labelLarge: textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 14/20,
      letterSpacing: 0.1,
    ),
    labelMedium: textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 12,
      height: 12/16,
      letterSpacing: 0.5,
    ),
    labelSmall: textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 11,
      height: 11/16,
      letterSpacing: 0.5,
    ),
    bodyLarge: textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      height: 16/24,
      letterSpacing: 0.5,
    ),
    bodyMedium: textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      height: 14/20,
      letterSpacing: 0.25,
    ),
    bodySmall: textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      height: 12/16,
      letterSpacing: 0.4,
    ),
  );
}
