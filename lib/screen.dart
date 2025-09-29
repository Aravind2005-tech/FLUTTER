import 'package:flutter/material.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6DD5FA),
              Color(0xFF2980B9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 Top bar with location + menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          "Tuscany",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 Temperature + Weather status
              Column(
                children: const [
                  Text(
                    "23°",
                    style: TextStyle(
                      fontSize: 90,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "It's Sunny",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // 🔹 Bottom card with hourly forecast
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Weather Today",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Forecast row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        WeatherHour(time: "05:00 AM", temp: "23°", icon: Icons.wb_sunny),
                        WeatherHour(time: "06:00 AM", temp: "16°", icon: Icons.cloud),
                        WeatherHour(time: "07:00 AM", temp: "3°", icon: Icons.water_drop),
                        WeatherHour(time: "08:00 AM", temp: "23°", icon: Icons.wb_sunny),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherHour extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const WeatherHour({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.orange),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Text(
          temp,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
