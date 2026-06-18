import 'package:flutter/material.dart';

import 'package:leaddesk/screens/home/dashboard/app-bar/dashboard_app_bar.dart';
import 'package:leaddesk/screens/home/dashboard/background/dashboard_background.dart';
import 'package:leaddesk/screens/home/dashboard/metrics/dashboard_metrics.dart';
import 'package:leaddesk/screens/home/dashboard/tabs/dashboard_tabs.dart';

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
              DashboardMetrics(),
              DashboardTabs()
            ],
          ),
        ),
      ],
    );
  }
}
