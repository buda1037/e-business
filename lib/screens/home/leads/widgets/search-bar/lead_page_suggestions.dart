import 'package:flutter/material.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageSuggestions extends StatelessWidget {
  const LeadPageSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: state.suggestions.map((suggestion) {
          return ListTile(
            dense: true,
            title: Text(
              suggestion,
              style: const TextStyle(fontSize: 14, color: AppColors.label),
            ),
            onTap: () => state.selectSuggestion(suggestion),
          );
        }).toList(),
      ),
    );
  }
}
