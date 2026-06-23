import 'package:flutter/material.dart';
import 'package:leaddesk/helpers/snackbar_helper.dart';
import 'package:leaddesk/state/state.dart';
import 'package:provider/provider.dart';
import 'package:leaddesk/screens/home/leads/widgets/header/lead_page_header_button.dart';
import 'package:leaddesk/screens/home/leads/screens/create-lead/create_lead_screen.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadPageHeader extends StatelessWidget {
  const LeadPageHeader({super.key});

  Future<void> _handleNewLead(BuildContext context) async {
    final appState = context.read<AppState>();

    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CreateLeadScreen(database: appState.database),
      ),
    );

    if (created == true) {
      appState.loadAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'All leads',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.label,
              letterSpacing: -0.3,
              height: 1.1,
            ),
          ),
        ),
        LeadPageHeaderButton(
          icon: Icons.arrow_upward_rounded,
          onTap: () => showNotImplementedSnackBar(context),
        ),
        const SizedBox(width: 8),
        LeadPageHeaderButton(
          icon: Icons.add,
          // 2. Call our local function that uses the context directly
          onTap: () => _handleNewLead(context),
        ),
      ],
    );
  }
}
