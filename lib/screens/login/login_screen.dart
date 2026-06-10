import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:leaddesk/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/login.png'),
              Text(
                'Sign In to LeadDesk',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF182D53),
                ),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Email Address'),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              FilledButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                ),
                child: const Text('Sign In'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () =>
                        _notImplemented(context, 'Facebook Sign In'),
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                  ),
                  IconButton(
                    onPressed: () => _notImplemented(context, 'Google Sign In'),
                    icon: const FaIcon(FontAwesomeIcons.google),
                  ),
                  IconButton(
                    onPressed: () =>
                        _notImplemented(context, 'Instagram Sign In'),
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _notImplemented(context, 'Sign Up'),
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              GestureDetector(
                onTap: () => _notImplemented(context, 'Forgot Password'),
                child: Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _notImplemented(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Oops! $featureName is not implemented yet.')),
      );
  }
}
