import 'package:flutter/material.dart';
import '../styles/colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: kFieldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(prefixIcon, size: 18, color: kSubLabel),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 14, color: kLabel),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 14, color: kSubLabel),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: suffixIcon,
            ),
        ],
      ),
    );
  }
}
