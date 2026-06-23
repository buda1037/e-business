import 'package:flutter/material.dart';
import 'package:leaddesk/screens/home/leads/widgets/filters/lead_page_filter_row.dart';
import 'package:leaddesk/screens/home/leads/widgets/header/lead_page_header.dart';
import 'package:leaddesk/screens/home/leads/widgets/lead-list/lead_page_lead_list.dart';
import 'package:leaddesk/screens/home/leads/widgets/search-bar/lead_page_search_bar.dart';
import 'package:leaddesk/screens/home/leads/widgets/status-row/lead_page_status_row.dart';
import 'package:leaddesk/screens/home/leads/widgets/search-bar/lead_page_suggestions.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadsPage extends StatelessWidget {
  const LeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              LeadPageHeader(),
              const SizedBox(height: 14),
              LeadPageStatusRow(),
              const SizedBox(height: 14),
              LeadPageSearchBar(),
              LeadPageSuggestions(),
              const SizedBox(height: 12),
              LeadPageFilterRow(),
              const SizedBox(height: 16),
              Expanded(child: LeadPageLeadList()),
            ],
          ),
        ),
      ),
    );
  }
}
