import 'package:flame/palette.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:forge2d/forge2d.dart'; // CONTACT COMES FROM THIS FUCKING PACKAGE!!!!!

import 'avatar.dart';
import 'wall.dart';

void func(wall){
  print('got here');
}

class Callback extends ContactCallback<Avatar, Wall> {
  Callback();

  @override
  void begin(Avatar a, Wall b, Contact contact){
    func(b);
  }

  @override
  void end(Avatar a, Wall b, Contact contact){
  }
}
