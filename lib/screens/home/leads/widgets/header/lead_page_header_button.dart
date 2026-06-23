import 'package:flutter/material.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageHeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const LeadPageHeaderButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 17, color: AppColors.label),
      ),
    );
  }
}
