import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String texto;

  const CustomButton({
    required this.texto,
    super.key
   });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colors.primary,
        child: InkWell(
          splashColor: Colors.amber.shade800,
          // focusColor: Colors.amber.shade800,
          // highlightColor: Colors.purpleAccent,
          // hoverColor: Colors.amberAccent,
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(texto, style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}