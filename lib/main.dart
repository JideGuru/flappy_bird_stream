import 'package:flame/game.dart';
import 'package:flappy_bird_stream/flappy_bird_game.dart';
import 'package:flappy_bird_stream/game_over_page.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'gameOver': (context, _) => GameOverPage(game: game),
      },
    ),
  );
}
