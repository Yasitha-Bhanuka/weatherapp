import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/services/weather_services.dart';
import 'package:weatherapp/widget/weather_data_tile.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _Controller = TextEditingController();

  final TextEditingController _controller = TextEditingController();
  String _bgImg = 'assets/images/clear.jpg';
  String _iconImg = 'assets/icons/Clear.png';
  String _cityName = '';
  String _temperature = '';
  String _tempMax = '';
  String _tempMin = '';
  String _sunrise = '';
  String _sunset = '';
  String _main = '';
  String _presure = '';
  String _humidity = '';
  String _visibility = '';
  String _windSpeed = '';

  getData(String cityName) async {
    final weatherService = WeatherService();
    final weatherData = await weatherService.getWeather(cityName);

    debugPrint(weatherData.toString());
    setState(() {
      _cityName = weatherData['name'];
      _temperature = weatherData['main']['temp'].toStringAsFixed(1);
      _main = weatherData['weather'][0]['main'];
      _tempMax = weatherData['main']['temp_max'].toStringAsFixed(1);
      _tempMin = weatherData['main']['temp_min'].toStringAsFixed(1);
      _sunrise = DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
              weatherData['sys']['sunrise'] * 1000));
      _sunset = DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
              weatherData['sys']['sunset'] * 1000));
      _presure = weatherData['main']['pressure'].toString();
      _humidity = weatherData['main']['humidity'].toString();
      _visibility = weatherData['visibility'].toString();
      _windSpeed = weatherData['wind']['speed'].toString();
      if (_main == 'Clear') {
        _bgImg = 'assets/images/clear.jpg';
        _iconImg = 'assets/icons/Clear.png';
      } else if (_main == 'Clouds') {
        _bgImg = 'assets/images/clouds.jpg';
        _iconImg = 'assets/icons/Clouds.png';
      } else if (_main == 'Rain') {
        _bgImg = 'assets/images/rain.jpg';
        _iconImg = 'assets/icons/Rain.png';
      } else if (_main == 'Fog') {
        _bgImg = 'assets/images/fog.jpg';
        _iconImg = 'assets/icons/Haze.png';
      } else if (_main == 'Thunderstorm') {
        _bgImg = 'assets/images/thunderstorm.jpg';
        _iconImg = 'assets/icons/Thunderstorm.png';
      } else {
        _bgImg = 'assets/images/haze.jpg';
        _iconImg = 'assets/icons/Haze.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/haze.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                TextField(
                  controller: _controller,
                  onChanged: (value) {
                    getData(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    Text(
                      'Colombo',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "30.9°c",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Haze",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/Clear.png',
                      height: 80,
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(children: [
                  Icon(Icons.arrow_upward),
                  Text('35°c',
                      style:
                          TextStyle(fontSize: 22, fontStyle: FontStyle.italic)),
                  Icon(Icons.arrow_downward),
                  Text('25°c',
                      style:
                          TextStyle(fontSize: 22, fontStyle: FontStyle.italic))
                ]),
                SizedBox(height: 25),
                Card(
                  elevation: 5,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      WeatherDataTile(
                        // WeatherDataTile widget
                        index1: 'Sunshine',
                        index2: 'Sunset',
                        value1: '6:00 AM',
                        value2: '6:00 PM',
                      ),
                      WeatherDataTile(
                        // WeatherDataTile widget
                        index1: 'Humidity',
                        index2: 'Wind',
                        value1: '60%',
                        value2: '10 km/h',
                      ),
                      WeatherDataTile(
                        // WeatherDataTile widget
                        index1: 'Pressure',
                        index2: 'Visibility',
                        value1: '1000 hPa',
                        value2: '10 km',
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
