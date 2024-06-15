import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                height: 100,
                width: 150,
                child: Image.asset('assets/escudo.png'),
              );
  }
}