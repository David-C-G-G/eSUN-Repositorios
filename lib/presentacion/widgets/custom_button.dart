import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String texto;
  final Function()? onTap;

  const CustomButton({
    required this.texto,
    this.onTap,
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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(texto, style: const TextStyle(color: Colors.white, fontSize: 15),),
          ),
        ),
      ),
    );
  }
}