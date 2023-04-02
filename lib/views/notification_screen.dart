import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';

import '../widgets/text_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) async {
          //await model.onLoad();
        },
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0.0,
                  title: buildText('Notification', Colors.black, 18, 0),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(false),
                  )),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Enable Notification',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                    Switch(
                      value: model.toggle,
                      onChanged: (bool? value) {
                        model.toggleButton();
                      },
                      activeColor: kMainColor,
                      activeTrackColor: model.toggle ? kMainColor : Colors.grey,
                    ),
                  ],
                ),
              ),
            ));
  }
}
