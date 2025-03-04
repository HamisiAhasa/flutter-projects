import 'package:flutter/material.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String temperature = "";
  String description = "";
  String icon = "";

  Future<void> fetchWeather() async {
    String city = _cityController.text.trim();
    if (city.isEmpty) return;

    final data = await WeatherService.fetchWeather(city);
    if (data != null) {
      setState(() {
        temperature = "${data['main']['temp']}°C";
        description = data['weather'][0]['description'];
        icon = data['weather'][0]['icon'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: "Enter City Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            if (temperature.isNotEmpty) ...[
              Text(
                temperature,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 20),
              ),
              Image.network('https://openweathermap.org/img/wn/$icon@2x.png'),
            ]
          ],
        ),
      ),
    );
  }
}
