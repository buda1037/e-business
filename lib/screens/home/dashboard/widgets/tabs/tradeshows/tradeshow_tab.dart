import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:leaddesk/state/state.dart';

class TradeshowTab extends StatelessWidget {
  const TradeshowTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.dashboardLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final items = state.tradeShowData;

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No tradeshow data yet',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final item = items[index];
        final initials = item.tradeShow.name
            .split(' ')
            .map((w) => w.isNotEmpty ? w[0] : '')
            .take(2)
            .join()
            .toUpperCase();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF4A148C),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.tradeShow.name,
                    style: GoogleFonts.kurale(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.year}',
                    style: GoogleFonts.kurale(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.leadCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.conversionRate.toStringAsFixed(1)}% Conv.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF25DB61),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
