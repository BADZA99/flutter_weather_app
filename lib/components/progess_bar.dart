import 'dart:async';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar({Key? key}) : super(key: key);
  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  double progress = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        progress += 0.1; // Increase progress by 10% every 10 seconds
        if (progress >= 1.0) {
          t.cancel(); // Stop the timer when the progress bar is full
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: progress);
  }
}




