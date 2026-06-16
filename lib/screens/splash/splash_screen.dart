import 'package:flutter/material.dart';

import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  final AppDatabase database;

  const SplashScreen({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(database: database),
        ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LeadDesk',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'One App. Every Tradeshow.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
