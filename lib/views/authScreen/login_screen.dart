import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import 'package:untitled8/enum/auth_state.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/views/authScreen/sign_up_screen.dart';
import 'package:untitled8/widgets/custom_button.dart';
import 'package:untitled8/widgets/input_field.dart';

import '../../constant/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (model) async {
          //await model.onLoad();
        },
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: AutofillGroup(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 80),
                        Text(
                          'Log In.',
                          style: TextStyle(fontSize: 40.0, color: kMainColor),
                        ),
                        SizedBox(height: 80),
                        inputField(
                          'Email',
                          label: 'Email Address',
                          controller: model.emailAddressController,
                        ),
                        const SizedBox(height: 30),
                        inputField('Password',
                            label: 'Password',
                            controller: model.passwordController,
                            showPassword: model.obscureText,
                            toggleShowPassword: () => model.toggle()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            InkWell(
                              child: const Text(
                                'Forget Password',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ResetPassword()));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        model.isLoading
                            ? Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 60),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kMainColor,
                                      padding:
                                          EdgeInsets.fromLTRB(80, 0, 80, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const CircularProgressIndicator()),
                              )
                            : GestureButtonWidget(
                                circularSize: 100,
                                buttonColor: kMainColor,
                                text: 'Login',
                                textColor: Colors.white,
                                onPress: () {
                                  if (model.emailAddressController.text
                                          .isNotEmpty &&
                                      model
                                          .passwordController.text.isNotEmpty) {
                                    setState(() {
                                      model.isLoading = true;
                                    });
                                    setState(() {
                                      model.loginUser(
                                          type: LoginType.email,
                                          email:
                                              model.emailAddressController.text,
                                          password:
                                              model.passwordController.text,
                                          context: context);
                                    });
                                  } else {
                                    setState(() {
                                      model.isLoading = false;
                                    });
                                    Flushbar(
                                      title: 'Password or Email is Incorrect',
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: 'Password or Email is Incorrect',
                                      backgroundColor: Colors.white,
                                      messageColor: kMainColor,
                                      duration: Duration(seconds: 2),
                                    ).show(context);
                                  }
                                }),
                        SizedBox(height: 30),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 32, vertical: 8.0),
                        //   child: Center(
                        //     child: Text(
                        //       '- Or Sign up with -',
                        //       style:
                        //           TextStyle(fontSize: 16, color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 30),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 50),
                        //   child: Center(
                        //     child: Container(
                        //       height: 45,
                        //       margin: EdgeInsets.symmetric(horizontal: 30.0),
                        //       child: RaisedButton(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(100.0),
                        //             side: BorderSide(color: Colors.white)),
                        //         elevation: 5,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: <Widget>[
                        //             Image.asset('assets/images/google_logo.png',
                        //                 height: 30.0),
                        //             const SizedBox(width: 10),
                        //             const Text(
                        //               'Google',
                        //               style: TextStyle(
                        //                   color: Color(0xFF2C6319),
                        //                   fontWeight: FontWeight.w700,
                        //                   fontSize: 18),
                        //             ),
                        //           ],
                        //         ),
                        //         onPressed: () {
                        //           model.loginUser(
                        //               type: LoginType.google, context: context);
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 8.0),
                              child: Center(
                                child: InkWell(
                                  child: Text(
                                    'New User? Create account',
                                    style: TextStyle(
                                        fontSize: 16, color: kMainColor),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
