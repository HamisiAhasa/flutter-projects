import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '1ba3f1c2edcbb371836278b430aca91b';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
