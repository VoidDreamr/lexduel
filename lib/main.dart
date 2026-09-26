import 'package:flutter/material.dart';
import 'package:lexduel/game/dictionary.dart';
import 'package:lexduel/style/app_theme.dart';
import 'package:lexduel/style/color_set.dart';
import 'package:lexduel/views/game_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dictionary = await Dictionary.load();
  runApp(MyApp(dictionary: dictionary));
}

class MyApp extends StatelessWidget {
  final Dictionary dictionary;

  const MyApp({super.key, required this.dictionary});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lex Duel!',
      theme: AppTheme.buildTheme(Brightness.dark, ColorSet.ocean),
      debugShowCheckedModeBanner: false,
      home: GameView(dictionary: dictionary),
    );
  }
}
