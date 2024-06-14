import 'package:flutter/material.dart';


const colorList = <Color>[

  Colors.blue,
  Colors.amber,
  Colors.cyan,
  Colors.deepOrange,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.pink,
  Colors.purple,

];


class AppTheme {

  final bool isDarkmode;
  final int selectedColor;

  AppTheme({
    this.isDarkmode = false,
    this.selectedColor = 0
  }): assert (selectedColor >= 0, 'El color debe ser mayor a 0 ',),
      assert (selectedColor < colorList.length, 'El color debe ser menor a ${colorList.length - 1} ',);

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkmode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    )
    
  );

}