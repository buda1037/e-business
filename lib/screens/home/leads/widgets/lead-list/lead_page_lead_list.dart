import 'package:flutter/material.dart';
import 'package:leaddesk/helpers/snackbar_helper.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/screens/home/leads/widgets/lead-list/lead-card/lead_page_lead_card.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageLeadList extends StatelessWidget {
  const LeadPageLeadList({super.key});

  void _onLeadTap(BuildContext context, LeadCardData leadData) {
    showNotImplementedSnackBar(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.leadsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.leads.isEmpty) {
      return const Center(
        child: Text(
          'No leads found',
          style: TextStyle(fontSize: 14, color: AppColors.subtle),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: state.leads.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, i) => LeadPageLeadCard(
        leadData: state.leads[i],
        onTap: () => _onLeadTap(context, state.leads[i]),
      ),
    );
  }
}
