import 'package:flutter/material.dart';
import '../login/login_screen.dart';

// farben für den Splash Screen
const Color _kBg = Color(0xFFFFFFFF);
const Color _kPurple = Color(0xFF7C3AED);
const Color _kLabel = Color(0xFF1A1A2E);
const Color _kSubLabel = Color(0xFF9CA3AF);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);

    _scale = Tween<double>(
      begin: 0.88,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    // Animation direkt beim Öffnen starten
    _ctrl.forward();

    // Nach 2 Sekunden automatisch zur Login-Seite wechseln
    Future.delayed(const Duration(seconds: 2), _goToLogin);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // Öffnet nach dem Splash Screen die Login-Seite
  void _goToLogin() {
    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Kleines LeadDesk-Logo anzeigen
                  _LogoMark(),

                  const SizedBox(height: 16),

                  // Name der Anwendung
                  const Text(
                    'LeadDesk',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: _kLabel,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Kurzer Slogan unter dem Logo
                  const Text(
                    'One App. Every Tradeshow.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _kSubLabel,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Zeichnet das kleine Plus-Symbol des LeadDesk-Logos.
class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Größe der Balken des Plus-Symbols
    const double arm = 10.0;
    const double thick = 7.0;
    const double total = arm * 2 + thick;

    return SizedBox(
      width: total,
      height: total,
      child: CustomPaint(painter: _CrossPainter(color: _kPurple)),
    );
  }
}

class _CrossPainter extends CustomPainter {
  final Color color;

  const _CrossPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Halbe Balkenbreite für die Berechnung
    const ht = 3.5;

    // Waagerechter Balken
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(cx, cy),
          width: size.width,
          height: ht * 2,
        ),
        const Radius.circular(2),
      ),
      paint,
    );

    // Senkrechter Balken
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(cx, cy),
          width: ht * 2,
          height: size.height,
        ),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CrossPainter old) => old.color != color;
}
