import 'package:flutter/material.dart';

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
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
