import 'package:flutter/material.dart';

import '../theme/colors_theme.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function()? onPressedSuffixIcon;
  const TextFieldWidget({
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.onPressedSuffixIcon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsTheme.backgroundComponentColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: ColorsTheme.textColor),
          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
                  onPressed: onPressedSuffixIcon,
                  icon: Icon(suffixIcon, color: ColorsTheme.textColor)),
          hintText: hint,
          hintStyle: const TextStyle(color: ColorsTheme.textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 22),
        ),
        style: const TextStyle(
          color: ColorsTheme.textColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
