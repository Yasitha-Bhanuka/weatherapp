import 'package:flutter_dotenv/flutter_dotenv.dart';

class WheatherService {
  final String apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
}
