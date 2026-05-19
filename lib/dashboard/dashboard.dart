import 'package:flutter/material.dart';

import 'home.dart';
import 'history.dart';
import 'alerts.dart';
import 'settings.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int index = 0;
  bool pumpOn = false;

  // 🔌 TEMP DATA (replace with Arduino later)
  String soil = "65%";
  String temp = "28°C";
  String humidity = "70%";
  String light = "Good";

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        pumpOn: pumpOn,
        onPumpChanged: (val) {
          setState(() => pumpOn = val);
        },
        soil: soil,
        temp: temp,
        humidity: humidity,
        light: light,
      ),
      const HistoryPage(),
      const AlertsPage(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}