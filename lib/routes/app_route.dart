// Add views here

import 'package:flutter/material.dart';
import 'package:untitled8/routes/route.dart';
import 'package:untitled8/views/authScreen/login_screen.dart';
import 'package:untitled8/views/bottomNavScreen/home_screen.dart';
import 'package:untitled8/views/bottomNavScreen/profile_screen.dart';
import 'package:untitled8/views/estate_view.dart';
import 'package:untitled8/views/bottomNavScreen/message_view.dart';
import 'package:untitled8/views/bottomNavScreen/search_view.dart';
import 'package:untitled8/views/percentage_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.ESTATE_VIEW:
        return MaterialPageRoute(builder: (_) => EstateView());

      case Routes.SEARCH_VIEW:
        return MaterialPageRoute(builder: (_) => ViewEstate());
      case Routes.PROFILE_VIEW:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.MESSAGE_VIEW:
        return MaterialPageRoute(builder: (_) => MessageView());
      case Routes.HOME_SCREEN:
      case Routes.PERCENTAGE_VIEW:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.PERCENTAGE_VIEW:
        return MaterialPageRoute(builder: (_) => PercentageView());
      case Routes.LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
