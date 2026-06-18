import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:leaddesk/database/database.dart';
import 'package:leaddesk/screens/home/dashboard/dashboard_page.dart';
import 'package:leaddesk/screens/home/leads/leads_page.dart';
import 'package:leaddesk/screens/home/profile/profile_page.dart';
import 'package:leaddesk/screens/home/tradeshows/tradeshow_page.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const DashboardPage(),
      const TradeshowPage(),
      LeadsPage(database: widget.database),
      const ProfilePage(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.house),
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.calendar),
            icon: FaIcon(FontAwesomeIcons.calendar),
            label: 'Tradeshows',
          ),
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.bullhorn),
            icon: FaIcon(FontAwesomeIcons.bullhorn),
            label: 'Leads',
          ),
          NavigationDestination(
            selectedIcon: FaIcon(FontAwesomeIcons.user),
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
