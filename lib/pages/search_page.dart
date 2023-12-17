import 'package:flutter/material.dart';
import 'package:weatherapp/API/API.dart';
import 'package:http/http.dart' as http;
import '../pages/weather_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  Future<int> checkCity(String searchQuery) async {
    const Base_URL= 'https://api.openweathermap.org/data/2.5/weather';
    final String apiKey = '1533d3154835d4d1e158446f956c6093';
    final response = await http.get(Uri.parse('$Base_URL?q=$searchQuery&appid=$apiKey&units=metric'));

    if(response.statusCode == 404){
      return 0;
    }
    else {return 1;}
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/searchBG.jpg'), // Replace with your image file path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WeatherPage(searchedCity: "")),
                              );
                            },
                            icon: Image.asset('assets/img/backButton.png', width: 30,),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text("Check the weather in any area:",
                      style: TextStyle(
                        fontSize: 20.0, // Adjust the font size as needed
                        color: Color(0xff00a6ff),
                        fontFamily: 'CenturyGothic',
                        fontWeight: FontWeight.w700// Change the text color to blue
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Color(0xff00a6ff),
                          iconSize: 40,
                          onPressed: () async {
                            String searchQuery = _textEditingController.text;
                            int result = await checkCity(searchQuery);
                            if(searchQuery == ""){
                            }

                            else if (result == 0) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('No search results',
                                      style: TextStyle(
                                        color: Color(0xffc22a37),
                                        fontSize: 25.0, // Adjust the font size as needed
                                        fontFamily: 'CenturyGothic',
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        // Change the text color to blue
                                      ),
                                    ),
                                    content: Text('Sorry, no results were found for $searchQuery.',
                                      style: TextStyle(
                                        color: Color(0xff001d42),
                                        fontSize: 20.0, // Adjust the font size as needed
                                        fontFamily: 'CenturyGothic',
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        // Change the text color to blue
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the popup
                                        },
                                        child: Text('OK',
                                          style: TextStyle(
                                            color: Color(0xff00a6ff),
                                            fontSize: 25.0, // Adjust the font size as needed
                                            fontFamily: 'CenturyGothic',
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            // Change the text color to blue
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherPage(searchedCity: searchQuery),
                                ),
                              );
                            }
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: _textEditingController,
                              style: TextStyle(
                                color: Color(0xff00a6ff),
                                fontSize: 25.0,
                                fontFamily: 'CenturyGothic',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ), // Set input text color to blue
                              decoration: InputDecoration(
                                hintText: 'Area Name...',
                                filled: true,
                                fillColor: Colors.white, // Set fill color to white
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.white), // Set border color to white
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Color(0xff00a6ff)), // Set focused border color to blue
                                ),
                                hintStyle: TextStyle(color: Color(0xff00a6ff), fontSize: 18.0, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 1),
                    ElevatedButton(
                      onPressed: () async {
                        String searchQuery = _textEditingController.text;
                        int result = await checkCity(searchQuery);
                        if(searchQuery == ""){
                        }

                        else if (result == 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('No search results',
                                  style: TextStyle(
                                    color: Color(0xffc22a37),
                                    fontSize: 25.0, // Adjust the font size as needed
                                    fontFamily: 'CenturyGothic',
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    // Change the text color to blue
                                  ),
                                ),
                                content: Text('Sorry, no results were found for $searchQuery.',
                                  style: TextStyle(
                                    color: Color(0xff001d42),
                                    fontSize: 20.0, // Adjust the font size as needed
                                    fontFamily: 'CenturyGothic',
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    // Change the text color to blue
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the popup
                                    },
                                    child: Text('OK',
                                      style: TextStyle(
                                        color: Color(0xff00a6ff),
                                        fontSize: 25.0, // Adjust the font size as needed
                                        fontFamily: 'CenturyGothic',
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        // Change the text color to blue
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherPage(searchedCity: searchQuery),
                            ),
                          );
                        }
                      },
                      child: Text('Search', style: TextStyle(fontSize: 25.0)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00a6ff), // Background color
                        onPrimary: Color(0xffffffff), // Text color
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/img/hdmiLogo.png',
                    // Optional: You can set additional properties here, such as width and height.
                    width: 120,
                    height: 120,
                  ),
                  Text("© Highly Dedicated and Motivated Individuals",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 15.0,
                      fontFamily: 'CenturyGothic',
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text("Md Zannatul Iftear, Mohammed Obyead",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 15.0,
                      fontFamily: 'CenturyGothic',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}