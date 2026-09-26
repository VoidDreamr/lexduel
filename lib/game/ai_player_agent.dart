import 'dart:math';

import 'package:lexduel/game/dictionary.dart';
import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_state.dart';
import 'package:lexduel/game/player_agent.dart';

/// Chooses a random valid dictionary word on its turn.
class AIPlayerAgent implements PlayerAgent {
  final Dictionary dictionary;
  final Random _random;

  AIPlayerAgent(this.dictionary, {Random? random})
    : _random = random ?? Random();

  @override
  Future<void> onTurn(
    GameState state,
    Future<WordSubmissionResult> Function(String word) submitWord,
  ) async {
    final letter = state.requiredStartingLetter;
    if (letter == null) return;

    await Future<void>.delayed(
      Duration(milliseconds: 800 + _random.nextInt(401)),
    );

    final words = dictionary.getWordsThatStartWith(letter).toList();
    final word = words[_random.nextInt(words.length)];
    await submitWord(word);
  }
}
