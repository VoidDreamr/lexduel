import 'package:lexduel/game/dictionary.dart';
import 'package:lexduel/game/game_state.dart';
import 'package:lexduel/game/player_state.dart';

/// Runs a local, alternating word-chain match.
///
/// Words are normalized to lowercase. Each accepted word must start with the
/// previous accepted word's final letter and is worth one point per letter.
class Game {
  final Dictionary dictionary;
  late GameState _state;

  new({
    required String playerOneId,
    required String playerTwoId,
    required int maxScore,
    required this.dictionary,
  }) {
    if (playerOneId.isEmpty ||
        playerTwoId.isEmpty ||
        playerOneId == playerTwoId) {
      throw ArgumentError('Player IDs must be non-empty and unique.');
    }
    if (maxScore <= 0) {
      throw ArgumentError.value(
        maxScore,
        'maxScore',
        'Must be greater than 0.',
      );
    }

    _state = GameState(
      playerOne: PlayerState(id: playerOneId),
      playerTwo: PlayerState(id: playerTwoId),
      currentPlayerId: playerOneId,
      maxScore: maxScore,
    );
  }

  GameState get state => _state;

  WordSubmissionResult submitWord({
    required String playerId,
    required String word,
  }) {
    // Check if game is finished.
    if (_state.isFinished) {
      return WordSubmissionResult._(
        state: _state,
        error: WordSubmissionError.gameFinished,
      );
    }

    // Check if the wrong player is submitting.
    if (playerId != _state.currentPlayerId) {
      return WordSubmissionResult._(
        state: _state,
        error: WordSubmissionError.wrongPlayer,
      );
    }

    // Normalize word.
    final normalizedWord = word.trim().toLowerCase();

    // Check if starting letter is correct.
    final requiredLetter = _state.requiredStartingLetter;
    if (requiredLetter != null && !normalizedWord.startsWith(requiredLetter)) {
      return WordSubmissionResult._(
        state: _state,
        error: WordSubmissionError.wrongStartingLetter,
      );
    }
    // Validate word.
    if (!RegExp(r'^[a-z]+$').hasMatch(normalizedWord) ||
        !dictionary.isValidWord(normalizedWord)) {
      return WordSubmissionResult._(
        state: _state,
        error: WordSubmissionError.invalidWord,
      );
    }

    // Update player state and game state.
    final isPlayerOneTurn = playerId == _state.playerOne.id;
    final updatedPlayer = isPlayerOneTurn
        ? _state.playerOne.withWord(normalizedWord)
        : _state.playerTwo.withWord(normalizedWord);
    final updatedPlayerOne = isPlayerOneTurn ? updatedPlayer : _state.playerOne;
    final updatedPlayerTwo = isPlayerOneTurn ? _state.playerTwo : updatedPlayer;
    final winnerId = updatedPlayer.score >= _state.maxScore
        ? updatedPlayer.id
        : null;

    _state = GameState(
      playerOne: updatedPlayerOne,
      playerTwo: updatedPlayerTwo,
      currentPlayerId: winnerId == null
          ? (isPlayerOneTurn ? _state.playerTwo.id : _state.playerOne.id)
          : _state.currentPlayerId,
      maxScore: _state.maxScore,
      lastWord: normalizedWord,
      winnerId: winnerId,
    );

    return WordSubmissionResult._(state: _state);
  }
}

class WordSubmissionResult {
  final GameState state;
  final WordSubmissionError? error;

  const WordSubmissionResult._({required this.state, this.error});

  bool get accepted => error == null;
}

enum WordSubmissionError {
  gameFinished,
  wrongPlayer,
  invalidWord,
  wrongStartingLetter,
}
