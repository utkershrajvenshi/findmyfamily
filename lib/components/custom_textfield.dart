import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({ Key? key, required this.controller, required this.hintText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      controller: controller,
      textCapitalization: TextCapitalization.words,
      textAlign: TextAlign.center,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF939393)),
        filled: true,
        fillColor: const Color(0xFF464646),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    );
  }
}