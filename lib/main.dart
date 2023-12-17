import 'package:flutter/material.dart';
import 'package:weatherapp/pages/weather_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/pages/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeolocatorPlatform.instance.isLocationServiceEnabled();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(searchedCity: "dhaka"),
    );
  }
}