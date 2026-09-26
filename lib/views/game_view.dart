import 'package:flutter/material.dart';
import 'package:lexduel/components/player_panel.dart';
import 'package:lexduel/components/word_field.dart';
import 'package:lexduel/game/dictionary.dart';
import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_controller.dart';
import 'package:lexduel/style/app_colors.dart';

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
        maxScore: 15,
        dictionary: widget.dictionary,
      ),
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
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: PlayerPanel(
                        score: state.playerOne.score,
                        words: state.playerOne.words,
                        background: context.accents.positive,
                        alignment: CrossAxisAlignment.end,
                      ),
                    ),
                    Expanded(
                      child: PlayerPanel(
                        score: state.playerTwo.score,
                        words: state.playerTwo.words,
                        background: context.accents.negative,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColorsDark.primary,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: state.isFinished
                        ? Center(
                            child: Text(
                              '${state.winnerId} wins!',
                              style: TextStyle(color: context.colors.onPrimary),
                            ),
                          )
                        : Column(
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
                              Text(
                                '${state.currentPlayerId}\'s turn',
                                style: TextStyle(
                                  color: context.colors.onPrimary,
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
        );
      },
    );
  }
}
