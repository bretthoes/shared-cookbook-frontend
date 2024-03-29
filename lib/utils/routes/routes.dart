import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/landing/landing.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String landing = '/landing';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    landing: (BuildContext context) => LandingScreen()
  };
}
