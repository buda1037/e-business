import 'package:flutter/material.dart';
import 'package:leaddesk/styles/colors.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;

  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.label,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: maxLines > 1 ? 12 : 0,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: maxLines > 1 ? maxLines : null,
            style: const TextStyle(fontSize: 14, color: AppColors.label),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.subtle, fontSize: 14),
              border: InputBorder.none,
              isDense: true,
              contentPadding: maxLines > 1
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
        ),
      ],
    );
  }
}
