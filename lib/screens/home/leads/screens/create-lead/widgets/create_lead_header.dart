import 'package:flutter/material.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/widgets/circle_icon_button.dart';
import 'package:leaddesk/styles/colors.dart';

class CreateLeadHeader extends StatelessWidget {
  final VoidCallback onBack;

  const CreateLeadHeader({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(icon: Icons.arrow_back, onTap: onBack),
        const Expanded(
          child: Center(
            child: Text(
              'Create new Lead',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.label,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }
}
