import 'dart:async';
import 'package:alan_voice_command/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    timer = Timer(
      const Duration(milliseconds: 2000),
          () async {
        timer.cancel();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 96),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Alan AI Voice Command",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      height: 1.4,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
