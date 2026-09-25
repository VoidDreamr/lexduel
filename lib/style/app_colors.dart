import 'package:flutter/material.dart';
import 'package:lexduel/style/color_set.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Colors
  final Color positive;
  final Color neutral;
  final Color negative;
  final Color highlight;

  final Color textPositive;

  final Color onPositive;
  final Color onPositiveSecondary;
  final Color onNegative;

  Gradient get gradient => ColorSet.buildGradient(positive, neutral);

  const AppColors({
    required this.positive,
    required this.neutral,
    required this.negative,
    required this.highlight,
    required this.textPositive,
    required this.onPositive,
    required this.onPositiveSecondary,
    required this.onNegative,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? positive,
    Color? neutral,
    Color? negative,
    Color? highlight,
    Color? textPositive,
    Color? onPositive,
    Color? onPositiveSecondary,
    Color? onPositiveTertiary,
    Color? onNegative,
  }) {
    return AppColors(
      positive: positive ?? this.positive,
      neutral: neutral ?? this.neutral,
      negative: negative ?? this.negative,
      highlight: highlight ?? this.highlight,
      textPositive: textPositive ?? this.textPositive,
      onPositive: onPositive ?? this.onPositive,
      onPositiveSecondary: onPositiveSecondary ?? this.onPositiveSecondary,
      onNegative: onNegative ?? this.onNegative,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      positive: Color.lerp(positive, other.positive, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
      textPositive: Color.lerp(textPositive, other.textPositive, t)!,
      onPositive: Color.lerp(onPositive, other.onPositive, t)!,
      onPositiveSecondary: Color.lerp(
        onPositiveSecondary,
        other.onPositiveSecondary,
        t,
      )!,
      onNegative: Color.lerp(onNegative, other.onNegative, t)!,
    );
  }
}

sealed class AppColorsDark {
  // Colors
  static const Color surface = Color(0xFF101010);
  static const Color primary = Colors.white;
  static const Color secondary = Color(0xB4FFFFFF);
  static const Color tertiary = Color(0x5AFFFFFF);
}

sealed class AppColorsLight {
  // Colors
  static const Color surface = Color(0xFFDFDFDF);
  static const Color primary = Colors.black;
  static const Color secondary = Color(0xB4000000);
  static const Color tertiary = Color(0x5A000000);
}

extension AppColorsGetter on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  AppColors get accents => Theme.of(this).extension<AppColors>()!;
}
