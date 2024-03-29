import 'dart:async';
import 'package:examglob/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF6F00),
      body: Center(
          child: Text(
            'EXAMENGLOBAL',
            style: TextStyle(
                fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }
}
