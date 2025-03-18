// animations/physics_model.dart
import 'package:flutter/material.dart';

class PhysicalModelExample extends StatefulWidget {
  @override
  _PhysicalModelExampleState createState() => _PhysicalModelExampleState();
}

class _PhysicalModelExampleState extends State<PhysicalModelExample> {
  bool _pressed = false;

  void _togglePressed() {
    setState(() {
      _pressed = !_pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapDown: (_) => _togglePressed(),
          onTapUp: (_) => _togglePressed(),
          onTap: () {
            print("Button Pressed");
          },
          child: AnimatedPhysicalModel(
            duration: Duration(milliseconds: 300),
            shape: BoxShape.rectangle,
            color: Colors.blue,
            elevation: _pressed ? 0 : 10, // Elevation reduces on press
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 150,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                "Press Me",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
