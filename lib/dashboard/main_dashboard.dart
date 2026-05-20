import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const DashboardPage(),
    );
  }
}