import 'package:flutter/material.dart';
import 'package:zylentrix/views/home_screen.dart';
import 'package:zylentrix/views/post_detail_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/posts':
        return MaterialPageRoute(builder: (_) => PostScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
