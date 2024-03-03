import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/colors.dart';
import  'package:weather_app/screens/home_screen.dart';
import 'package:dotenv/dotenv.dart' as dotenv;


class WeatherDetailPage extends StatelessWidget {
  final Weather weather;

  const WeatherDetailPage({required Key key, required this.weather})
      : super(key: key);

      
      




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


Map<String, Color> getWeatherColors(String weather) {
    switch (weather) {
      case 'Clear':
        return {'backgroundColor': blueGreyColor, 'textColor': whiteSmokeColor};
      case 'Clouds':
        return {'backgroundColor': darkBlueColor, 'textColor': whiteSmokeColor};
      case 'Rain':
        return {'backgroundColor': purpleColor, 'textColor': whiteSmokeColor};
      case 'Dust':
        return {'backgroundColor': goldColor, 'textColor': darkBlueColor};
      case 'Thunderstorm':
        return {'backgroundColor': violetColor, 'textColor': whiteSmokeColor};
      default:
        return {'backgroundColor': whiteSmokeColor, 'textColor': darkBlueColor};
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: getWeatherColors(weather.weather)['backgroundColor'],
      appBar: AppBar(
       title: Text(
          '${weather.cityName} Weather Detail',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: getWeatherColors(weather.weather)['backgroundColor'],


      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            '${weather.cityName}',
            style: TextStyle(fontSize: 30, color: Colors.white
            , fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            '${weather.date}',
              style: TextStyle(fontSize: 20, color: Colors.white), 
          ),
          SizedBox(height: 10),
          Text(
            '${getWeatherEmoji(weather.weather)}',
            style: TextStyle(fontSize: 200),
          ),
          SizedBox(height: 8),
          Text(
            '${weather.degree}°C',
             style: TextStyle(fontSize: 54, color: Colors.white), 
          ),
          Text(
            '${weather.weather}',
              style: TextStyle(fontSize: 24, color: Colors.white), 
          ),
          SizedBox(height: 50),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '🌬️', // Emoji statique pour windSpeed
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weather.windSpeed}',
                     style: TextStyle(fontSize: 24, color: Colors.white), 
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '💧', // Emoji statique pour humidity
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weather.humidity}',
                     style: TextStyle(fontSize: 24, color: Colors.white), 
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '🧭', // Emoji statique pour windDegree
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weather.windDegree}',
                     style: TextStyle(fontSize: 24, color: Colors.white), 
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
              );
            },
            child: Text('Retour à l\'accueil'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
