import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird_stream/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('background.png');
    size = gameRef.size;
    sprite = Sprite(image);
  }
}