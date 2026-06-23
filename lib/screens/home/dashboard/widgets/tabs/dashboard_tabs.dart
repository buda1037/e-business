import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/tabs/leads/lead_tab.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/tabs/overview/overview_tab.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/tabs/tradeshows/tradeshow_tab.dart';

class DashboardTabs extends StatefulWidget {
  const DashboardTabs({super.key});

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _tabs = [
    const OverviewTab(),
    const LeadTab(),
    const TradeshowTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
          child: Container(
            height: 37,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: const Color(0xFF4A4A4A),
              labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Leads'),
                Tab(text: 'Tradeshows'),
              ],
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(index: _tabController.index, children: _tabs),
        ),
      ],
    );
  }
}
