import 'package:flutter/services.dart';

class Dictionary {
  final Set<String> _words;

  Dictionary._(Set<String> words) : _words = Set.unmodifiable(words);

  /// Checks whether a word is valid.
  bool isValidWord(String word) => _words.contains(word.trim().toLowerCase());

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
