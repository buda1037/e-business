import 'package:flutter/material.dart';

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 190,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1372F0), Color(0xFF6FADFF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xAA6FADFF), Color(0xAAFFFFFF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
