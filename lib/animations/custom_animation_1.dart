// animations/custom_animation_1.dart
import 'package:flutter/material.dart';

class CustomAnimation1 extends StatefulWidget {
  const CustomAnimation1({super.key});

  @override
  State<CustomAnimation1> createState() => _CustomAnimation1State();
}

class _CustomAnimation1State extends State<CustomAnimation1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Syncs with screen refresh rate
      duration: Duration(seconds: 2), // Animation time
    )..repeat(reverse: true); // Repeats back and forth
    _sizeAnimation = Tween<double>(begin: 100, end: 150).animate(_controller);

    // _animation =
    //     CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            Center(
              child: FadeTransition(
                // Automatically animates opacity
                opacity: _controller,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) => Icon(
                Icons.favorite,
                color: Colors.red,
                size: _sizeAnimation.value,
              ),
            ),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Transform.flip(
                  flipX: true,
                  flipY: true,
                  origin: Offset(_sizeAnimation.value, _sizeAnimation.value),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.purple,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Free up resources
    super.dispose();
  }
}
