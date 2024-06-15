import 'package:flutter/material.dart';

class ColorsThemeText {
      static const blanco = "blanco";
      static const negro = "negro";
      static const azul = "azul";
      static const estandar = "estandar";
    
      static const _colorMap = {
        blanco: Colors.white,
        negro: Colors.black,
        azul: Colors.blue,
        estandar: Colors.yellow,
      };
    
      const ColorsThemeText._();
    
      static getColorFor(String color) => _colorMap[color.toLowerCase()] ?? _colorMap[estandar];
}