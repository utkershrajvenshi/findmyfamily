import 'package:findmyfamily/components/app_icon.dart';
import 'package:flutter/material.dart';

class BaseTemplate extends StatelessWidget {
  final double? horizontalPadding;
  final List<Widget> childrenWidgets;
  const BaseTemplate(
      {Key? key, this.horizontalPadding, required this.childrenWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16.0, horizontal: horizontalPadding ?? 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ...[const AppIcon(size: 54)],
                for (var child in childrenWidgets)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: child,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
