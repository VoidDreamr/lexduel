import 'package:flutter/material.dart';
import 'package:lexduel/style/app_colors.dart';
import 'package:lexduel/style/app_theme.dart';

class WordBubble extends StatelessWidget {
  final String word;
  final AlignmentGeometry alignment;

  const new({
    super.key,
    required this.word,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingXS,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(AppTheme.spacingL),
        ),
        child: Text(
          word,
          style: TextStyle(
            color: context.colors.onPrimary,
            fontWeight: AppTheme.fontWeightMedium,
          ),
        ),
      ),
    );
  }
}
