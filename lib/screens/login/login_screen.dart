import 'package:flutter/material.dart';

import 'package:leaddesk/helpers/snackbar_helper.dart';
import 'package:leaddesk/screens/home/home_screen.dart';
import 'package:leaddesk/screens/login/widgets/field_label.dart';
import 'package:leaddesk/screens/login/widgets/illustration_block.dart';
import 'package:leaddesk/screens/login/widgets/input_field.dart';
import 'package:leaddesk/screens/login/styles/colors.dart';
import 'package:leaddesk/screens/login/widgets/sign_in_button.dart';
import 'package:leaddesk/screens/login/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _onFacebook() => showNotImplementedSnackBar(context);
  void _onGoogle() => showNotImplementedSnackBar(context);
  void _onInstagram() => showNotImplementedSnackBar(context);
  void _onSignUp() => showNotImplementedSnackBar(context);
  void _onForgotPassword() => showNotImplementedSnackBar(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              const IllustrationBlock(),

              const SizedBox(height: 24),

              const Text(
                'Sign In To LeadDesk',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: kLabel,
                  letterSpacing: -0.3,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 28),

              const FieldLabel('Email Address'),
              const SizedBox(height: 7),
              InputField(
                controller: _emailController,
                hint: 'princesskaguya@gmail.co',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              const FieldLabel('Password'),
              const SizedBox(height: 7),
              InputField(
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
                    color: kSubLabel,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SignInButton(onTap: _onSignIn),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(icon: const FacebookIcon(), onTap: _onFacebook),
                  const SizedBox(width: 16),
                  SocialButton(icon: const GoogleIcon(), onTap: _onGoogle),
                  const SizedBox(width: 16),
                  SocialButton(
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
                    style: const TextStyle(fontSize: 13, color: kSubLabel),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: kLinkBlue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: kLinkBlue,
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
                    color: kLinkBlue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: kLinkBlue,
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
