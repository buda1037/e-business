import 'package:flutter/material.dart';

import 'package:leaddesk/screens/splash/splash_screen.dart';
import 'package:leaddesk/screens/login/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Future<void> _splashDelay = Future.delayed(const Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeadDesk',
      home: FutureBuilder<void>(
        future: _splashDelay,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: snapshot.connectionState != ConnectionState.done
                ? const SplashScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
