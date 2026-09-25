import 'package:flutter/material.dart';
import 'package:lexduel/style/app_colors.dart';

enum ColorSet {
  runway(
    positive: Color.fromARGB(255, 108, 92, 224),
    neutral: Color.fromARGB(255, 82, 115, 255),
    negative: Color(0xFFCF4F6D),
    textPositive: Color.fromARGB(255, 108, 92, 224),
  ),
  ocean(
    positive: Color(0xFF5273B8), // muted royal blue
    neutral: Color(0xFF3E5A94), // deeper navy blue
    negative: Color(0xFFCF5872), // cool rose to contrast deep blues
    textPositive: Color(0xFF5273B8),
  ),
  slate(
    positive: Color(0xFF6B7B95),
    neutral: Color(0xFF536375),
    negative: Color(0xFFCF5A72),
    textPositive: Color(0xFF6B7B95),
  ),
  lavender(
    positive: Color(0xFF9B7DB8), // muted lavender
    neutral: Color(0xFF82659C), // deeper purple
    negative: Color(0xFFCF5B6D),
    textPositive: Color(0xFF9B7DB8), // rose-red to complement purples
  ),
  emerald(
    positive: Color(0xFF52A86F),
    neutral: Color(0xFF438A5A),
    negative: Color(0xFFCF6B5A),
    textPositive: Color(0xFF52A86F),
  ),

  plumb(
    positive: Color(0xFF9B6BA8),
    neutral: Color(0xFFB85C8F),
    negative: Color(0xFFD4526B),
    textPositive: Color(0xFF9B6BA8),
  ),
  sunset(
    positive: Color(0xFF4A78B8), // darker sky blue
    neutral: Color(0xFFBF7342), // darker burnt orange
    negative: Color(0xFFCF5E6A), // warm coral-red
    textPositive: Color(0xFF4A78B8), // warm coral-red to match sunset vibe
  ),
  magenta(
    positive: Color(0xFFC4628A), // more muted magenta-pink
    neutral: Color(0xFF6B7FBA), // soft periwinkle blue
    negative: Color(0xFFCF5268),
    textPositive: Color(0xFFC4628A), // rose-red, complements the pink→blue
  ),
  coral(
    positive: Color(0xFFD47B7B),
    neutral: Color(0xFFD4945A),
    negative: Color(0xFFCF4F6D),
    textPositive: Color(0xFFD47B7B),
  ),
  amber(
    positive: Color(0xFFD4945A),
    neutral: Color(0xFFB77A35),
    negative: Color(0xFFCF5B6D),
    textPositive: Color(0xFFD4945A),
  ),

  // Neon
  neonBlue(
    positive: Color(0xFF35D3DE),
    neutral: Color(0xFF0ACEFF), // reference - stays same
    negative: Color(0xFFDB575B), // reference - stays same
    textPositive: Color(0xFF1FB6C1),
    onPositive: AppColorsLight.primary,
    onPositiveSecondary: AppColorsLight.secondary,
  ),
  neonPurple(
    positive: Color(0xFF8A6FFF),
    neutral: Color(0xFFAA7FFF), // shifted toward pink
    negative: Color(0xFFFF5D8A), // magenta-pink to complement purple
    textPositive: Color(0xFF7058E0),
    onPositive: AppColorsLight.primary,
    onPositiveSecondary: AppColorsLight.secondary,
  ),
  neonPink(
    positive: Color(0xFFFF5FD7),
    neutral: Color(0xFFFF70FF), // shifted toward purple
    negative: Color(0xFFFF5F70), // coral-red to match pink family
    textPositive: Color(0xFFE04AB8),
    onPositive: AppColorsLight.primary,
    onPositiveSecondary: AppColorsLight.secondary,
  ),
  neonOrange(
    positive: Color(0xFFFF8040),
    neutral: Color(0xFFFFB040), // shifted toward yellow
    negative: Color(0xFFFF5080), // hot pink to complement warm orange
    textPositive: Color(0xFFE06B30),
    onPositive: AppColorsLight.primary,
    onPositiveSecondary: AppColorsLight.secondary,
  ),
  neonGreen(
    positive: Color(0xFF4AE8A0),
    neutral: Color(0xFF5FFFD0), // shifted toward cyan/aqua
    negative: Color(0xFFFF6B5F), // warm coral to contrast cool green
    textPositive: Color(0xFF2AA06B),
    onPositive: AppColorsLight.primary,
    onPositiveSecondary: AppColorsLight.secondary,
  );

  final Color positive;
  final Color neutral;
  final Color negative;
  final Color textPositive;
  final Color onPositive;
  final Color onPositiveSecondary;
  final Color onNegative;

  Gradient get gradient => buildGradient(positive, neutral);

  const ColorSet({
    required this.positive,
    required this.neutral,
    required this.negative,
    required this.textPositive,
    this.onPositive = AppColorsDark.primary,
    this.onPositiveSecondary = AppColorsDark.secondary,
    // ignore: unused_element_parameter
    this.onNegative = AppColorsDark.primary,
  });

  static Gradient buildGradient(Color positive, Color neutral) {
    return LinearGradient(
      colors: [neutral, positive],
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.0, 0.35],
    );
  }
}
