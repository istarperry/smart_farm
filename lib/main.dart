import 'package:flutter/material.dart';
import 'screen/signup.dart';

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // START APP HERE
      home: const SignUpPage(),

      // OPTIONAL ROUTES (for future navigation)
      routes: {
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}