import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:lexduel/components/player_panel.dart';
import 'package:lexduel/components/word_field.dart';
import 'package:lexduel/game/ai_player_agent.dart';
import 'package:lexduel/game/dictionary.dart';
import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_controller.dart';
import 'package:lexduel/game/game_state.dart';
import 'package:lexduel/game/local_player_agent.dart';
import 'package:lexduel/style/app_colors.dart';
import 'package:lexduel/style/app_theme.dart';

class GameView extends StatefulWidget {
  final Dictionary dictionary;

  const new({super.key, required this.dictionary});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController(
      Game(
        playerOneId: 'Player 1',
        playerTwoId: 'Player 2',
        maxScore: 45,
        dictionary: widget.dictionary,
      ),
      playerAgents: {
        'Player 1': const LocalPlayerAgent(),
        'Player 2': AIPlayerAgent(widget.dictionary),
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final state = _controller.state;
        final submissionError = _controller.lastError;
        final playerOneShare = state.currentPlayerId == state.playerOne.id
            ? 4 / 7
            : 3 / 7;

        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: playerOneShare,
                        end: playerOneShare,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      builder: (context, share, _) {
                        final playerOneFlex = (share * 1000).round();
                        final playerTwoFlex = 1000 - playerOneFlex;
                        return Row(
                          children: [
                            Expanded(
                              flex: playerOneFlex,
                              child: PlayerPanel(
                                score: state.playerOne.score,
                                words: state.playerOne.words,
                                background: context.accents.positive,
                                alignment: CrossAxisAlignment.end,
                              ),
                            ),
                            Expanded(
                              flex: playerTwoFlex,
                              child: PlayerPanel(
                                score: state.playerTwo.score,
                                words: state.playerTwo.words,
                                background: context.accents.negative,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    color: AppColorsDark.primary,
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (submissionError != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  submissionError.message,
                                  style: TextStyle(
                                    color: context.accents.negative,
                                  ),
                                ),
                              ),
                            WordField(
                              onSubmitted: (word) async {
                                await _controller.submitWord(word);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (state.isFinished)
                Positioned.fill(child: _buildWinOverlay(context, state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWinOverlay(BuildContext context, GameState state) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Colors.black.withValues(alpha: 0.65),
          alignment: Alignment.center,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 56,
                  color: state.winnerId == state.playerOne.id
                      ? context.accents.positive
                      : context.accents.negative,
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  '${state.winnerId} wins!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeXXL,
                    fontWeight: AppTheme.fontWeightBold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingL),
                Text(
                  '${state.playerOne.score} - ${state.playerTwo.score}',
                  style: TextStyle(fontSize: AppTheme.fontSizeXL),
                ),
                const SizedBox(height: AppTheme.spacingXL),
                FilledButton.icon(
                  onPressed: _controller.rematch,
                  icon: const Icon(Icons.replay),
                  label: const Text('Rematch'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
