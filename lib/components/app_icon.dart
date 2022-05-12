import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double size;
  const AppIcon({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage("images/app_logo.png"),
      width: size,
      height: size,
      fit: BoxFit.scaleDown,
    );
  }
}
