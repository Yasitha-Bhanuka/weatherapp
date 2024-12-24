import 'package:flutter/material.dart';
import 'package:weatherapp/widget/weather_data_tile.dart';

void main() {
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
