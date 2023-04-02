import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  //final context = Get.context;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndPush(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // pushScreen(Widget widget) async {
  //   return Navigator.push(
  //     context,
  //     CupertinoPageRoute(builder: (c) => widget),
  //   );
  // }
}
