import 'package:flutter/material.dart';

class IndicatorDots extends StatelessWidget {
  final Color color;
  const IndicatorDots({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    const double r = 18;
    const double overlap = 10;
    const double totalW = r * 2 - overlap;

    return SizedBox(
      width: totalW,
      height: r,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: r,
              height: r,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.28),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: totalW - r,
            child: Container(
              width: r,
              height: r,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
