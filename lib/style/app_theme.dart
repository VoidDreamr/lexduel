import 'package:flutter/material.dart';
import 'package:lexduel/style/app_colors.dart';
import 'package:lexduel/style/color_set.dart';

sealed class AppTheme {
  // Spacing
  static const double spacingXXS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingS = 12.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Font sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 24.0;
  static const double fontSizeXXL = 36.0;
  static const double fontSizeXXXL = 64.0;

  // Font weights
  static const FontWeight fontWeightLight = FontWeight.w200;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightBold = FontWeight.w700;

  static ThemeData buildTheme(
    Brightness brightness, [
    ColorSet colorSet = ColorSet.runway,
  ]) {
    late ColorScheme colors;
    if (brightness == Brightness.light) {
      colors = ColorScheme.light(
        primary: AppColorsLight.primary,
        secondary: AppColorsLight.secondary,
        tertiary: AppColorsLight.tertiary,
        surface: AppColorsLight.surface,
        error: colorSet.negative,
      );
    } else {
      colors = ColorScheme.dark(
        primary: AppColorsDark.primary,
        secondary: AppColorsDark.secondary,
        tertiary: AppColorsDark.tertiary,
        surface: AppColorsDark.surface,
        error: colorSet.negative,
      );
    }

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      brightness: brightness,
      colorScheme: colors,
      extensions: [
        AppColors(
          positive: colorSet.positive,
          neutral: colorSet.neutral,
          negative: colorSet.negative,
          highlight: colors.primary.withValues(alpha: 0.1),
          textPositive: colorSet.textPositive,
          onPositive: colorSet.onPositive,
          onPositiveSecondary: colorSet.onPositiveSecondary,
          onNegative: colorSet.onNegative,
        ),
      ],
    );
  }
}
