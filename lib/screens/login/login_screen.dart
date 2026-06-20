import 'package:flutter/material.dart';

import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/screens/home/home_screen.dart';

// Farben für die Login-Seite
const Color _kBg = Color(0xFFF8F8FC);
const Color _kDarkBlue = Color(0xFF1E2D5A);
const Color _kLabel = Color(0xFF1A1A2E);
const Color _kSubLabel = Color(0xFF6B7280);
const Color _kBorder = Color(0xFFE0E0E8);
const Color _kFieldBg = Colors.white;
const Color _kLinkBlue = Color(0xFF4A90D9);

class LoginScreen extends StatefulWidget {
  final AppDatabase database;

  const LoginScreen({
    super.key,
    required this.database,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Prüft einfache Eingaben und öffnet danach die Startseite.
  void _onSignIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(database: widget.database),
      ),
    );
  }

  void _onFacebook() => debugPrint('TODO: Facebook login');
  void _onGoogle() => debugPrint('TODO: Google login');
  void _onInstagram() => debugPrint('TODO: Instagram login');
  void _onSignUp() => debugPrint('TODO: Navigate to Sign Up');
  void _onForgotPassword() => debugPrint('TODO: Navigate to Forgot Password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // Obere Illustration aus einfachen Flutter-Elementen
              _IllustrationBlock(),

              const SizedBox(height: 24),

              const Text(
                'Sign In To LeadDesk',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _kLabel,
                  letterSpacing: -0.3,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 28),

              _FieldLabel('Email Address'),
              const SizedBox(height: 7),
              _InputField(
                controller: _emailController,
                hint: 'princesskaguya@gmail.co',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              _FieldLabel('Password'),
              const SizedBox(height: 7),
              _InputField(
                controller: _passwordController,
                hint: 'Enter your password...',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: _kSubLabel,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              _SignInButton(onTap: _onSignIn),

              const SizedBox(height: 24),

              // Social Login ist erstmal nur vorbereitet.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialBtn(
                    icon: _FacebookIcon(),
                    onTap: _onFacebook,
                  ),
                  const SizedBox(width: 16),
                  _SocialBtn(
                    icon: _GoogleIcon(),
                    onTap: _onGoogle,
                  ),
                  const SizedBox(width: 16),
                  _SocialBtn(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: Color(0xFFE1306C),
                    ),
                    onTap: _onInstagram,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              GestureDetector(
                onTap: _onSignUp,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: _kSubLabel,
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: _kLinkBlue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: _kLinkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: _onForgotPassword,
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kLinkBlue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: _kLinkBlue,
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Label über den Eingabefeldern
class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _kLabel,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}

// Einheitliches Eingabefeld für E-Mail und Passwort
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: _kFieldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(prefixIcon, size: 18, color: _kSubLabel),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 14, color: _kLabel),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 14, color: _kSubLabel),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: suffixIcon,
            ),
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SignInButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: _kDarkBlue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _kDarkBlue.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const _SocialBtn({
    required this.icon,
    required this.onTap,
  });

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
          border: Border.all(color: _kBorder, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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

// Einfaches Facebook-Icon ohne zusätzliches Paket
class _FacebookIcon extends StatelessWidget {
  const _FacebookIcon();

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

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 20),
      painter: _GoogleGPainter(),
    );
  }
}

// Google-Icon wird hier grob aus farbigen Flächen nachgebaut.
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

    // Der weiße Kreis in der Mitte sorgt dafür, dass das Icon nicht vollflächig wirkt.
    paint.color = Colors.white;
    canvas.drawCircle(Offset(cx, cy), r * 0.62, paint);

    // Aussparung rechts, damit die Form eher wie ein G aussieht.
    canvas.drawRect(
      Rect.fromLTWH(cx, cy - r * 0.22, r * 1.05, r * 0.44),
      paint,
    );
  }

  @override
  bool shouldRepaint(_GoogleGPainter old) => false;
}

// Illustration oben auf der Login-Seite
class _IllustrationBlock extends StatelessWidget {
  const _IllustrationBlock();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 30,
            top: 10,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.45)
                ..rotateX(0.15),
              alignment: Alignment.center,
              child: _IsoPanelCard(
                width: 110,
                height: 130,
                color: const Color(0xFFB2EBF2),
                accentColor: const Color(0xFF00BCD4),
                rows: 5,
              ),
            ),
          ),
          Positioned(
            left: 28,
            top: 20,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(0.3)
                ..rotateX(0.1),
              alignment: Alignment.center,
              child: _IsoBarChart(
                width: 100,
                height: 120,
                bgColor: const Color(0xFFEDE7F6),
                barColors: const [
                  Color(0xFFAB47BC),
                  Color(0xFF7E57C2),
                  Color(0xFF5C6BC0),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.25)
                ..rotateX(-0.08),
              alignment: Alignment.center,
              child: _IsoPanelCard(
                width: 95,
                height: 110,
                color: const Color(0xFFE8EAF6),
                accentColor: const Color(0xFF7986CB),
                rows: 4,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 80,
            child: Icon(
              Icons.flutter_dash,
              size: 28,
              color: const Color(0xFF7C83FF).withOpacity(0.8),
            ),
          ),
          Positioned(
            top: 30,
            left: 50,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCA28),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 22,
            left: 62,
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7043),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Kleine Karten innerhalb der Illustration
class _IsoPanelCard extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color accentColor;
  final int rows;

  const _IsoPanelCard({
    required this.width,
    required this.height,
    required this.color,
    required this.accentColor,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: width * 0.5,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < rows; i++) ...[
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  height: 5,
                  width: width * 0.45 + (i.isEven ? 10 : 0),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            if (i < rows - 1) const SizedBox(height: 7),
          ],
        ],
      ),
    );
  }
}

// Balkendiagramm innerhalb der Illustration
class _IsoBarChart extends StatelessWidget {
  final double width;
  final double height;
  final Color bgColor;
  final List<Color> barColors;

  const _IsoBarChart({
    required this.width,
    required this.height,
    required this.bgColor,
    required this.barColors,
  });

  @override
  Widget build(BuildContext context) {
    final barHeights = [0.55, 0.85, 0.65, 0.45];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: barColors[1].withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 7,
            width: 40,
            decoration: BoxDecoration(
              color: barColors[1].withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(barColors.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: FractionallySizedBox(
                      heightFactor: barHeights[i],
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: barColors[i],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}