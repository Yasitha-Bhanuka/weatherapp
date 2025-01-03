import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/services/weather_services.dart';
import 'package:weatherapp/widget/weather_data_tile.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/models/cities_model.dart';

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
    try {
      if (cityName.isEmpty) {
        data = await weatherService.fetchWeather();
      } else {
        data = await weatherService.getWeather(cityName);
      }

      setState(() {
        _weatherData = WeatherModel.fromJson(data);
      });
    } catch (e) {
      // Show a pop-up message when an error occurs
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The country name is not valid. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        FocusScope.of(context).unfocus();
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
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter City Name',
                            hintStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                getData(textEditingController.text);
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
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
      ),
    );
  }
}
