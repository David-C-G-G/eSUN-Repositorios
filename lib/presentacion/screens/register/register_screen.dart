import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

  static const String name = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
    );
  }
}