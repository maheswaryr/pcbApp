import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pcbapp/main.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 150,
                  height: 150,
                  child: Column(children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      // width: ScreenUtil.getInstance().setWidth(110),
                      //height: ScreenUtil.getInstance().setHeight(110),
                    ),
                  ])),
              Text('KERALA POLLUTION CONTROL BOARD',
                  style: TextStyle(
                    fontFamily: 'kanit regular',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ));
  }
}
