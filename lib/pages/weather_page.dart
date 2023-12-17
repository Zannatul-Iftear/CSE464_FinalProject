import 'package:flutter/material.dart';
import 'package:weatherapp/API/API.dart';
import 'package:lottie/lottie.dart';
import '../weathermodels/weather_model.dart';
import '../pages/search_page.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatefulWidget {
  final String searchedCity;
  const WeatherPage({Key? key, required this.searchedCity}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState(searchedCity: searchedCity);
}

class _WeatherPageState extends State<WeatherPage> {
  final String searchedCity;
  //List<AssetImage> loadBackgroundImg = [AssetImage('assets/img/weatherBG1A_sunnyDay.png'), AssetImage('assets/img/weatherBG2A_cloudyDay.png'), AssetImage('assets/img/weatherBG3A_rainyDay.png'), AssetImage('assets/img/weatherBG4A_stormyDay.png')];
  String backgroundImg = 'assets/img/loadingBG.png';
  String leftButtonImg = "assets/img/buttonLeft_0B.png";
  String rightButtonImg = "assets/img/buttonRight_0B.png";
  int uiColor = 0x00000000;
  int detailsColor = 0x00000000;
  String formattedDateTime = "";
  double currentHour = 0.0;
  String timeOfDay = "";

  _WeatherPageState({required this.searchedCity});
  /// API key here
  
  final _weatherService = WeatherService('1533d3154835d4d1e158446f956c6093');
  Weather? _weather;
    /// Fetch Weather code

  _fetchWeather(String searchedCity) async{
    String cityName;
  if(searchedCity == ""){
    cityName = await _weatherService.getCurrentCity();
  }
  else {cityName=searchedCity;}

  ///get weather for searched city
  try{
    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather= weather;
      detailsColor = 0xffffffff;

      // Calculating current hour of search result
      if (_weather?.dt != null) {
        final int dt = _weather!.dt!; // Use non-nullable type
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
        formattedDateTime = "${dateTime.toLocal()}";
        formattedDateTime = formattedDateTime.substring(11, 13);
        currentHour = double.parse(formattedDateTime);
        print(currentHour);
        currentHour *= 3600;    //15
        double localTimeZone = -21600;   //+6
        int resultTimeZone = _weather!.timeZone;   //-8
        print(resultTimeZone);
        currentHour = currentHour + localTimeZone + resultTimeZone;
        print('test: ' + currentHour.toString());
        currentHour = currentHour/3600;
        if(currentHour<0) {currentHour+=24;}
        else if (currentHour>24) {currentHour-=24;}
        print('currentHour: ' + currentHour.toString());

        //assign current hour to a time of day
        if(currentHour>=4 && currentHour<=19){
          if(currentHour>=7 && currentHour<=16) {timeOfDay="Day";}
          else {timeOfDay="Dawndusk";}
        }
        else {timeOfDay="Night";}
      }

      //DEMO SCREENSHOTS CODE
      //timeOfDay="Night";
      //switch ('thunderstorm') {
      switch (_weather?.mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          if(timeOfDay=="Day"){
            backgroundImg = 'assets/img/weatherBG2A_cloudyDay.png';
            uiColor = 0xff12362d;
            leftButtonImg = "assets/img/buttonLeft_2A.png";
            rightButtonImg = "assets/img/buttonRight_2A.png";
          }
          else if(timeOfDay=="Night"){
            backgroundImg = 'assets/img/weatherBG2C_cloudyNight.png';
            uiColor = 0xffffffff;
            leftButtonImg = "assets/img/buttonLeft_0A.png";
            rightButtonImg = "assets/img/buttonRight_0A.png";
          }
          else{
            backgroundImg = 'assets/img/weatherBG2B_cloudyDawndusk.png';
            uiColor = 0xff522c02;
            leftButtonImg = "assets/img/buttonLeft_2B.png";
            rightButtonImg = "assets/img/buttonRight_2B.png";
          }
        case 'rain':
          if(timeOfDay=="Day"){
            backgroundImg = 'assets/img/weatherBG3A_rainyDay.png';
            uiColor = 0xff192723;
            leftButtonImg = "assets/img/buttonLeft_3A.png";
            rightButtonImg = "assets/img/buttonRight_3A.png";
          }
          else if(timeOfDay=="Night"){
            backgroundImg = 'assets/img/weatherBG3C_rainyNight.png';
            uiColor = 0xffffffff;
            leftButtonImg = "assets/img/buttonLeft_0A.png";
            rightButtonImg = "assets/img/buttonRight_0A.png";
          }
          else{
            backgroundImg = 'assets/img/weatherBG3B_rainyDawndusk.png';
            uiColor = 0xff261f18;
            leftButtonImg = "assets/img/buttonLeft_3B.png";
            rightButtonImg = "assets/img/buttonRight_3B.png";
          }
        case 'drizzle':
        case 'shower rain':
        case 'thunderstorm':
          if(timeOfDay=="Day"){
            backgroundImg = 'assets/img/weatherBG4A_stormyDay.png';
            uiColor = 0xff081d2c;
            leftButtonImg = "assets/img/buttonLeft_4A.png";
            rightButtonImg = "assets/img/buttonRight_4A.png";
          }
          else if(timeOfDay=="Night"){
            backgroundImg = 'assets/img/weatherBG4C_stormyNight.png';
            uiColor = 0xffffffff;
            leftButtonImg = "assets/img/buttonLeft_0A.png";
            rightButtonImg = "assets/img/buttonRight_0A.png";
          }
          else{
            backgroundImg = 'assets/img/weatherBG4B_stormyDawndusk.png';
            uiColor = 0xff0d0500;
            leftButtonImg = "assets/img/buttonLeft_4B.png";
            rightButtonImg = "assets/img/buttonRight_4B.png";
          }
        case 'clear':
          if(timeOfDay=="Day"){
            backgroundImg = 'assets/img/weatherBG1A_sunnyDay.png';
            uiColor = 0xff02533e;
            leftButtonImg = "assets/img/buttonLeft_1A.png";
            rightButtonImg = "assets/img/buttonRight_1A.png";
          }
          else if(timeOfDay=="Night"){
            backgroundImg = 'assets/img/weatherBG1C_sunnyNight.png';
            uiColor = 0xffffffff;
            leftButtonImg = "assets/img/buttonLeft_0A.png";
            rightButtonImg = "assets/img/buttonRight_0A.png";
          }
          else{
            backgroundImg = 'assets/img/weatherBG1B_sunnyDawndusk.png';
            uiColor = 0xff522c02;
            leftButtonImg = "assets/img/buttonLeft_1B.png";
            rightButtonImg = "assets/img/buttonRight_1B.png";
          }
        default:
          backgroundImg = 'assets/img/loadingBG.png';
          uiColor = 0xff000000;
          leftButtonImg = "assets/img/buttonLeft_0B.png";
          rightButtonImg = "assets/img/buttonRight_0B.png";
      }
    }
    );
  }

    catch (e){
    print(e);
  }
}

