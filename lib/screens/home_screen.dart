import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:flutter/material.dart';
// import colors
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/screens/progress_screen.dart';



class HomePage extends StatefulWidget {


  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeColor,
      appBar: AppBar(
        title: const Text('Acceuil'),
        backgroundColor: homeColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2, 
            // diminuer la hauteur

            child: Stack(
              alignment: Alignment.center,

              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0, _controller.value * 100 - 50),
                      child: Text(
                        '☀️',
                        style: TextStyle(fontSize: 275),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(30, -_controller.value * 100 + 50),
                      child: Text(
                        '☁️',
                        style: TextStyle(fontSize: 280),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, // Reduced from 3 to 2
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Bienvenue sur WeatherApp',
                    style: TextStyle(fontSize: 27),
                  ),
                  const SizedBox(height: 50),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressScreen()),
                      );
                    },
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressScreen()),
                        );
                      },
                      child: const Text('Commencer'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green), // background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // text color
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // border radius
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15), // padding
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 20, // font size
                            fontWeight: FontWeight.bold, // font weight
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
