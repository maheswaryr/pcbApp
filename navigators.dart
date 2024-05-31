import 'package:flutter/material.dart';

class Navigators {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }
  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }
  static void goToViewComplaint(BuildContext context) {
    Navigator.pushNamed(context, "/complaint");
  }
  static void goToFileComplaint(BuildContext context) {
    Navigator.pushNamed(context, "/fileComplaint");
  }
  static void goToTrackComplaint(BuildContext context) {
    Navigator.pushNamed(context, "/trackComplaint");
  }
}
