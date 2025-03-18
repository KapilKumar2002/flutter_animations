import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _dialogShown = false; // Prevent multiple alerts

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Completes in 10 seconds
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Listen for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    if (!_dialogShown) {
      _dialogShown = true;
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing without clicking "OK"
        builder: (context) => AlertDialog(
          title: Text("Completed"),
          content: Text("The progress has reached 100%!"),
          actions: [
            TextButton(
              onPressed: () {
                _controller.stop(); // Stop animation completely
                Navigator.of(context).pop();
                setState(() {
                  _dialogShown = false; // Reset for future use
                });
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => CircularProgressIndicator(
              value: _animation.value,
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
