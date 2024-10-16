import 'package:flutter/material.dart';

const colorList = <Color>[

  

  Colors.blue,
  Colors.white,
  Colors.amber,
  Colors.cyan,
  Colors.deepOrange,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.pink,
  Colors.purple,
  Colors.yellow,
  

];

const colorBackground = <Color>[
  Color.fromRGBO(6, 20, 68, 1),
  Color.fromARGB(255, 22, 113, 170),
  Color.fromARGB(255, 255, 196, 0)
];


class AppTheme {


  final bool isDarkmode;
  final int selectedColor;


  AppTheme({
    this.isDarkmode = false,
    this.selectedColor = 1
  }): assert (selectedColor >= 0, 'El color debe ser mayor a 0 ',),
      assert (selectedColor < colorList.length, 'El color debe ser menor a ${colorList.length - 1} ',);

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: AppBarTheme(
      backgroundColor: colorBackground[1],
      centerTitle: true
    ),
    scaffoldBackgroundColor: colorBackground[selectedColor],
    
    
  );


}