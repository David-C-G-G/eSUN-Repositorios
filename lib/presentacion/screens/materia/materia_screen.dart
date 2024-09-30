import 'package:flutter/material.dart';

class MateriasScreen extends StatelessWidget {

  static const String name = 'MariaScreen';

  const MateriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
    );
  }
}