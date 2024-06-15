import 'package:esun/config/config.dart';
import 'package:esun/config/theme/colors_theme.dart';
import 'package:flutter/material.dart';


class CustomFormField extends StatelessWidget {

  // final color = 'blanco';


  final String? label;
  final bool? obscureText;
  final String? color;
  final String? hint;
  final String? errorMsg;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;



  const CustomFormField({
    super.key, 
    
    this.label, 
    this.obscureText,
    this.color,
    this.hint, 
    this.errorMsg, 
    this.onChanged, 
    this.validator
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide:  BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40),

    );




    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText == null ? false : obscureText!,
      style: TextStyle(color: ColorsThemeText.getColorFor(color == null ? 'yellow': color!)),
      decoration: InputDecoration(
        border: border,
        focusedBorder: border,

        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: Icon(Icons.account_box_outlined, color: colors.primary,),
        errorText: errorMsg,
      ),
    );
  }
}