import 'package:flame/input.dart';
import 'package:flame/game.dart';

import 'minotaur.dart';

class MyGame extends FlameGame with DoubleTapDetector {
  bool running = true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Wondering if I could acess images directly in the minotaur file...
    add(await minotaurAnimation(images));

    add(await minotaurSprite(images));
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}
