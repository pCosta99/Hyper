import 'dart:ui' hide TextStyle;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'sprite.dart';
import 'boundaries.dart';
import 'area.dart';
import 'avatar_wall_callback.dart';

Vector2 getCenter(Vector2 size) {
  var center = size.clone();
  center.multiply(Vector2(0.5, -0.5));
  return center;
}

Rect cameraMaxRect(worldSize) {
  // Very very odd, but works, the width/height can't exactly match the world size
  final rect = Rect.fromLTWH(0, 0, worldSize.x + 0.1, worldSize.y + 0.1);

  return rect;
}

class MyGame extends Forge2DGame with MultiTouchDragDetector, FPSCounter {
  late Avatar avatar;
  var listOfAreas = [];

  static const worldMultiplier = 5.0;

  static final fpsTextPaint = TextPaint(
    config: const TextPaintConfig(color: Color(0xFFFFFFFF)),
  );

  /*@override*/
  /*bool debugMode = true;*/

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode) {
      fpsTextPaint.render(canvas, fps(120).toString(), Vector2(0, 50));
    }
  }

  // No gravity
  MyGame() : super(gravity: Vector2(0, 0), zoom: worldMultiplier);

  @override
  void update(double dt) {
    super.update(dt);
    final worldSize = size * worldMultiplier;
    if (listOfAreas.length < 20) {
      double x = Random().nextInt(1000).toDouble();
      double y = Random().nextInt(1000).toDouble();

      final area = Area(getCenter(worldSize) + Vector2(x, y));
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

    final spriteIdle = sheet.createAnimation(row: 0, stepTime: 2.15, to: 7);

    final comp = SpriteAnimationComponent(
        size: Vector2(66, 33),
        position: getCenter(worldSize),
        animation: spriteIdle);

    // If it was only needed to get 1 frame
    /*final _sprite = sheet.getSprite(0, 1);*/

    avatar = Avatar(getCenter(worldSize), Vector2(0, 0), Vector2(66, 33), comp,
        spriteRunning);

    addAll(createBoundaries(this));
    add(avatar);
    addContactCallback(AvatarWallCallback());

    camera.followComponent(avatar.positionComponent,
        worldBounds: cameraMaxRect(worldSize));
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    print('Update ${info.delta.game}');
    avatar.push(info.delta.game);
    return true;
  }

  // Use onDragEnd and onDragStart to block dragging. The objective is to only allow swipping the sprite around.
  @override
  void onDragEnd(int pointerId, DragEndInfo info) {
    print('End ${info.velocity}');
  }

  @override
  void onDragStart(int pointerId, DragStartInfo info) {
    print('Start ${info.eventPosition.game}');
  }
}
