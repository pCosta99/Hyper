import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(Hyper());
}

class Hyper extends StatelessWidget {
  const Hyper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
