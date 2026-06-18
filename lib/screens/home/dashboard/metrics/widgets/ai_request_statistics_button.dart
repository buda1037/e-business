import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiRequestStatisticsButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final VoidCallback onPressed;

  const AiRequestStatisticsButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        fixedSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: icon,
      label: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E293B),
        ),
      ),
    );
  }
}
