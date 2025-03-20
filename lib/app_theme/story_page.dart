// app_theme/story_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learn_animations/app_theme/next_page.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  late final AnimationController _cloudController;
  late final AnimationController _birdController;
  late final AnimationController _lottieController;

  late final Animation<double> _cloudAnimation;
  late final Animation<double> _birdAnimation;

  double _animationSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    // Cloud Animation Controller
    _cloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    // Bird Animation Controller
    _birdController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    // Lottie Animation Controller
    _lottieController = AnimationController(vsync: this);

    _cloudAnimation = Tween<double>(begin: -50, end: 250).animate(
      CurvedAnimation(parent: _cloudController, curve: Curves.easeInOut),
    );

    _birdAnimation = Tween<double>(begin: 0, end: 800).animate(
      CurvedAnimation(parent: _birdController, curve: Curves.linear),
    );
  }

  void _playAnimation() {
    _cloudController.repeat(reverse: true);
    _birdController.repeat(reverse: true);
    _lottieController.repeat();
  }

  void _pauseAnimation() {
    _cloudController.stop();
    _birdController.stop();
    _lottieController.stop();
  }

  void _restartAnimation() {
    _cloudController.reset();
    _birdController.reset();
    _lottieController.reset();
    _playAnimation();
  }

  void _changeSpeed(double speed) {
    setState(() {
      _animationSpeed = speed;
      _cloudController.duration = Duration(seconds: (5 / speed).toInt());
      _birdController.duration = Duration(seconds: (5 / speed).toInt());
      _cloudController.repeat(reverse: true);
      _birdController.repeat(reverse: true);
      _lottieController.value = 0; // Restart Lottie with new speed
      _lottieController.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_cloudController.isAnimating) {
            _pauseAnimation();
          } else {
            _playAnimation();
          }
        },
        child:
            Icon(_cloudController.isAnimating ? Icons.pause : Icons.play_arrow),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.png', fit: BoxFit.cover),
          ),
          _buildCloud(100, left: true),
          _buildCloud(100, left: false),
          _buildRainyCloud(165, left: true),
          _buildRainyCloud(165, left: false),
          for (double top in [200, 300, 400]) buildFlyingBird(top),
          _buildNextButton(context),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildCloud(double top, {bool? left}) {
    return AnimatedBuilder(
      animation: _cloudController,
      builder: (context, child) {
        return Positioned(
          top: left == true ? top : top + 100,
          left: left == true ? _cloudAnimation.value : null,
          right: left == false ? _cloudAnimation.value : null,
          child: Image.asset('assets/cloud.png', width: 150),
        );
      },
    );
  }

  Widget _buildRainyCloud(double top, {bool? left}) {
    return AnimatedBuilder(
      animation: _cloudController,
      builder: (context, child) {
        return Positioned(
          top: left == true ? top : top + 100,
          left: left == true ? _cloudAnimation.value + 20 : null,
          right: left == false ? _cloudAnimation.value - 20 : null,
          child: Lottie.asset('assets/raining.json', width: 150),
        );
      },
    );
  }

  Widget buildFlyingBird(double top) {
    return AnimatedBuilder(
      animation: _birdController,
      builder: (context, child) {
        return Positioned(
          top: top,
          left: _birdAnimation.value - top,
          child: Transform(
            alignment: Alignment.center,
            transform: _birdController.status == AnimationStatus.reverse
                ? Matrix4.rotationY(math.pi)
                : Matrix4.identity(),
            child: Lottie.asset(
              'assets/bird.json',
              width: 150,
              controller: _lottieController,
              onLoaded: (composition) {
                _lottieController
                  ..duration = composition.duration
                  ..repeat();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 50,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextStoryPage()),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(
            'Next Page',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ).animate().fade(duration: 800.ms),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.play_arrow), onPressed: _playAnimation),
              IconButton(icon: Icon(Icons.pause), onPressed: _pauseAnimation),
              IconButton(
                  icon: Icon(Icons.replay), onPressed: _restartAnimation),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Speed: ${_animationSpeed.toStringAsFixed(1)}x"),
                Slider(
                  min: 0.5,
                  max: 2.0,
                  value: _animationSpeed,
                  onChanged: _changeSpeed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _birdController.dispose();
    _lottieController.dispose();
    super.dispose();
  }
}
