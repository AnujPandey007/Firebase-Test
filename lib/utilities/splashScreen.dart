import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reservation_app/screens/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Internship\nSplash Screen",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orange[600],
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}