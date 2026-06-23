import 'package:flutter/material.dart';

class WaveTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double waveDepth = 8.0;
    const double radius = 20.0;

    final path = Path();

    path.moveTo(radius, 0);

    final double midX = size.width / 2;
    path.cubicTo(midX * 0.35, 0, midX * 0.35, waveDepth, midX, waveDepth);
    path.cubicTo(
      midX + midX * 0.35,
      waveDepth,
      midX + midX * 0.35,
      0,
      size.width - radius,
      0,
    );

    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );

    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: const Radius.circular(radius),
    );

    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );

    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveTopClipper old) => false;
}
