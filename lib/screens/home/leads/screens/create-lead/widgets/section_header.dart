import 'package:flutter/material.dart';
import 'package:leaddesk/styles/colors.dart';

class SectionHeader extends StatelessWidget {
  final Color color;
  final String label;

  const SectionHeader({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.label,
          ),
        ),
      ],
    );
  }
}
