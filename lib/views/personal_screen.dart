import 'package:flutter/material.dart';

import '../services/base_view.dart';
import '../viewModels/auth_view_model.dart';
import '../viewModels/home_view_model.dart';
import '../widgets/text_widget.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0.0,
                  title: buildText('Profile', Colors.black, 18, 0),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(false),
                  )),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            const Text('Email:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(
                              '${model.databaseInfo.userDetails.email}',
                              style: TextStyle(fontSize: 18),
                            ),
                            const Divider(color: Colors.grey),
                            SizedBox(height: 20),
                            const Text('Name:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(
                              '${model.databaseInfo.userDetails.firstName} ${model.databaseInfo.userDetails.lastName ?? ''}',
                              style: TextStyle(fontSize: 18),
                            ),
                            const Divider(color: Colors.grey),
                            SizedBox(height: 20),
                            const Text('Phone Number:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text(
                              '${model.databaseInfo.userDetails.phone ?? ''}',
                              style: TextStyle(fontSize: 18),
                            ),
                            const Divider(color: Colors.grey),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
