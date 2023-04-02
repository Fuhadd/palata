import 'dart:async';

import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';
import 'package:untitled8/views/authScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) async {
          await model.onLoad();
        },
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/Palata_green.png',
                      height: 90,
                      width: 90,
                    ),
                    Column(
                      children: const [
                        Text(
                          "Palata",
                          style: TextStyle(color: kMainColor, fontSize: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
