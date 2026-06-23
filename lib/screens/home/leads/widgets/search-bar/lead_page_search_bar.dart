import 'package:flutter/material.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageSearchBar extends StatelessWidget {
  const LeadPageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppState>();

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              controller: provider.searchController,
              onChanged: (input) => provider.loadSuggestions(input),
              onSubmitted: (_) =>
                  provider.selectSuggestion(provider.searchController.text),
              style: const TextStyle(fontSize: 14, color: AppColors.label),
              decoration: const InputDecoration(
                hintText: 'Type...',
                hintStyle: TextStyle(color: AppColors.subtle, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search, color: AppColors.subtle, size: 20),
          ),
        ],
      ),
    );
  }
}
