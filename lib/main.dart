import 'package:flutter/material.dart';
import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/database/seed_database.dart';
import 'package:leaddesk/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await DatabaseSeeder(database).seedIfNeeded();

  runApp(MainApp(database: database));
}

class MainApp extends StatelessWidget {
  final AppDatabase database;

  const MainApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen(database: database));
  }
}
