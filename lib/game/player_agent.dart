import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_state.dart';

/// Responds when a player's turn begins.
abstract interface class PlayerAgent {
  Future<void> onTurn(
    GameState state,
    Future<WordSubmissionResult> Function(String word) submitWord,
  );
}
