import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'avatar.dart';
import 'utils.dart';

void main() {
  runApp(GameWidget (game: MVP()));
}

class MVP extends Forge2DGame with MultiTouchDragDetector, FPSCounter {
  late Avatar avatar;
  static const worldMultiplier = 5.0;

  // No gravity
  MVP() : super(gravity: Vector2.zero(), zoom: worldMultiplier);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final worldSize = size * worldMultiplier;

    final sheet = SpriteSheet(
        image: await images.load('avatar.png'), srcSize: Vector2(224, 112));

    final spriteRunning = sheet.createAnimation(row: 1, stepTime: 0.15, to: 7);

    final spriteIdle = sheet.createAnimation(row: 0, stepTime: 2.15, to: 7);

    final comp = SpriteAnimationComponent(
        size: Vector2(66, 33),
        position: getCenter(worldSize),
        animation: spriteIdle);

    avatar = Avatar(Vector2(0, 0), Vector2(66, 33), comp,
        spriteRunning);

    add(avatar);

    camera.followComponent(avatar.positionComponent,
        worldBounds: cameraMaxRect(worldSize));
  }
}
