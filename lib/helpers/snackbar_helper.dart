import 'package:flutter/material.dart';

void showNotImplementedSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Text('Oops! This feature is not implemented yet.'),
      ),
    );
}
