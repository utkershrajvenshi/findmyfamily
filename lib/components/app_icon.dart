import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double width;
  final double height;
  const AppIcon({ Key? key, required this.height, required this.width }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/app_logo.png"),
          fit: BoxFit.scaleDown
        )
      ),
    );
  }
}