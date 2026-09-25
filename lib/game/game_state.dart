import 'package:lexduel/game/player_state.dart';

class GameState {
  final PlayerState playerOne;
  final PlayerState playerTwo;
  final String currentPlayerId;
  final int maxScore;
  final String? lastWord;
  final String? winnerId;

  new({
    required this.playerOne,
    required this.playerTwo,
    required this.currentPlayerId,
    required this.maxScore,
    this.lastWord,
    this.winnerId,
  });

  bool get isFinished => winnerId != null;
  String? get requiredStartingLetter {
    final word = lastWord;
    return word?.substring(word.length - 1);
  }
}
