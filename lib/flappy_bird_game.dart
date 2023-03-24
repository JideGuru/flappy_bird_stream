import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_stream/background.dart';
import 'package:flappy_bird_stream/bird.dart';
import 'package:flappy_bird_stream/ground.dart';
import 'package:flappy_bird_stream/pipe.dart';
import 'package:flappy_bird_stream/pipe_group.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  Future<void> onLoad() async {
    await _initSpeech();
    addAll([
      Background(),
      Ground(),
      _bird = Bird(),
      PipeGroup(),
    ]);
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(onError: (e) => print('ERROR $e'));
    _startListening();
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      _initSpeech();
    }
  }

  Future<void> stopListening() async {
    await _speechToText.cancel();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print('res $result');
    String newWords = result.recognizedWords.toLowerCase();
    print('LAST $_lastWords');
    newWords = newWords.replaceAll(_lastWords.toLowerCase(), '');
    print('NEW $newWords');
    _lastWords = result.recognizedWords;
    if (newWords.toLowerCase().contains('jump')) {
      _bird.fly();
    }
  }

  restartGame() {
    // _bird.reset();
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // _timeSinceLastPipeGroup += dt;
    // if (_timeSinceLastPipeGroup > 1.5) {
    //   add(PipeGroup());
    //   _timeSinceLastPipeGroup = 0;
    // }
  }
}