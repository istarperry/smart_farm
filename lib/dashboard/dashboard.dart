import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

@override
State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final WebViewController controller;

@override
void initState() {     super.initState();

controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(
    Uri.parse('192.168.137.69'),
  );
}

@override
Widget build(BuildContext context) {     return Scaffold(       appBar: AppBar(         title: const Text("Smart Farm Dashboard"),
),
  body: WebViewWidget(controller: controller),
);
}
}
