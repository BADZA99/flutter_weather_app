// import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  var env = dotenv.DotEnv(includePlatformEnvironment: true)..load();
  runApp(MyApp(env: env));
}

class MyApp extends StatelessWidget {
  final dotenv.DotEnv env;

  const MyApp({Key? key, required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
