// app_theme/next_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NextStoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Next Chapter! 🚀',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ).animate().slideX(begin: -1, end: 0, duration: 600.ms),
      ),
    );
  }
}
