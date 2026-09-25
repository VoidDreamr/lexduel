import 'package:flutter/material.dart';
import 'package:lexduel/components/word_bubble.dart';
import 'package:lexduel/style/app_colors.dart';
import 'package:lexduel/style/app_theme.dart';

class PlayerPanel extends StatelessWidget {
  final int score;
  final List<String> words;
  final CrossAxisAlignment alignment;
  final Color background;

  const new({
    super.key,
    required this.score,
    required this.words,
    required this.background,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: background)),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(AppTheme.spacingXS),
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeXXL,
                    fontWeight: AppTheme.fontWeightBold,
                  ),
                ),
                Text(
                  'Word ${words.length + 1}',
                  style: TextStyle(
                    color: context.colors.primary.withValues(alpha: 0.5),
                    fontSize: AppTheme.fontSizeL,
                    fontWeight: AppTheme.fontWeightBold,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingM,
                    ),
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      return WordBubble(
                        word: words[index],
                        alignment: alignment == CrossAxisAlignment.start
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                      );
                    },
                    separatorBuilder: (_, _) {
                      return const SizedBox(height: AppTheme.spacingXS);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
