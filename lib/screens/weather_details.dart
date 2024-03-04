import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/colors.dart';
import  'package:weather_app/screens/home_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';


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
        return {'backgroundColor': sunnyColor, 'textColor': whiteSmokeColor};
      case 'Clouds':
        return {'backgroundColor': cloudyColor, 'textColor': whiteSmokeColor};
      case 'Rain':
        return {'backgroundColor': rainyColor, 'textColor': whiteSmokeColor};
      case 'Dust':
        return {'backgroundColor': dustyColor, 'textColor': darkBlueColor};
      case 'Thunderstorm':
        return {'backgroundColor': stormyColor, 'textColor': whiteSmokeColor};
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
          const SizedBox(height: 20),
          Text(
            '${weather.cityName}',
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ).animate().fade(duration: 200.ms).scale(delay: 200.ms),
          const SizedBox(height: 20),
          Text(
            '${weather.date}',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ).animate().fade(duration: 200.ms, delay: 400.ms),
          const SizedBox(height: 10),
          Text(
            '${getWeatherEmoji(weather.weather)}',
            style: const TextStyle(fontSize: 200),
          ).animate().fade(duration: 200.ms, delay: 600.ms),
          const SizedBox(height: 8),
          Text(
            '${weather.degree}°C',
            style: const TextStyle(fontSize: 54, color: Colors.white),
          ).animate().fade(duration: 200.ms, delay: 800.ms),
          Text(
            '${weather.weather}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ).animate().fade(duration: 200.ms, delay: 1000.ms),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '🌬️', // Emoji statique pour windSpeed
                    style: const TextStyle(fontSize: 24),
                  ).animate().fade(duration: 200.ms, delay: 1200.ms),
                  Text(
                    '${weather.windSpeed}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ).animate().fade(duration: 200.ms, delay: 1400.ms),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '💧', // Emoji statique pour humidity
                    style: const TextStyle(fontSize: 24),
                  ).animate().fade(duration: 200.ms, delay: 1600.ms),
                  Text(
                    '${weather.humidity}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ).animate().fade(duration: 200.ms, delay: 1800.ms),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '🧭', // Emoji statique pour windDegree
                    style: const TextStyle(fontSize: 24),
                  ).animate().fade(duration: 200.ms, delay: 2000.ms),
                  Text(
                    '${weather.windDegree}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ).animate().fade(duration: 200.ms, delay: 2200.ms),
                ],
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  HomePage()),
              );
            },
            child: const Text('Retour à l\'accueil'),
          ).animate().fade(duration: 200.ms, delay: 2400.ms),
          const SizedBox(height: 20),
        ],
      ),
    );
  
  
  }
}
