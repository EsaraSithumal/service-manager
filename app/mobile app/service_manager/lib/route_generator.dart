import 'package:flutter/material.dart';
import './Home/home.dart';
import './Dashboard/dashboard.dart';
import './Home/SignUp/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUp());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
