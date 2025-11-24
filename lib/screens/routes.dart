import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class AppRoutes {
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String reminders = '/reminders';
  static const String stats = '/stats';
  static const String streaks = '/streaks';
  static const String settings = '/settings';
  static const String habitDetail = '/habitDetail';
  static const String addHabit = '/addHabit';
}


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.register:
      return MaterialPageRoute(builder: (_) => const RegistrationScreen());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(builder: (_) => const RegistrationScreen());
  }
}

