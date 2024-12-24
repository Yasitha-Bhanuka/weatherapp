import 'package:intl/intl.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final double tempMax;
  final double tempMin;
  final String sunrise;
  final String sunset;
  final String main;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  String bgImg;
  String iconImg;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.sunset,
    required this.main,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
  })  : bgImg = 'assets/images/default.jpg', // Default value
        iconImg = 'assets/icons/default.png' {
    // Default value
    _setImages();
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15,
      tempMax: json['main']['temp_max'] - 273.15,
      tempMin: json['main']['temp_min'] - 273.15,
      sunrise: DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000)),
      sunset: DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)),
      main: json['weather'][0]['main'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }

  void _setImages() {
    switch (main) {
      case 'Clear':
        bgImg = 'assets/images/clear.jpg';
        iconImg = 'assets/icons/Clear.png';
        break;
      case 'Clouds':
        bgImg = 'assets/images/clouds.jpg';
        iconImg = 'assets/icons/Clouds.png';
        break;
      case 'Rain':
        bgImg = 'assets/images/rain.jpg';
        iconImg = 'assets/icons/Rain.png';
        break;
      case 'Fog':
        bgImg = 'assets/images/fog.jpg';
        iconImg = 'assets/icons/Haze.png';
        break;
      case 'Thunderstorm':
        bgImg = 'assets/images/thunderstorm.jpg';
        iconImg = 'assets/icons/Thunderstorm.png';
        break;
      default:
        bgImg = 'assets/images/haze.jpg';
        iconImg = 'assets/icons/Haze.png';
    }
  }

  String get formattedTemperature => temperature.toStringAsFixed(2);
  String get formattedTempMax => tempMax.toStringAsFixed(2);
  String get formattedTempMin => tempMin.toStringAsFixed(2);
  String get formattedHumidity => '$humidity%';
  String get formattedWindSpeed => '${windSpeed.toStringAsFixed(1)} km/h';
  String get formattedPressure => '$pressure hPa';
  String get formattedVisibility =>
      '${(visibility / 1000).toStringAsFixed(1)} km';
}
