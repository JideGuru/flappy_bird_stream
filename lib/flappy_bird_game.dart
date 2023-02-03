import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_stream/background.dart';
import 'package:flappy_bird_stream/bird.dart';
import 'package:flappy_bird_stream/ground.dart';
import 'package:flappy_bird_stream/pipe.dart';
import 'package:flappy_bird_stream/pipe_group.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      _bird = Bird(),
      PipeGroup(),
    ]);
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceLastPipeGroup += dt;
    if (_timeSinceLastPipeGroup > 1.5) {
      add(PipeGroup());
      _timeSinceLastPipeGroup = 0;
    }
  }
}