import 'package:flutter/material.dart';

class CustomButtonImage extends StatelessWidget {

  final String name;
  final Function()? onTap;

  const CustomButtonImage({
    required this.name,
    this.onTap,
    super.key
   });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        color: colors.primary,
        child: InkWell(
          splashColor: Colors.amber.shade800,
          // focusColor: Colors.amber.shade800,
          // highlightColor: Colors.purpleAccent,
          // hoverColor: Colors.amberAccent,
          onTap: onTap,
          child: SizedBox(
            width: 50,
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Image.asset(name)
          ),
        ),
      ),
    );
  }
}