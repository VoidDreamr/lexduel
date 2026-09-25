import 'package:flutter/material.dart';
import 'package:lexduel/components/player_panel.dart';
import 'package:lexduel/style/app_colors.dart';

class GameView extends StatefulWidget {
  const new({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PlayerPanel(
                    score: 10,
                    words: ["Hello", "World"],
                    background: context.accents.positive,
                    alignment: CrossAxisAlignment.end,
                  ),
                ),
                Expanded(
                  child: PlayerPanel(
                    score: 20,
                    words: ["Ollow", "Danger"],
                    background: context.accents.negative,
                  ),
                ),
              ],
            ),
          ),
          // TextField(),
        ],
      ),
    );
  }
}
