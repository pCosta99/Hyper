import 'package:flutter/material.dart';
import 'package:hyper/dot.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double x = 0;
  double y = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          //widget
          child: GestureDetector(
            child: AnimatedContainer(
              alignment: Alignment(
                  x, y), //specifies where our "dot" should be positioned
              duration: Duration(milliseconds: 0),
              color: Colors.white,
              child: Dot(),
            ),
          ),
        ),
        Expanded(
          //widget
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    ));
  }
}
