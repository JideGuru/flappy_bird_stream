import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird_stream/flappy_bird_game.dart';

class Ground extends ParallaxComponent<FlappyBirdGame> {
  Ground();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('base.png');
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(image, fill: LayerFill.none),
      ),
    ]);
    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - 110),
        size: Vector2(gameRef.size.x, 110)
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = gameRef.speed;
  }
}
