import 'package:flutter/material.dart';
import 'package:lexduel/style/app_theme.dart';
import 'package:lexduel/style/color_set.dart';
import 'package:lexduel/views/game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lex Duel!',
      theme: AppTheme.buildTheme(Brightness.dark, ColorSet.ocean),
      debugShowCheckedModeBanner: false,
      home: const GameView(),
    );
  }
}
