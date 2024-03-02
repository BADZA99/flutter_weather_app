class Weather {
  final String cityName;
  final String date;
  final String degree;
  final String weather;



  Weather({
    required this.cityName,
    required this.date,
    required this.degree,
    required this.weather,
 
   
   
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['cityName'],
      date: json['date'] as String,
      degree: json['degree'],
      weather: json['weather'],
   
     
    );
  }
}
