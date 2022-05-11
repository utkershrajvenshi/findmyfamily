import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  final String titleText;
  const CustomTitleText({
    Key? key,
    required this.titleText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}
