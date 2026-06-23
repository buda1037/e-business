import 'package:flutter/material.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const LeadPageFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.accent : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive ? AppColors.accent : const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 13,
              color: isActive ? AppColors.white : AppColors.subtle,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.white : AppColors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
