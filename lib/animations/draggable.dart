// animations/draggable.dart
import 'package:flutter/material.dart';

class DraggableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Draggable(
          feedback: _buildBox(), // What appears when dragging
          childWhenDragging: Container(), // Hides original box
          child: _buildBox(), // Normal box
        ),
      ),
    );
  }

  Widget _buildBox() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
