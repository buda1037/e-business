import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:leaddesk/helpers/snackbar_helper.dart';
import 'package:leaddesk/state/state.dart';
import 'package:leaddesk/styles/colors.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/status-bar/widgets/ai_request_statistics_button.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/status-bar/widgets/leads_clients_cr_card.dart';

class DashboardStatusBar extends StatelessWidget {
  const DashboardStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    final conversionRate = state.overallConversionRate.toStringAsFixed(0);
    final totalLeads = state.totalLeadCount.toString();
    final totalClients = state.convertedLeadCount.toString();

    return Padding(
      padding: EdgeInsetsGeometry.only(top: 25, right: 15, bottom: 0, left: 15),
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
                    "$conversionRate%",
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
                        state.dashboardLoading ? "..." : "Today",
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
                    onPressed: () => showNotImplementedSnackBar(context),
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
                icon: const Icon(Icons.tune, color: AppColors.slate800),
                text: "AI Request",
                onPressed: () => showNotImplementedSnackBar(context),
              ),
              AiRequestStatisticsButton(
                icon: const Icon(Icons.show_chart, color: AppColors.slate800),
                text: "Statistics",
                onPressed: () => showNotImplementedSnackBar(context),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: totalLeads,
                  keyFigureName: "Total Leads",
                  keyFigureChange: "-",
                ),
              ),
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: totalClients,
                  keyFigureName: "Total Clients",
                  keyFigureChange: "-",
                ),
              ),
              Expanded(
                child: LeadsClientsCrCards(
                  keyFigureValue: "$conversionRate%",
                  keyFigureName: "CR",
                  keyFigureChange: "-",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
