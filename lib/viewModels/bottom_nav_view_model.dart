import 'package:flutter/material.dart';
import 'package:untitled8/model/base_model.dart';
import 'package:untitled8/routes/route.dart';
import 'package:untitled8/services/navigation_service.dart';

import '../locator.dart';

class BottomNavViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  int selectIndex = 0;

  void switchPages(int value) {
    selectIndex = value;
    notifyListeners();
    switch (value) {
      case 0:
        _navigationService.navigatorKey.currentState!
            .pushNamed(Routes.HOME_SCREEN);
        break;
      case 1:
        _navigationService.navigatorKey.currentState!
            .pushNamed(Routes.SEARCH_VIEW);
        break;
      case 2:
        _navigationService.navigatorKey.currentState!
            .pushNamed(Routes.MESSAGE_VIEW);
        break;
      case 3:
        _navigationService.navigatorKey.currentState!
            .pushNamed(Routes.PROFILE_VIEW);
        break;
    }
  }
}
