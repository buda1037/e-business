import 'package:flutter/material.dart';
import '../styles/colors.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: kBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: icon),
      ),
    );
  }
}

class FacebookIcon extends StatelessWidget {
  const FacebookIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          'f',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1877F2),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(20, 20), painter: _GoogleGPainter());
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -1.57,
      1.57,
      true,
      paint,
    );

    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0,
      1.57,
      true,
      paint,
    );

    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      1.57,
      1.57,
      true,
      paint,
    );

    paint.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      3.14,
      1.57,
      true,
      paint,
    );

    paint.color = Colors.white;
    canvas.drawCircle(Offset(cx, cy), r * 0.62, paint);

    canvas.drawRect(
      Rect.fromLTWH(cx, cy - r * 0.22, r * 1.05, r * 0.44),
      paint,
    );
  }

  @override
  bool shouldRepaint(_GoogleGPainter old) => false;
}
