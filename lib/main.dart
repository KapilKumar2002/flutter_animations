// main.dart
import 'package:flutter/material.dart';
import 'package:learn_animations/animations/animated_list_example.dart';
import 'package:learn_animations/animations/custom_animation_1.dart';
import 'package:learn_animations/animations/draggable.dart';
import 'package:learn_animations/animations/physics_model.dart';
import 'package:learn_animations/animations/spring_animation_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // TRY THIS: Change the primary color to Colors.green and trigger a hot
        // reload to see the primary color change.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.orange,
          errorColor: Colors.red,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: CustomAnimation1(),
    );
  }
}
