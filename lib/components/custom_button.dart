import 'package:flutter/material.dart';

class CustomLabelledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color color;
  final Color? labelColor;

  // ignore: use_key_in_widget_constructors
  const CustomLabelledButton(
      {required this.label, required this.onPressed, required this.color, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return color.withOpacity(0.85);
          } else {
            return color;
          }
        }),
        fixedSize: MaterialStateProperty.all(const Size(190, 52)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0))),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: labelColor ?? Colors.white),
      ),
    );
  }
}
