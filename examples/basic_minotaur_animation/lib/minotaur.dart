import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';

// ALL CREDIT FOR THE MINOTAUR GOES TO ELTHEN:
// https://elthen.itch.io/2d-pixel-art-minotaur-sprites

Future<SpriteComponent> minotaurSprite(images) async {
  final spriteSize = Vector2.all(256);

  final minotaurSheet = SpriteSheet(
      image: await images.load('minotaur.png'), srcSize: Vector2.all(96));

  final minotaurSpriteComponent = SpriteComponent(
    sprite: minotaurSheet.getSprite(1, 0),
    size: spriteSize,
    position: Vector2(50, 250),
  );

  return minotaurSpriteComponent;
}

Future<SpriteAnimationComponent> minotaurAnimation(images) async {
  final spriteSize = Vector2.all(256);

  final minotaurSheet = SpriteSheet(
      image: await images.load('minotaur.png'), srcSize: Vector2.all(96));

  final minotaur =
      minotaurSheet.createAnimation(row: 16, stepTime: 0.15, to: 8);
  final minotaurComponent = SpriteAnimationComponent(
      animation: minotaur, position: Vector2(250, 250), size: spriteSize);

  return minotaurComponent;
}
