

import 'package:flutter/material.dart';

class BottonList extends StatelessWidget {
  const BottonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: (){}, 
                child: SizedBox(
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset('assets/archivo.png')
                  ),
                )
              ),
              // child: Icon(Icons.more_vert_outlined)
            );
  }
}