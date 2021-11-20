import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'avatar.dart';
import 'utils.dart';
import 'callbacks.dart';
import 'area.dart';

void main() {
  runApp(GameWidget(game: MVP()));
}

class MVP extends Forge2DGame with MultiTouchDragDetector, FPSCounter {
  late Avatar avatar;
  static const worldMultiplier = 1.0;
  static const ballMax = 5;
  var listOfAreas = [];

  // No gravity
  MVP() : super(gravity: Vector2.zero(), zoom: worldMultiplier);

  @override
  void update(double dt) {
    super.update(dt);
    final worldSize = size * worldMultiplier;
    if (listOfAreas.length < ballMax) {
      double x = Random().nextInt(worldSize.x.round()).toDouble();
      // Negative y again, this really doesn't help with not having stupid bugs
      double y = -1 * Random().nextInt(worldSize.y.round()).toDouble();

      final area = Area(Vector2(x, y));
      listOfAreas.add(area);
      add(area);
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final worldSize = size * worldMultiplier;

    final sheet = SpriteSheet(
        image: await images.load('avatar.png'), srcSize: Vector2(224, 112));

    final spriteRunning = sheet.createAnimation(row: 1, stepTime: 0.15, to: 7);

    final spriteIdle = sheet.createAnimation(row: 0, stepTime: 0.15, to: 7);

    final comp = SpriteAnimationComponent(
        size: Vector2(66, 33),
        position: getCenter(worldSize),
        animation: spriteIdle);

    avatar = Avatar(Vector2(0, 0), Vector2(66, 33), comp, spriteRunning);

    add(avatar);
    addAll(createBoundaries(this, worldMultiplier));
    addContactCallback(AvatarAreaCallback(listOfAreas));

    camera.followComponent(avatar.positionComponent,
        worldBounds: cameraMaxRect(worldSize));
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    avatar.push(info.delta.game);
    return true;
  }
}
