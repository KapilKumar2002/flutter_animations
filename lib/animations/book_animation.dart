// animations/book_animation.dart
import 'package:flutter/material.dart';
import 'dart:math';

class BookAnimationScreen extends StatefulWidget {
  const BookAnimationScreen({super.key});

  @override
  State<BookAnimationScreen> createState() => _BookAnimationScreenState();
}

class _BookAnimationScreenState extends State<BookAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _openedBookSizeAnimation;

  double pageWidth = 170;
  double pageHeight = 250;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _openedBookSizeAnimation = Tween<double>(
      begin: pageWidth,
      end: pageWidth * 2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double delta = details.delta.dx / pageWidth;
    _controller.value -= delta;
  }

  void _onDragEnd(DragEndDetails details) {
    if (_controller.value >= 0.5) {
      // Complete the page turn
      _controller.animateTo(1.0, duration: const Duration(milliseconds: 300));
    } else {
      // Revert the flip
      _controller.animateTo(0.0, duration: const Duration(milliseconds: 300));
    }
    print(_controller.value);
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive setup
    final screenWidth = MediaQuery.of(context).size.width;
    final double maxBookWidth = screenWidth * 0.8;
    final double scaledPageWidth = maxBookWidth / 2;
    final double scaledPageHeight = scaledPageWidth * (pageHeight / pageWidth);

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final width =
                _openedBookSizeAnimation.value / pageWidth * scaledPageWidth;
            final angle = _controller.value * pi; // maps 0–1 to 0–π

            return SizedBox(
              width: width,
              height: scaledPageHeight,
              child: Stack(
                children: [
                  // Blue page (static right page)
                  Positioned(
                    left: width - scaledPageWidth,
                    child: Container(
                      width: scaledPageWidth,
                      height: scaledPageHeight,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Red flipping page with gesture
                  Positioned(
                    left: width - scaledPageWidth,
                    child: GestureDetector(
                      onHorizontalDragUpdate: _onDragUpdate,
                      onHorizontalDragEnd: _onDragEnd,
                      child: Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: Container(
                          width: scaledPageWidth,
                          height: scaledPageHeight,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_controller.value == 1.0)
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                          _controller.animateTo(0.0,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          width: scaledPageWidth,
                          height: scaledPageHeight,
                          color: Colors
                              .transparent, // Must set a color to detect gestures
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
