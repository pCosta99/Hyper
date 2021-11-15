import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:forge2d/forge2d.dart'; // CONTACT COMES FROM THIS FUCKING PACKAGE!!!!!

import 'sprite.dart';
import 'boundaries.dart';

class AvatarWallCallback extends ContactCallback<Avatar, Wall> {
  AvatarWallCallback();

  @override
  void begin(Avatar a, Wall b, Contact contact){
  }

  @override
  void end(Avatar a, Wall b, Contact contact){
    a.invertDirection();
  }
}
