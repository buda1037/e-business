import 'package:flutter/material.dart';

class NotImplementedPage extends StatelessWidget {
  const NotImplementedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Oops! This page is not implemented yet.')),
      ),
    );
  }
}
