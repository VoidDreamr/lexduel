class PlayerState {
  final String id;
  final int score;
  final List<String> words;

  new({required this.id, this.score = 0, List<String> words = const []})
    : words = List.unmodifiable(words);

  PlayerState withWord(String word) =>
      PlayerState(id: id, score: score + word.length, words: [...words, word]);
}
