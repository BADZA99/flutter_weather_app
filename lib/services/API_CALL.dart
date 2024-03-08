import 'package:weather/weather.dart';
import 'package:weather_app/services/api.dart';
import 'dart:convert';

String printJson(Map<String, dynamic> data) {
  String jsonData = jsonEncode(data);
  return jsonData;
}

WeatherFactory wf =  WeatherFactory(API_KEY);
Future<Weather> getWeatherData(String city) async {
  Weather weather = await wf.currentWeatherByCityName(city);
  // convertir weather en format json
  // String weatherString = weather.toString();
 

  return weather;
}

//fonction qui format en json











