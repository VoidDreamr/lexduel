import 'package:flutter/foundation.dart';
import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_state.dart';
import 'package:lexduel/game/player_agent.dart';

class GameController extends ChangeNotifier {
  final Game _game;
  final Map<String, PlayerAgent> _playerAgents;
  WordSubmissionError? _lastError;

  GameController(this._game, {required Map<String, PlayerAgent> playerAgents})
    : _playerAgents = Map.unmodifiable(playerAgents);

  GameState get state => _game.state;
  WordSubmissionError? get lastError => _lastError;

  Future<WordSubmissionResult> submitWord(String word) async {
    final result = _game.submitWord(
      playerId: state.currentPlayerId,
      word: word,
    );
    _lastError = result.error;
    notifyListeners();

    if (result.accepted && !result.state.isFinished) {
      final nextPlayerAgent = _playerAgents[result.state.currentPlayerId];
      if (nextPlayerAgent != null) {
        await nextPlayerAgent.onTurn(result.state, submitWord);
      }
    }

    return result;
  }

  void rematch() {
    _game.reset();
    _lastError = null;
    notifyListeners();
  }
}