// weather Animation

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'animation/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'animations/cloudy.json';
      case 'rain':
        return 'animations/raining.json';
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'animations/thunderstorm.json';
      case 'clear':
        return 'animations/sunny.json';
      default:
        return 'animations/sunny.json';
    }
  }

  //initial state
@override
  void initState() {
    super.initState();
    _fetchWeather(this.searchedCity);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImg), // Replace with your image file path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WeatherPage(searchedCity: "")),
                          );
                        },
                        icon: Image.asset(leftButtonImg, width: 50,),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchPage()),
                          );
                        },
                        icon: Image.asset(rightButtonImg, width: 50,),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Text('${_weather?.temperature.round()}',
                        style: TextStyle(
                          color: Color(uiColor),
                          fontFamily: 'CenturyGothic',
                          fontSize: 150.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Text('°c',
                        style: TextStyle(
                          color: Color(uiColor),
                          fontSize: 70.0,
                          fontFamily: 'CenturyGothic',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        if (_weather != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_weather?.mainCondition} in ${_weather?.cityName}',
                              style: TextStyle(
                                color: Color(uiColor),
                                fontSize: 25.0, // Adjust the font size as needed
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                // Change the text color to blue
                              ),
                            ),
                            Text('Feels like ${_weather?.feelsLike.round()}°c',
                              style: TextStyle(
                                color: Color(uiColor),
                                fontSize: 25.0, // Adjust the font size as needed
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                // Change the text color to blue
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_weather != null)
                          Lottie.asset(
                            getWeatherAnimation(_weather?.mainCondition),
                            width: 60,
                            height: 60,
                          ),
                        SizedBox(width: 15),
                        Text("Weather Details",
                          style: TextStyle(
                            color: Color(detailsColor),
                            fontSize: 30.0,
                            fontFamily: 'CenturyGothic',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            if (_weather != null)
                            Image.asset(
                              'assets/img/iconMinTempA.png',
                              // Optional: You can set additional properties here, such as width and height.
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 15),
                            Text("Min Temp",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 15.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text("${_weather?.minTemp.round()}°c",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 25.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (_weather != null)
                              Image.asset(
                                'assets/img/iconMaxTempA.png',
                                // Optional: You can set additional properties here, such as width and height.
                                width: 50,
                                height: 50,
                              ),
                            SizedBox(height: 15),
                            Text("Max Temp",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 15.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text("${_weather?.maxTemp.round()}°c",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 25.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (_weather != null)
                              Image.asset(
                                'assets/img/iconHumidityA.png',
                                // Optional: You can set additional properties here, such as width and height.
                                width: 50,
                                height: 50,
                              ),
                            SizedBox(height: 15),
                            Text("Humidity",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 15.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text("${_weather?.humidity}%",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 25.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            if (_weather != null)
                              Image.asset(
                                'assets/img/iconWindspeedA.png',
                                // Optional: You can set additional properties here, such as width and height.
                                width: 50,
                                height: 50,
                              ),
                            SizedBox(height: 15),
                            Text("Wind Speed",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 15.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text("${_weather?.windSpeed}m/s",
                              style: TextStyle(
                                color: Color(detailsColor),
                                fontSize: 25.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String text) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 24),
          SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

