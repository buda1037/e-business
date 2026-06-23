import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:leaddesk/helpers/snackbar_helper.dart';
import 'package:leaddesk/screens/home/dashboard/dashboard_page.dart';
import 'package:leaddesk/screens/home/leads/lead_page.dart';
import 'package:leaddesk/screens/home/profile/profile_page.dart';
import 'package:leaddesk/screens/home/tradeshows/tradeshow_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      LeadsPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(
            0xFFF3EDFA,
          ), // Soft purple pill background
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFF6236E2), // Deep purple text
                fontWeight: FontWeight.bold,
              );
            }
            return const TextStyle(color: Colors.transparent);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: Color(0xFF6236E2),
              ); // Deep purple icon
            }
            return const IconThemeData(
              color: Color(0xFF9BB0C1),
            ); // Muted blue/grey icon
          }),
          height: 64,
        ),
        child: NavigationBar(
          // Corrected enum name:
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              if (index == 1 || index == 3) {
                showNotImplementedSnackBar(context);
                return;
              }
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: FaIcon(FontAwesomeIcons.houseUser),
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: FaIcon(FontAwesomeIcons.wallet),
              icon: FaIcon(FontAwesomeIcons.wallet),
              label: 'Tradeshows',
            ),
            NavigationDestination(
              selectedIcon: FaIcon(FontAwesomeIcons.chartPie),
              icon: FaIcon(FontAwesomeIcons.chartPie),
              label: 'Leads',
            ),
            NavigationDestination(
              selectedIcon: FaIcon(FontAwesomeIcons.user),
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: pages[currentPageIndex],
    );
  }
}
