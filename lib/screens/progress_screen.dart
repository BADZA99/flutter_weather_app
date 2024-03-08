import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/services/API_CALL.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/cities.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/waiting_message.dart';
import 'dart:convert';
import 'package:weather_app/screens/weather_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double progress = 0.0;
  late Timer timer;
  late Timer timerMessage;
  // bool isFinished = false;
  bool hasStarted = false;

  late Future weatherData;
  late String jsonData;
  Color backgroundColor = Colors.white;
  int cityIndex = 0;
  int messageIndex = 0;
  // declare une liste de weather
  List<Weather> listweather = [];

  @override
  void initState() {
    super.initState();
    weatherData = getWeatherData(cities[0]);
    //  messages[0];

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      if (progress < 1.0) {
        setState(() {
           progress += 0.17;
          cityIndex = (cityIndex + 1) % cities.length;
          weatherData = getWeatherData(cities[cityIndex]);
        });
      } else {
        timer.cancel();
      }
    });

    timerMessage = Timer.periodic(Duration(seconds: 6), (Timer t) {
      if (progress < 1.0) {
        setState(() {
          // incremente messageindex max 3
          messageIndex = (messageIndex + 1) % 3;
        });
      } else {
        timerMessage.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void restart() {
    setState(() {
      progress = 0.0;
      // isFinished = false;
      listweather.clear();
      timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
        if (progress < 1.0) {
          setState(() {
             progress += 0.17;
            cityIndex = (cityIndex + 1) % cities.length;
            weatherData = getWeatherData(cities[cityIndex]);
          });
        } else {
          timer.cancel();
          setState(() {
            // isFinished = true;
          });
        }
      });
    });
  }

  String getWeatherEmoji(String weather) {
    if (weather.toLowerCase().contains('rain')) {
      return '🌧️';
    } else if (weather.toLowerCase().contains('snow')) {
      return '❄️';
    } else if (weather.toLowerCase().contains('wind')) {
      return '🌬️';
    } else if (weather.toLowerCase().contains('clear')) {
      return '☀️';
    } else if (weather.toLowerCase().contains('clouds')) {
      return '☁️';
    } else if (weather.toLowerCase().contains('dust')) {
      return '🌫️';
    } else if (weather.toLowerCase().contains('thunderstorm')) {
      return '⛈️';
    } else {
      return '❓';
    }
  }

  String getTemperatureEmoji(double temperature) {
    if (temperature < 0) {
      return '❄️'; // Emoji pour les températures inférieures à 0°C
    } else if (temperature < 10) {
      return '🥶'; // Emoji pour les températures entre 0°C et 10°C
    } else if (temperature < 20) {
      return '🌥️'; // Emoji pour les températures entre 10°C et 20°C
    } else if (temperature < 30) {
      return '☀️'; // Emoji pour les températures entre 20°C et 30°C
    } else {
      return '🔥'; // Emoji pour les températures supérieures à 30°C
    }
  }

Map<String, Color> getWeatherColors(String weather) {
    switch (weather) {
      case 'Clear':
        return {'backgroundColor': goldColor, 'textColor': whiteSmokeColor};
      case 'Clouds':
        return {'backgroundColor': cloudyColor, 'textColor': whiteSmokeColor};
      case 'Rain':
        return {'backgroundColor': rainyColor, 'textColor': whiteSmokeColor};
      case 'Dust':
        return {'backgroundColor': dustyColor, 'textColor': darkBlueColor};
      case 'Thunderstorm':
        return {'backgroundColor': stormyColor, 'textColor': whiteSmokeColor};
      default:
        return {'backgroundColor': stormyColor, 'textColor': darkBlueColor};
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Screen'),
        backgroundColor: Colors.transparent,
      ),
      body: progress >= 1 ? buildCityList() : buildWeatherData(),
    );
  }

  Widget buildWeatherData() {
    return StreamBuilder(
        stream: weatherData.asStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String jsonData = jsonEncode(snapshot.data);
            Map<String, Color> colors =
                getWeatherColors(jsonDecode(jsonData)['weather'][0]['main']);
            // ajoute  le nom de la ville, la température, la weather,la date de la ville dans le tableau listweather
            listweather.add(
              Weather(
                cityName: jsonDecode(jsonData)['name'],
                degree: (jsonDecode(jsonData)['main']['temp'] - 273.15)
                    .toStringAsFixed(2),
                weather: jsonDecode(jsonData)['weather'][0]['main'],
                date: DateFormat('dd-MM-yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        jsonDecode(jsonData)['dt'] * 1000)),
                // ajoute windSpeed,humidity,windDegree
                windSpeed: jsonDecode(jsonData)['wind']['speed'].toString(),
                humidity: jsonDecode(jsonData)['main']['humidity'].toString(),
                windDegree: jsonDecode(jsonData)['wind']['deg'].toString(),

              ),
            );

            return Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: <Widget>[
                   Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 250),
                           LoadingAnimationWidget.inkDrop(
                            color: colors['backgroundColor']!,
                            size: 100,
                          ),
                          const SizedBox(height: 250),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              messages[messageIndex],
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Visibility(
                                  visible: progress <
                                      1, 
                                      
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 24,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Visibility(
                                  visible: progress <
                                      1, // cacher en  100%
                                  child: Text(
                                    '${(progress * 100).toStringAsFixed(0)}%', 
                                    style: const TextStyle(
                                        color: Colors
                                            .black,
                                            fontWeight: FontWeight.bold), 
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(
                                      0, -10), 
                                  child: Visibility(
                                    visible: progress >=
                                        1, 
                                    child: ElevatedButton(
                                      onPressed: () {
                                        restart();
                                      },
                                      child: const Text(
                                        'Recommencer',
                                        style: TextStyle(
                                          fontSize: 18, // Increase font size
                                          fontWeight:
                                              FontWeight.bold, // Make text bold
                                          color:
                                              Colors.black, // Change text color
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget buildCityList() {
    Set<String> displayedCities = Set<String>();
    var uniqueCities = listweather
        .where((city) => displayedCities.add(city.cityName))
        .toList();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: uniqueCities.length,
            itemBuilder: (context, index) {
              return Container(
                height: 130, 
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherDetailPage(
                            key: UniqueKey(), weather: uniqueCities[index]),
                      ),
                    );
                  },
                  child: Card(
                    color: getWeatherColors(uniqueCities[index].weather)['backgroundColor'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                uniqueCities[index].cityName,
                                // text en blanc et en gras
                                style: TextStyle(fontSize: 25, color:  Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                               uniqueCities[index].weather,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${uniqueCities[index].degree}°C',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            getWeatherEmoji(uniqueCities[index].weather),
                            style: const TextStyle(
                                fontSize: 80), // Augmente la taille des emojis
                          ),
                        ],
                      ),
                    ),
                  ),
                
                ),
              ).animate().fade(duration: 200.ms, delay: (200 * index).ms);
            },
          ),
        ),
        ElevatedButton(
          onPressed: restart,
          child: const Text(
            'Recommencer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blue), // Change la couleur de fond du bouton
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(15)), // Ajoute du padding
            shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
            elevation: MaterialStateProperty.all<double>(5),
          ),
        ).animate().fade(duration: 200.ms, delay: (250).ms),
        SizedBox(height: 20), // Ajoute un peu d'espace en dessous du bouton
      ],
    );
  
  
  }
}
