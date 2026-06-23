import 'package:flutter/material.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/screens/home/leads/widgets/filters/lead_page_filter_chip.dart';

class LeadPageFilterRow extends StatelessWidget {
  const LeadPageFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Row(
      children: [
        LeadPageFilterChip(
          label: 'Company',
          isActive: state.companyFilterActive,
          onTap: () => state.toggleCompanyFilter(),
        ),
        const SizedBox(width: 8),
        LeadPageFilterChip(
          label: 'Tradeshow',
          isActive: state.tradeshowFilterActive,
          onTap: () => state.toggleTradeshowFilter(),
        ),
      ],
    );
  }
}
