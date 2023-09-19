import 'package:flutter/material.dart';

import '../theme/colors_theme.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  const ButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorsTheme.highlightColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
              const Size(double.maxFinite, 64))),
      child: Text(text!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorsTheme.textColor,
          )),
    );
  }
}
