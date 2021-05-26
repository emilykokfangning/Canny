import 'package:Canny/Screens/Sidebar/sidebar_menu.dart';
import 'package:flutter/material.dart';
import 'package:Canny/Shared/colors.dart';

class DashboardScreen extends StatefulWidget {
  static final String id = 'dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDeepOrangePrimary,
        title: Text(
          "DASHBOARD",
          style: TextStyle(fontFamily: 'Lato'),
        ),
      ),
      drawer: SideBarMenu(),
      backgroundColor: kBackgroundColour,
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
