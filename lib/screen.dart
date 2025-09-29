import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// 🔹 Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WeatherHomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2980B9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.cloud, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Weather App",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Stay updated with the sky",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Home Page
class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> cityWeather = [
    {"city": "Puducherry", "temp": "30°", "status": "Sunny"},
    {"city": "Madurai", "temp": "28°", "status": "Cloudy"},
    {"city": "Chennai", "temp": "32°", "status": "Rainy"},
    {"city": "Bangalore", "temp": "27°", "status": "Thunder"},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemCount: cityWeather.length,
        itemBuilder: (context, index) {
          final cityData = cityWeather[index];
          return WeatherPage(
            city: cityData["city"]!,
            temp: cityData["temp"]!,
            status: cityData["status"]!,
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cityWeather.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: _currentIndex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔹 Weather Page with scrollable content
class WeatherPage extends StatelessWidget {
  final String city;
  final String temp;
  final String status;

  const WeatherPage({
    super.key,
    required this.city,
    required this.temp,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6DD5FA), Color(0xFF2980B9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView( // 👈 scrollable
          child: Column(
            children: [
              const SizedBox(height: 20),

              // City Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.white),
                  Text(
                    city,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Temp + Status
              Text(
                temp,
                style: const TextStyle(
                    fontSize: 90,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "It's $status",
                style: const TextStyle(fontSize: 22, color: Colors.white70),
              ),

              const SizedBox(height: 40),

              // 🔹 Weekly Graph
              WeeklyWeatherGraph(
                pastWeekTemps: [29, 30, 28, 31, 32, 30, 29],
              ),

              const SizedBox(height: 30),

              // Dummy Hourly Forecast
              Container(
                margin: const EdgeInsets.all(20),
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
                  children: const [
                    Text("Weather Today",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherHour(
                            time: "06:00 AM",
                            temp: "20°",
                            icon: Icons.wb_sunny),
                        WeatherHour(
                            time: "09:00 AM",
                            temp: "22°",
                            icon: Icons.cloud),
                        WeatherHour(
                            time: "12:00 PM",
                            temp: "25°",
                            icon: Icons.water_drop),
                        WeatherHour(
                            time: "03:00 PM",
                            temp: "23°",
                            icon: Icons.wb_sunny),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Hourly Forecast Widget
class WeatherHour extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const WeatherHour(
      {super.key, required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.orange),
        const SizedBox(height: 8),
        Text(time, style: const TextStyle(color: Colors.black54, fontSize: 14)),
        const SizedBox(height: 6),
        Text(temp,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// 🔹 Weekly Graph Widget
class WeeklyWeatherGraph extends StatelessWidget {
  final List<double> pastWeekTemps;

  const WeeklyWeatherGraph({super.key, required this.pastWeekTemps});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("📈 Past 7 Days Temperature",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: pastWeekTemps.reduce((a, b) => a < b ? a : b) - 2,
                  maxY: pastWeekTemps.reduce((a, b) => a > b ? a : b) + 2,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = [
                            "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text("");
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: pastWeekTemps.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
