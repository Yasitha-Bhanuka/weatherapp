import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WheatherService {
  final String apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

  Future<Map<String, dynamic>> getWeather(String cityName) async {
    // Fetch weather data from API
    final response = await http.get(Uri.parse(
        'api.openweathermap.org/data/2.5/weather?q=$cityName,uk&APPID=$apiKey'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server returns an error response, then throw an exception.
      throw Exception('Failed to load weather data');
    }
  }
}
