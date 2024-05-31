import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pcbapp/Activity/industryHome.dart';
import 'package:pcbapp/Activity/pcbHome.dart';
import 'package:pcbapp/Activity/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created by Vivek on 04/11/20.

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KERALA STATE POLLUTION CONTROL BOARD',
      /*theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        primarySwatch: Colors.blue,
      ),*/
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? sessionToken = "";
  String? domain = "";

  startTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sessionToken = preferences.getString("token");
    domain = preferences.getString("domain");
    var _duration = new Duration(seconds: 2);
    if(sessionToken == null && domain == null) {
      return new Timer(_duration, navigationPage);
    } else if(sessionToken != null && domain == "P"){
      return new Timer(_duration, pcbHome);
    } else if(sessionToken != null && domain == "I"){
      return new Timer(_duration, industryHome);
    } else {
      return new Timer(_duration, navigationPage);
    }
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }
  void pcbHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
  }
  void industryHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => IndHome()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
