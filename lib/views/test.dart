import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../constant/colors.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/widgets/custom_button.dart';

import '../services/estate_service.dart';

// import 'login_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 50),
                        const Center(
                          child: Text(
                            'Create Estate',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: kMainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'address',
                          Icons.phone,
                          null,
                          'address',
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'amountLeft',
                          Icons.phone,
                          null,
                          'amountLeft',
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'availablePercentage',
                          Icons.phone,
                          null,
                          'availablePercentage',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'currentPrice',
                          Icons.phone,
                          null,
                          'currentPrice',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'description',
                          Icons.phone,
                          null,
                          'description',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'image',
                          Icons.phone,
                          null,
                          'image',
                        ),
                        customFormBuilderTextField(
                          'imageLink',
                          Icons.phone,
                          null,
                          'imageLink',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'monthlyIncome',
                          Icons.phone,
                          null,
                          'monthlyIncome',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'monthlyReturn',
                          Icons.phone,
                          null,
                          'monthlyReturn',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'percentage',
                          Icons.phone,
                          null,
                          'percentage',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'percentageReturn',
                          Icons.phone,
                          null,
                          'percentageReturn',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'purchaseDate',
                          Icons.phone,
                          null,
                          'purchaseDate',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'purchasePrice',
                          Icons.phone,
                          null,
                          'purchasePrice',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'totalReturn',
                          Icons.phone,
                          null,
                          'totalReturn',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'type',
                          Icons.phone,
                          null,
                          'type',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'yearBuilt',
                          Icons.phone,
                          null,
                          'yearBuilt',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnd0',
                          Icons.phone,
                          null,
                          'earnd0',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earne0',
                          Icons.phone,
                          null,
                          'earne0',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnv0',
                          Icons.phone,
                          null,
                          'earnv0',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnd1',
                          Icons.phone,
                          null,
                          'earnd1',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earne1',
                          Icons.phone,
                          null,
                          'earne1',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnv1',
                          Icons.phone,
                          null,
                          'earnv1',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnd2',
                          Icons.phone,
                          null,
                          'earnd2',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earne2',
                          Icons.phone,
                          null,
                          'earne2',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnv2',
                          Icons.phone,
                          null,
                          'earnv2',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnd3',
                          Icons.phone,
                          null,
                          'earnd3',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earne3',
                          Icons.phone,
                          null,
                          'earne3',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnv3',
                          Icons.phone,
                          null,
                          'earnv3',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnd4',
                          Icons.phone,
                          null,
                          'earnd4',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earne4',
                          Icons.phone,
                          null,
                          'earne4',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        customFormBuilderTextField(
                          'earnv4',
                          Icons.phone,
                          null,
                          'earnv4',
                        ),

                        model.isLoading
                            ? Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kMainColor,
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 80, 0),
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
                                text: 'Sign Up',
                                textColor: Colors.white,
                                onPress: () async {
                                  var address = _formKey
                                      .currentState?.fields['address']?.value
                                      .toString()
                                      .trim();
                                  var amountLeft = _formKey
                                      .currentState?.fields['amountLeft']?.value
                                      .toString()
                                      .trim();
                                  var availablePercentage = _formKey
                                      .currentState
                                      ?.fields['availablePercentage']
                                      ?.value
                                      .toString()
                                      .trim();
                                  var currentPrice = _formKey.currentState
                                      ?.fields['currentPrice']?.value
                                      .toString()
                                      .trim();
                                  var description = _formKey.currentState
                                      ?.fields['description']?.value
                                      .toString()
                                      .trim();
                                  var image = _formKey
                                      .currentState?.fields['image']?.value
                                      .toString()
                                      .trim();
                                  var imageLink = _formKey
                                      .currentState?.fields['imageLink']?.value
                                      .toString()
                                      .trim();
                                  var monthlyIncome = _formKey.currentState
                                      ?.fields['monthlyIncome']?.value
                                      .toString()
                                      .trim();
                                  var monthlyReturn = _formKey.currentState
                                      ?.fields['monthlyReturn']?.value
                                      .toString()
                                      .trim();
                                  var percentage = _formKey
                                      .currentState?.fields['percentage']?.value
                                      .toString()
                                      .trim();
                                  var percentageReturn = _formKey.currentState
                                      ?.fields['percentageReturn']?.value
                                      .toString()
                                      .trim();
                                  var purchaseDate = _formKey.currentState
                                      ?.fields['purchaseDate']?.value
                                      .toString()
                                      .trim();
                                  var purchasePrice = _formKey.currentState
                                      ?.fields['purchasePrice']?.value
                                      .toString()
                                      .trim();
                                  var totalReturn = _formKey.currentState
                                      ?.fields['totalReturn']?.value
                                      .toString()
                                      .trim();
                                  var type = _formKey
                                      .currentState?.fields['type']?.value
                                      .toString()
                                      .trim();
                                  var yearBuilt = _formKey
                                      .currentState?.fields['yearBuilt']?.value
                                      .toString()
                                      .trim();
                                  var earnd0 = _formKey
                                      .currentState?.fields['earnd0']?.value
                                      .toString()
                                      .trim();
                                  var earne0 = _formKey
                                      .currentState?.fields['earne0']?.value
                                      .toString()
                                      .trim();
                                  var earnv0 = _formKey
                                      .currentState?.fields['earnv0']?.value
                                      .toString()
                                      .trim();
                                  var earnd1 = _formKey
                                      .currentState?.fields['earnd1']?.value
                                      .toString()
                                      .trim();
                                  var earne1 = _formKey
                                      .currentState?.fields['earne1']?.value
                                      .toString()
                                      .trim();
                                  var earnv1 = _formKey
                                      .currentState?.fields['earnv1']?.value
                                      .toString()
                                      .trim();
                                  var earnd2 = _formKey
                                      .currentState?.fields['earnd2']?.value
                                      .toString()
                                      .trim();
                                  var earne2 = _formKey
                                      .currentState?.fields['earne2']?.value
                                      .toString()
                                      .trim();
                                  var earnv2 = _formKey
                                      .currentState?.fields['earnv2']?.value
                                      .toString()
                                      .trim();
                                  var earnd3 = _formKey
                                      .currentState?.fields['earnd3']?.value
                                      .toString()
                                      .trim();
                                  var earne3 = _formKey
                                      .currentState?.fields['earne3']?.value
                                      .toString()
                                      .trim();
                                  var earnv3 = _formKey
                                      .currentState?.fields['earnv3']?.value
                                      .toString()
                                      .trim();
                                  var earnd4 = _formKey
                                      .currentState?.fields['earnd4']?.value
                                      .toString()
                                      .trim();
                                  var earne4 = _formKey
                                      .currentState?.fields['earne4']?.value
                                      .toString()
                                      .trim();
                                  var earnv4 = _formKey
                                      .currentState?.fields['earnv4']?.value;
                                  print(1);
                                  List<Map> earn = [
                                    {
                                      'date': earnd0,
                                      'earning': earnd0,
                                      'value': earnd0
                                    },
                                    {
                                      'date': earnd1,
                                      'earning': earnd1,
                                      'value': earnd1
                                    },
                                    {
                                      'date': earnd2,
                                      'earning': earnd2,
                                      'value': earnd2
                                    },
                                    {
                                      'date': earnd3,
                                      'earning': earnd3,
                                      'value': earnd3
                                    },
                                    {
                                      'date': earnd4,
                                      'earning': earnd4,
                                      'value': earnd4
                                    },
                                  ];

                                  List<Map> images = [
                                    {
                                      'image': imageLink,
                                    },
                                  ];
                                  print(1);
                                  print(earn);
                                  await Future.delayed(
                                      const Duration(seconds: 5));

                                  print(2);
                                  print(earn);
                                  print(address);
                                  print(amountLeft);
                                  print(availablePercentage);

                                  print(currentPrice);
                                  print(description);
                                  print(earnv4);
                                  print(image);
                                  print(images);
                                  print(monthlyIncome);
                                  print(monthlyReturn);
                                  print(percentage);
                                  print(percentageReturn);
                                  print('break');
                                  print(purchaseDate);
                                  print(purchasePrice);
                                  print(totalReturn);
                                  print(type);
                                  print(yearBuilt);

                                  await EstateService().saveestate(
                                      address: address!,
                                      amountLeft: amountLeft!,
                                      availablePercentage:
                                          int.parse(availablePercentage!),
                                      currentPrice: int.parse(currentPrice!),
                                      description: description!,
                                      earn: earn,
                                      image: image!,
                                      images: images,
                                      monthlyIncome: monthlyIncome!,
                                      monthlyReturn: monthlyReturn!,
                                      percentage: percentage!,
                                      percentageReturn: percentageReturn!,
                                      purchaseDate: purchaseDate!,
                                      purchasePrice: int.parse(purchasePrice!),
                                      totalReturn: totalReturn!,
                                      type: type!,
                                      yearBuilt: yearBuilt!);

                                  //  EstateService().saveestate(address!, amountLeft!, availablePercentage, currentPrice, description!, earn, image!, images, monthlyIncome!, monthlyReturn!, percentage, percentageReturn, purchaseDate, purchasePrice, totalReturn, type, yearBuilt)
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                      fontSize: 16, color: kDeepColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: kMainColor, fontSize: 16.0),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

FormBuilderTextField customFormBuilderTextField(
  String name,
  IconData prefixIcon,
  IconData? suffixIcon,
  String labelText, {
  String? hintText,
  Widget? prefix,
  String? initialValue,
  bool isHint = false,
  bool obscureText = false,
  String? helperText,
  String? Function(String?)? validator,
}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: Colors.pink,
    name: name,
    obscureText: obscureText,
    validator: validator,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText, Widget? prefix, bool isHint = false}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: const TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        prefixIcon,
        size: 20,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 20,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
}
