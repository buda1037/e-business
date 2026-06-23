import 'package:flutter/material.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageStatusRow extends StatelessWidget {
  const LeadPageStatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.yellow,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'Converted',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.label,
          ),
        ),
        const Spacer(),
        Text(
          '${state.convertedLeadCount} leads',
          style: const TextStyle(fontSize: 13, color: AppColors.subtle),
        ),
      ],
    );
  }
}
