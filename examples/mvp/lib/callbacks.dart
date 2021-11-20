import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:forge2d/forge2d.dart'; // CONTACT COMES FROM THIS FUCKING PACKAGE!!!!!

import 'avatar.dart';
import 'area.dart';

class AvatarAreaCallback extends ContactCallback<Avatar, Area> {
  var list;
  AvatarAreaCallback(this.list);

  @override
  void begin(Avatar a, Area b, Contact contact) {
    b.shouldRemove = true;
    list.remove(b);
  }

  @override
  void end(Avatar a, Area b, Contact contact) {}
}
