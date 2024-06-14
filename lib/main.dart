import 'package:esun/config/config.dart';
import 'package:esun/presentacion/screens.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 5, isDarkmode: false).getTheme(),
      home: const HomeScreen()
    );
  }
}