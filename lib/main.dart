import 'package:flutter/material.dart';
import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/database/seed_database.dart';
import 'package:leaddesk/state/state.dart';
import 'package:leaddesk/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await DatabaseSeeder(database).seedIfNeeded();

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (_) => AppState(database),
      child: MaterialApp(title: "LeadDesk", home: SplashScreen()),
    ),
  );
}
