// app_theme/login_teddy_animation.dart
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _animationName = "idle"; // Default Teddy state

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onTextFieldFocus(bool isPasswordField) {
    setState(() {
      _animationName = isPasswordField ? "hands_up" : "idle";
    });
  }

  void _validateLogin() {
    setState(() {
      if (_emailController.text == "admin@example.com" &&
          _passwordController.text == "password123") {
        _animationName = "success";
      } else {
        _animationName = "fail";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: FlareActor(
                  "assets/Teddy.flr",
                  animation: _animationName,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _onTextFieldFocus(false),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onTap: () => _onTextFieldFocus(true),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateLogin,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
