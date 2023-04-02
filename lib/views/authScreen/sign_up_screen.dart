import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import 'package:untitled8/enum/auth_state.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/widgets/custom_button.dart';
import 'package:untitled8/widgets/input_field.dart';

import '../../constant/colors.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (model) async {
          //await model.onLoad();
        },
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: kMainColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      inputField('First name',
                          label: 'First Name',
                          controller: model.firstNameController),
                      const SizedBox(height: 25),
                      inputField('Last name',
                          label: 'Last Name',
                          controller: model.latNameController),
                      const SizedBox(height: 25),
                      inputField(
                        'Email',
                        label: 'Email Address',
                        controller: model.emailAddressController,
                      ),
                      const SizedBox(height: 25),
                      inputField('Phone number',
                          label: 'Phone number',
                          controller: model.phoneNoController,
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 25),
                      inputField(
                        'Password',
                        label: 'Password',
                        controller: model.passwordController,
                        showPassword: model.obscureText,
                        toggleShowPassword: () => model.toggle(),
                      ),
                      const SizedBox(height: 25),
                      inputField(
                        'Confirm password',
                        label: 'Confirm Password',
                        controller: model.confirmPassController,
                        showPassword: model.obscure,
                        toggleShowPassword: () => model.toggleButton(),
                      ),
                      const SizedBox(height: 30),
                      model.isLoading
                          ? Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kMainColor,
                                    padding:
                                        const EdgeInsets.fromLTRB(80, 0, 80, 0),
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
                              text: 'Sign Up',
                              textColor: Colors.white,
                              onPress: () {
                                if (model.passwordController.text ==
                                    model.confirmPassController.text) {
                                  setState(() {
                                    model.isLoading = true;
                                  });
                                  model.signUpUser(
                                      type: SignUpType.email,
                                      email: model.emailAddressController.text,
                                      password: model.passwordController.text,
                                      firstName: model.firstNameController.text,
                                      lastName: model.latNameController.text,
                                      phoneNumber: model.phoneNoController.text,
                                      context: context);
                                } else {
                                  model.isLoading = false;
                                  Flushbar(
                                    title: 'Password does not match',
                                    flushbarPosition: FlushbarPosition.TOP,
                                    message: 'Password does not match',
                                    backgroundColor: Colors.white,
                                    messageColor: kMainColor,
                                    duration: const Duration(seconds: 1),
                                  ).show(context);
                                }
                              }),
                      const SizedBox(height: 30),
                      // Center(
                      //   child: Text(
                      //     '- Or Sign up with -',
                      //     style: TextStyle(fontSize: 16, color: kDeepColor),
                      //   ),
                      // ),
                      // const SizedBox(height: 30),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 18),
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
                      //             SizedBox(width: 10),
                      //             Text(
                      //               'Google',
                      //               style: TextStyle(
                      //                   color: kDeepColor,
                      //                   fontWeight: FontWeight.w700,
                      //                   fontSize: 18),
                      //             ),
                      //           ],
                      //         ),
                      //         onPressed: () {
                      //           signUpUser(
                      //               type: SignUpType.google, context: context);
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 30),
                      // Center(
                      //   child: Text(
                      //     'Forget Password?',
                      //     style: TextStyle(fontSize: 16, color: kDeepColor),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Already have an account?',
                                style:
                                    TextStyle(fontSize: 16, color: kDeepColor),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: kMainColor, fontSize: 16.0),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
