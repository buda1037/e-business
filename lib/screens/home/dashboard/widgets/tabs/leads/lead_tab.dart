import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:leaddesk/state/state.dart';
import 'package:leaddesk/styles/colors.dart';

class LeadTab extends StatelessWidget {
  const LeadTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.leadsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final leads = state.leads;

    if (leads.isEmpty) {
      return const Center(
        child: Text(
          'No leads yet',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      itemCount: leads.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final leadData = leads[index];
        final name =
            '${leadData.contact.firstName} ${leadData.contact.lastName}';
        final company = leadData.contact.company;
        final score = leadData.lead.score;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 32,
                color: AppColors.slate800,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.kurale(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: GoogleFonts.kurale(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${score.toStringAsFixed(1)} Score',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF25DB61),
              ),
            ),
          ],
        );
      },
    );
  }
}
