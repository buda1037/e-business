import 'package:flutter/material.dart';

import 'package:leaddesk/screens/home/dashboard/widgets/app-bar/dashboard_app_bar.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/background/dashboard_background.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/status-bar/dashboard_status_bar.dart';
import 'package:leaddesk/screens/home/dashboard/widgets/tabs/dashboard_tabs.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DashboardBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: DashboardAppBar(),
          body: Column(
            children: [
              DashboardStatusBar(),
              Expanded(child: DashboardTabs()),
            ],
          ),
        ),
      ],
    );
  }
}
