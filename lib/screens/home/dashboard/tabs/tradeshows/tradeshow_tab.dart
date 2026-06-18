import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. Data model to manage the tradeshow layout dynamically
class TradeshowItem {
  final String title;
  final String year;
  final int count;
  final String conversions;
  final bool isTrendUp; // True for green up-arrow, false for orange down-arrow
  final Widget logo;    // A placeholder container for the logos in this demo

  const TradeshowItem({
    required this.title,
    required this.year,
    required this.count,
    required this.conversions,
    required this.isTrendUp,
    required this.logo,
  });
}

class TradeshowTab extends StatelessWidget {
  const TradeshowTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Mocking the exact data matching your 2026/2025 screenshot
    final List<TradeshowItem> tradeshows = [
      TradeshowItem(
        title: 'Cloud Fest',
        year: '2026',
        count: 132,
        conversions: '1,756 Conv.',
        isTrendUp: true,
        logo: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4A148C), // Deep Purple
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text('CF', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
      TradeshowItem(
        title: 'EuroShop',
        year: '2026',
        count: 24,
        conversions: '2,726 Conv.',
        isTrendUp: false,
        logo: Center(
          child: Image.network(
            'https://pub.dev/static/img/flutter-logo.png', // Fallback placeholder or use an asset icon
            errorBuilder: (c, e, s) => const Icon(Icons.star, color: Colors.red, size: 28),
          ),
        ),
      ),
      TradeshowItem(
        title: 'Cloud Fest',
        year: '2025',
        count: 132,
        conversions: '3,453 Conv.',
        isTrendUp: false,
        logo: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4A148C),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text('CF', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
      TradeshowItem(
        title: 'EuroShop',
        year: '2025',
        count: 24,
        conversions: '2,456 Conv.',
        isTrendUp: true,
        logo: const Icon(Icons.star, color: Colors.red, size: 28),
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Flows perfectly within your main Dashboard Column
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      itemCount: tradeshows.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final item = tradeshows[index];
        
        // Colors mapping directly to the mockup visuals
        final trendColor = item.isTrendUp ? const Color(0xFF25DB61) : const Color(0xFFDB5225);
        final trendIcon = item.isTrendUp ? Icons.trending_up : Icons.trending_down;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side: Rounded Square Logo Container
            SizedBox(
              width: 52,
              height: 52,
              child: item.logo,
            ),
            
            const SizedBox(width: 16),
            
            // Middle Column: Title & Year
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.kurale(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.year,
                    style: GoogleFonts.kurale(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Right Column: Counts & Conversion Trends
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.count}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(trendIcon, size: 16, color: trendColor),
                    const SizedBox(width: 4),
                    Text(
                      item.conversions,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: trendColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
