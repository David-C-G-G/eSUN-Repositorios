import 'package:esun/presentacion/pantallas.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';


  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
      
          SizedBox(
            height: size.height,
            width: size.width,
            child: const InicioPantalla()
          ),    

        ],
      ),
    );
  }
}
