import 'package:flutter/material.dart';
import '../styles/colors.dart';

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: kLabel,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
