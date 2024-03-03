class Weather {
  final String cityName;
  final String date;
  final String degree;
  final String weather;
  // ajoute windSpeed,humidity,windDegree
  final String windSpeed;
  final String humidity;
  final String windDegree;



  Weather({
    required this.cityName,
    required this.date,
    required this.degree,
    required this.weather,
    required this.windSpeed,
    required this.humidity,
    required this.windDegree,
 
   
   
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['cityName'],
      date: json['date'] as String,
      degree: json['degree'],
      weather: json['weather'],
      windSpeed: json['windSpeed'],
      humidity: json['humidity'],
      windDegree: json['windDegree'],
   
     
    );
  }
}
