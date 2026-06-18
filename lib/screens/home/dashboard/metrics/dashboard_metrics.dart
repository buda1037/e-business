import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:leaddesk/screens/home/dashboard/metrics/widgets/ai_request_statistics_button.dart';
import 'package:leaddesk/screens/home/dashboard/metrics/widgets/leads_clients_cr_card.dart';

class DashboardMetrics extends StatelessWidget {
  const DashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 25, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Conversion",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFC9DFFD),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "25%",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.white),
                      Text(
                        "+1.7%",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "This month",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC9DFFD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFC9DFFD),
                        width: 1.5,
                      ),
                      backgroundColor: const Color(0x55FFFFFF),
                      minimumSize: const Size(80, 30),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Month",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.content_copy, color: Colors.white),
                ],
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AiRequestStatisticsButton(
                icon: const Icon(Icons.tune, color: Color(0xFF1E293B)),
                text: "AI Request",
                onPressed: () {},
              ),
              AiRequestStatisticsButton(
                icon: const Icon(Icons.show_chart, color: Color(0xFF1E293B)),
                text: "Statistics",
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: "23",
                  keyFigureName: "Total Leads",
                  keyFigureChange: "1.3%",
                ),
              ),
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: "6",
                  keyFigureName: "Total Clients",
                  keyFigureChange: "1.8%",
                ),
              ),
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: "26%",
                  keyFigureName: "CR",
                  keyFigureChange: "4.5%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
