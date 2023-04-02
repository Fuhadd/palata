import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/widgets/input_field.dart';

import '../../constant/colors.dart';
import '../services/base_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_widget.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0.0,
                  title: buildText('Reset Password', Colors.black, 18, 0),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(false),
                  )),
              body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    inputField(
                      'Email',
                      label: 'Email Address',
                      controller: model.emailAddressController,
                    ),
                    const SizedBox(height: 50),
                    model.isLoading
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
                            text: 'Reset Password',
                            size: 13,
                            textColor: Colors.white,
                            onPress: () {
                              if (model
                                  .emailAddressController.text.isNotEmpty) {
                                setState(() {
                                  model.isLoading = true;
                                });
                                model.resetPassword(
                                    email: model.emailAddressController.text,
                                    context: context);
                              } else {
                                setState(() {
                                  model.isLoading = false;
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
