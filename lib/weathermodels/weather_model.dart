class Weather{
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double windSpeed;
  final String mainCondition;
  final int dt;
  final int timeZone;

  Weather(
  {
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
    required this.mainCondition,
    required this.dt,
    required this.timeZone,
});
      factory Weather.fromJson(Map<String, dynamic> json){
        return Weather(
          cityName: json['name'],
          temperature: json['main']['temp'].toDouble(),
          feelsLike: json['main']['feels_like'].toDouble(),
          minTemp: json['main']['temp_min'].toDouble(),
          maxTemp: json['main']['temp_max'].toDouble(),
          humidity: json['main']['humidity'],
          windSpeed: json['wind']['speed'].toDouble(),
          mainCondition: json['weather'][0]['main'],
          dt: json['dt'],
          timeZone: json['timezone'],
        );
      }

}