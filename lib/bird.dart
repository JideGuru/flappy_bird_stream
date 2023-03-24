import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird_stream/flappy_bird_game.dart';
import 'package:flutter/animation.dart';

class Bird extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  final velocity = 200;

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('bird.png');
    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprite = Sprite(image);

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += velocity * dt;
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, -100),
        EffectController(duration: 0.2, curve: Curves.decelerate),
      ),
    );
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  gameOver() {
    // gameRef.stopListening();
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }
}
