import 'package:flutter/foundation.dart';
import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_state.dart';

class GameController extends ChangeNotifier {
  final Game _game;
  WordSubmissionError? _lastError;

  GameController(this._game);

  GameState get state => _game.state;
  WordSubmissionError? get lastError => _lastError;

  Future<WordSubmissionResult> submitWord(String word) {
    final result = _game.submitWord(
      playerId: state.currentPlayerId,
      word: word,
    );
    _lastError = result.error;
    notifyListeners();
    return Future.value(result);
  }
}
