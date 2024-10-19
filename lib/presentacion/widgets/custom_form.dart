import 'package:esun/config/config.dart';
import 'package:esun/config/theme/colors_theme.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? label;
  final bool? obscureText;
  final String? color;
  final String? hint;
  final String? errorMsg;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  const CustomFormField({
    super.key,
    this.label,
    this.obscureText = false,
    this.color,
    this.hint,
    this.errorMsg,
    this.onChanged,
    this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40),
    );

    const borderRadius = Radius.circular(40);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              topRight: borderRadius,
              bottomRight: borderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextFormField(
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText ?? false,
            style: TextStyle(
              color: ColorsThemeText.getColorFor(color ?? 'negro'),
              fontSize: 20,
            ),
            decoration: InputDecoration(
              border: border,
              focusedBorder: border,
              isDense: true,
              labelStyle: const TextStyle(color: Colors.black),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              focusColor: colors.primary,
              prefixIcon: prefixIcon,
              errorText: null,
              errorBorder: border.copyWith(
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        // Mostrar el mensaje de error si existe
        if (errorMsg != null && errorMsg!.isNotEmpty) ...[
          const SizedBox(height: 4), // Espacio entre el campo y el mensaje de error
          Text(
            errorMsg!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}