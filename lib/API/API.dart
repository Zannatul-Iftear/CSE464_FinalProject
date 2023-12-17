import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/weathermodels/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherService{
  static const Base_URL= 'https://api.openweathermap.org/data/2.5/weather';
 final String apiKey;
 WeatherService(this.apiKey);

 Future<Weather> getWeather(String cityName) async{
   final response = await http.get(Uri.parse('$Base_URL?q=$cityName&appid=$apiKey&units=metric'));
   
   if(response.statusCode == 200){
     return Weather.fromJson(jsonDecode(response.body));
   }
   else {
     throw Exception('Failed to load data');
   }
  }


  Future<String> getCurrentCity () async{

   // getting permission for locating the user

   LocationPermission permission = await Geolocator.checkPermission();
   if (permission== LocationPermission.denied)
     {
       permission = await Geolocator.requestPermission();
     }
   // Fetch the current location
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );

  // convert the location into something form the search box

    List<Placemark> placemarks =
        await placemarkFromCoordinates( position.latitude, position.longitude);


    // extract the city name from the json file
    String? city = placemarks[0].locality;
    return city ?? "";


  }
}