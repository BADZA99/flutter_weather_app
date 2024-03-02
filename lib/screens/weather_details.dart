import 'package:flutter/material.dart';

class WeatherDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail'),
      ),
      body: Center(
        child: Text(
          'Weather Detail',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
