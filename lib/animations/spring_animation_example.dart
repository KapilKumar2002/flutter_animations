// animations/spring_animation_example.dart
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SpringAnimationExample extends StatefulWidget {
  @override
  _SpringAnimationExampleState createState() => _SpringAnimationExampleState();
}

class _SpringAnimationExampleState extends State<SpringAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _runAnimation() {
    final spring = SpringDescription(
      mass: 1, // Mass of object
      stiffness: 100, // Higher = Faster bounce back
      damping: 10, // Controls friction (Lower = more bouncy)
    );

    final simulation = SpringSimulation(
      spring,
      0, // Start position
      300, // End position
      0, // Initial velocity
    );

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
    _animation = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: _runAnimation,
            child: Container(
              height: 100,
              color: Colors.red,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _runAnimation,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 100,
                    height: _animation.value, // Animates height
                    color: Colors.blue,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
