import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird_stream/flappy_bird_game.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Pipe({required PipePosition pipePosition, required double height})
      : _pipePosition = pipePosition,
        _height = height;

  final PipePosition _pipePosition;
  final double _height;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load('pipe.png');
    final pipeRotated = await Flame.images.load('pipe_rotated.png');
    size = Vector2(50, _height);
    switch (_pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - 110;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}

enum PipePosition { top, bottom }
