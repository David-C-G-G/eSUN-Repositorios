import 'package:flutter/material.dart';

class CreateRepositoriosScreen extends StatelessWidget {

  static const String name = 'CreateRepositoriosScreen';

  const CreateRepositoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
    );
  }
}