import 'package:lexduel/game/game.dart';
import 'package:lexduel/game/game_state.dart';
import 'package:lexduel/game/player_agent.dart';

/// A human player whose words are supplied by the view.
class LocalPlayerAgent implements PlayerAgent {
  const LocalPlayerAgent();

  @override
  Future<void> onTurn(
    GameState state,
    Future<WordSubmissionResult> Function(String word) submitWord,
  ) async {
    // The local player's input is submitted directly by the view.
  }
}
