import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Define a simple data model to hold the lead information cleanly
class LeadItem {
  final String name;
  final String company;
  final double score;

  const LeadItem({
    required this.name,
    required this.company,
    required this.score,
  });
}

class LeadTab extends StatelessWidget {
  const LeadTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Mock data matching your exact screenshot names and scores
    final List<LeadItem> leads = [
      const LeadItem(name: 'Daniel Hook', company: 'Techno Craft', score: 9.5),
      const LeadItem(name: 'Jasan Mak', company: 'Jeson DH', score: 6.6),
      const LeadItem(name: 'Max Müller', company: 'Bringe IT', score: 9.7),
      const LeadItem(
        name: 'Cristina Neamtu',
        company: 'Nexus Corp',
        score: 8.9,
      ),
    ];

    return ListView.separated(
      shrinkWrap:
          true, // Crucial! Allows it to live inside your parent Dashboard Column safely
      physics:
          const NeverScrollableScrollPhysics(), // Let the main dashboard handle the outer scrolling
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      itemCount: leads.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 24), // Space between rows
      itemBuilder: (context, index) {
        final lead = leads[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side: The Profile Avatar
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E8F0), // Soft background for the avatar
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 32,
                color: Color(0xFF1E293B), // Dark silhouette matching your image
              ),
            ),

            const SizedBox(width: 16), // Space between avatar and text
            // Middle Column: Name and Company
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    lead.name,
                    style: GoogleFonts.kurale(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lead.company,
                    style: GoogleFonts.kurale(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Right Side: The Green Score Indicator
            Text(
              '${lead.score} Score',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(
                  0xFF25DB61,
                ), // Bright vibrant green matching the image
              ),
            ),
          ],
        );
      },
    );
  }
}
