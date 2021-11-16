import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:ui' hide TextStyle;
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import 'sprite.dart';
import 'boundaries.dart';
import 'avatar_wall_callback.dart';

Vector2 getCenter(size) {
  var center = size;
  center.multiply(Vector2(0.5, -0.5));
  return center;
}

class MyGame extends Forge2DGame with MultiTouchDragDetector, FPSCounter {
  late Avatar avatar;

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
  MyGame() : super(gravity: Vector2(0, 0));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sheet = SpriteSheet(
        image: await images.load('avatar.png'), srcSize: Vector2(224, 112));

    final _sprite = sheet.getSprite(0, 1);
    avatar = Avatar(getCenter(size), Vector2(0, 0), _sprite);

    addAll(createBoundaries(this));
    add(avatar);
    addContactCallback(AvatarWallCallback());
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    print('Update ${info.delta.game}');
    avatar.move(info.delta.game);
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
