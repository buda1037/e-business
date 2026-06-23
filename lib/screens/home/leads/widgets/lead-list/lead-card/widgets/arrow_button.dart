import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}
