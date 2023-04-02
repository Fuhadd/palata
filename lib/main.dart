import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:untitled8/routes/app_route.dart';
import 'package:untitled8/services/navigation_service.dart';
import 'package:untitled8/views/splash_screen.dart';

import 'locator.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato', primarySwatch: Colors.grey),
      navigatorKey: locator<NavigationService>().navigatorKey,

      // home: const TestScreen(),
      home: SplashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
