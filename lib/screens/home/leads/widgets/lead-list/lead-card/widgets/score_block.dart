import 'package:flutter/material.dart';

class ScoreBlock extends StatelessWidget {
  final String intPart;
  final String decPart;
  const ScoreBlock({super.key, required this.intPart, required this.decPart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              intPart,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.0,
                letterSpacing: -1,
              ),
            ),
            Text(
              '.$decPart',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ],
        ),
        Positioned(
          top: -12,
          right: -28,
          child: Text(
            'Score',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.65),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}
