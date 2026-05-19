import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final bool pumpOn;
  final Function(bool) onPumpChanged;

  final String soil;
  final String temp;
  final String humidity;
  final String light;

  const HomePage({
    super.key,
    required this.pumpOn,
    required this.onPumpChanged,
    required this.soil,
    required this.temp,
    required this.humidity,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = "${now.day}/${now.month}/${now.year}";
    final time = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // 🔷 HEADER BOX (DATE + WEATHER)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100, // dim blue
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(today, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Smart Farm Dashboard",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // 🔹 SENSOR CARDS
          Row(
            children: [
              _card("Soil Moisture", soil, Icons.water_drop, Colors.green.shade100),
              const SizedBox(width: 10),
              _card("Temperature", temp, Icons.thermostat, Colors.blue.shade100),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              _card("Humidity", humidity, Icons.opacity, Colors.purple.shade100),
              const SizedBox(width: 10),
              _card("Light", light, Icons.wb_sunny, Colors.orange.shade100),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 WATER PUMP CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TITLE + ICON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Water Pump",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.water), // pump icon
                  ],
                ),

                const SizedBox(height: 10),

                // STATUS + SWITCH
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pumpOn ? "Status: ON" : "Status: OFF",
                      style: TextStyle(
                        color: pumpOn ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: pumpOn,
                      onChanged: onPumpChanged,
                      activeColor: Colors.green,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // RUNNING TEXT
                Text(
                  pumpOn ? "Pump is running" : "Pump is stopped",
                  style: TextStyle(
                    color: pumpOn ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 SENSOR CARD
  Widget _card(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 10),
            Text(title),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}