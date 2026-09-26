import 'package:flutter/services.dart';

class Dictionary {
  final Set<String> _words;

  Dictionary._(Set<String> words) : _words = Set.unmodifiable(words);

  /// Checks whether a word is valid.
  bool isValidWord(String word) => _words.contains(word.trim().toLowerCase());

  /// Returns the dictionary words that begin with [letter].
  Set<String> getWordsThatStartWith(String letter) {
    final normalizedLetter = letter.trim().toLowerCase();
    if (normalizedLetter.length != 1 ||
        !RegExp(r'^[a-z]$').hasMatch(normalizedLetter)) {
      return const {};
    }

    return Set.unmodifiable(
      _words.where((word) => word.startsWith(normalizedLetter)),
    );
  }

  factory Dictionary.fromText(String contents) {
    final words = contents
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim().toLowerCase())
        .where((word) => RegExp(r'^[a-z]+$').hasMatch(word))
        .toSet();

    return Dictionary._(words);
  }

  static Future<Dictionary> load({AssetBundle? bundle}) async {
    final contents = await (bundle ?? rootBundle).loadString(
      'assets/dictionary.txt',
    );
    return Dictionary.fromText(contents);
  }
}
