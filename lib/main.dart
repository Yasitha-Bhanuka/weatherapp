import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/services/weather_services.dart';
import 'package:weatherapp/widget/weather_data_tile.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/models/cities_model.dart';

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
  @override
  void initState() {
    _checkLocationPermissoin();
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherData;

  getData(String cityName) async {
    final weatherService = WeatherService();
    Map<String, dynamic> data;
    if (cityName.isEmpty) {
      data = await weatherService.fetchWeather();
    } else {
      data = await weatherService.getWeather(cityName);
    }

    setState(() {
      _weatherData = WeatherModel.fromJson(data);
    });
  }

  Future<bool> _checkLocationPermissoin() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      getData('');
    }
    getData('');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            _weatherData!.bgImg,
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
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return CitiesModel.suggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _controller.text = selection;
                      getData(selection);
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onSubmitted: (value) {
                          onFieldSubmitted();
                          getData(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter City Name',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        _weatherData!.cityName,
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
                      '${_weatherData!.formattedTemperature}°c',
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
                        _weatherData!.main,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      Image.asset(
                        _weatherData!.iconImg,
                        height: 80,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(children: [
                    Icon(Icons.arrow_upward),
                    Text(_weatherData!.formattedTempMax,
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.italic)),
                    Icon(Icons.arrow_downward),
                    Text(_weatherData!.formattedTempMin,
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.italic))
                  ]),
                  SizedBox(height: 25),
                  Card(
                    elevation: 5,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(children: [
                        WeatherDataTile(
                          index1: 'Sunrise',
                          index2: 'Sunset',
                          value1: _weatherData!.sunrise,
                          value2: _weatherData!.sunset,
                        ),
                        WeatherDataTile(
                          index1: 'Humidity',
                          index2: 'Wind',
                          value1: _weatherData!.formattedHumidity,
                          value2: _weatherData!.formattedWindSpeed,
                        ),
                        WeatherDataTile(
                          index1: 'Pressure',
                          index2: 'Visibility',
                          value1: _weatherData!.formattedPressure,
                          value2: _weatherData!.formattedVisibility,
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
