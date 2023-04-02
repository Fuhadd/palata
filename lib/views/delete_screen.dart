import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../../constant/colors.dart';
import '../services/base_view.dart';
import '../services/database.dart';
import '../viewModels/auth_view_model.dart';
import '../viewModels/home_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../widgets/text_widget.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
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
                  title: buildText('Delete Account', Colors.black, 18, 0),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(false),
                  )),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    inputField(
                      'Email',
                      label: 'Email Address',
                      controller: model.emailAddressController,
                    ),
                    SizedBox(height: 50),
                    model.load
                        ? Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: kMainColor,
                                  padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {},
                                child: const CircularProgressIndicator()),
                          )
                        : GestureButtonWidget(
                            circularSize: 100,
                            buttonColor: kMainColor,
                            size: 13,
                            text: 'Delete Account',
                            textColor: Colors.white,
                            onPress: () {
                              if (model.databaseInfo.userDetails
                                  .ownedProperties!.isNotEmpty) {
                                Flushbar(
                                  title: 'Kindly sale your property',
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: 'Unable to delete account',
                                  backgroundColor: Colors.white,
                                  titleColor: kMainColor,
                                  messageColor: kMainColor,
                                  duration: const Duration(seconds: 2),
                                ).show(context);
                              } else if (model
                                  .emailAddressController.text.isNotEmpty) {
                                setState(() {
                                  model.load = true;
                                });
                                model.deleteCurrentAccount(context);
                              } else {
                                setState(() {
                                  model.load = false;
                                });
                                Flushbar(
                                  title: 'Kindly enter your email address ',
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: 'Email field cannot be empty',
                                  backgroundColor: Colors.white,
                                  messageColor: kMainColor,
                                  duration: const Duration(seconds: 2),
                                ).show(context);
                              }
                            }),
                  ],
                ),
              ),
            ));
  }
}
