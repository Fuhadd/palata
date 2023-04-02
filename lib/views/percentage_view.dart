import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';

import '../model/user_model.dart';
import '../widgets/custom_button.dart';

class PercentageView extends StatelessWidget {
  PercentageView(
      {Key? key, this.price, this.percentage, this.address, this.type})
      : super(key: key);
  String? address, type;
  int? percentage, price;
  int currentBalancePurchase = 0;
  int currentPropertyPercentagePurchase = 0;
  int bought = 0;
  double balanceBought = 0;
  int currentPropertyPricePurchase = 0;
  int? currentBalanceSell = 0;
  int currentPropertyPercentageSell = 0;
  int currentPropertyPriceSell = 0;
  int currentInvestAmtSell = 0;
  int currentInvestAmtPurchase = 0;
  UserDetails? userDetails = UserDetails();

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return BaseView<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: 800,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  model.navigateBack();

                                  model.clearButton();
                                },
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          child: Container(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "${model.userInput}%",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        model.loading
                            ? Container(
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kMainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                              )
                            : GestureButtonWidget(
                                circularSize: 0,
                                buttonColor: kMainColor,
                                text: 'SUBMIT',
                                textColor: Colors.white,
                                onPress: () {
                                  print(1);
                                  print(price);
                                  //Price bought after multiply by user percentage in $
                                  bought = int.parse(model.userInput) * price!;
                                  balanceBought = bought / 100;
                                  if (kDebugMode) {
                                    print('BOUGHT $balanceBought');
                                  }

                                  //Current user balance in $ Purchase
                                  currentBalancePurchase = (model.databaseInfo
                                          .userDetails.userBalance! -
                                      balanceBought.toInt());

                                  print(
                                      'Balance${model.databaseInfo.userDetails.userBalance!}');
                                  print(
                                      'CURRENT BALANCE $currentBalancePurchase');
                                  print("%now $percentage");
                                  //Available property in %
                                  currentPropertyPercentagePurchase =
                                      percentage! - int.parse(model.userInput);
                                  print(
                                      'ADDRESS$currentPropertyPercentagePurchase');
                                  print(
                                      'currentPropertyPercentage$currentPropertyPercentagePurchase');
                                  print(model
                                      .databaseInfo.userDetails.userBalance);
                                  //Available property in $
                                  currentPropertyPricePurchase =
                                      price! - balanceBought.toInt();
                                  currentInvestAmtPurchase = model.databaseInfo
                                          .userDetails.investmentAmount! +
                                      balanceBought.toInt();
                                  // currentInvestAmtPurchase =
                                  //     0 + balanceBought.toInt();

                                  //Sell
                                  currentBalanceSell = (model.databaseInfo
                                          .userDetails.userBalance! +
                                      balanceBought.toInt());
                                  currentPropertyPercentageSell =
                                      model.propertyPercentage +
                                          int.parse(model.userInput);
                                  currentPropertyPriceSell =
                                      price! + balanceBought.toInt();
                                  currentInvestAmtSell = model.databaseInfo
                                          .userDetails.investmentAmount! -
                                      balanceBought.toInt();

                                  print(
                                      'currentPropertyPrice$currentPropertyPricePurchase');
                                  if (type == 'Sell' &&
                                      model.userInput.isNotEmpty &&
                                      int.parse(model.userInput) <=
                                          percentage!) {
                                    model.ownPercentage =
                                        int.parse(model.userInput);
                                    model.percentageLeft = type == "Sell"
                                        ? currentPropertyPercentageSell
                                        : currentPropertyPercentagePurchase;
                                    model.amountLeft = type == "Sell"
                                        ? currentPropertyPriceSell
                                        : currentPropertyPricePurchase;
                                    model.uid =
                                        model.databaseInfo.userDetails.uid;
                                    model.investmentAmt = currentInvestAmtSell;
                                    model.currentBalance = type == "Sell"
                                        ? currentBalanceSell
                                        : currentBalancePurchase;
                                    print('PERCENTAGE${model.userInput}');
                                    model.messages =
                                        'You have sold this property successfully';
                                    model.updateOwnedProperty(
                                        model.databaseInfo.userDetails.uid,
                                        address,
                                        type);
                                    print(
                                        'UIDDD ${model.databaseInfo.userDetails.uid}}');
                                  } else if (model.userInput.isNotEmpty &&
                                      model.databaseInfo.userDetails
                                              .userBalance! >=
                                          balanceBought.toInt() &&
                                      type == 'Buy') {
                                    model.ownPercentage =
                                        int.parse(model.userInput);
                                    model.messages =
                                        'Congratulations! you have successfully bought';
                                    model.percentageLeft =
                                        currentPropertyPercentagePurchase;
                                    model.amountLeft =
                                        currentPropertyPricePurchase;
                                    model.investmentAmt =
                                        currentInvestAmtPurchase;
                                    model.uid =
                                        model.databaseInfo.userDetails.uid;

                                    model.currentBalance =
                                        currentBalancePurchase;
                                    print('PERCENTAGE${model.userInput}');
                                    model.updateOwnedProperty(
                                        model.databaseInfo.userDetails.uid,
                                        address,
                                        type);
                                    print(
                                        'UIDDD ${model.databaseInfo.userDetails.uid}}');
                                  } else if (model.userInput.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Amount cannot be empty"),
                                            duration: Duration(seconds: 5)));
                                  } else if (percentage == 0 &&
                                      model.convertToInt(model.userInput) >
                                          percentage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Available Property is $percentage%"),
                                            duration:
                                                const Duration(seconds: 5)));
                                  } else {
                                    model.updateMessage(context,
                                        model.databaseInfo.userDetails.uid,
                                        message: model.messages = type == "sell"
                                            ? 'You were unable to sell this property,fund  your account and try again.'
                                            : 'You were unable to buy this property,  fund  your account and try again.');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Insufficient user balance"),
                                            duration: Duration(seconds: 5)));
                                  }
                                }),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: GridView.builder(
                                itemCount: model.buttons.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  // Clear Button
                                  if (index == 11) {
                                    return MyButton(
                                      buttontapped: () {
                                        model.clearButton();
                                      },
                                      buttonText: model.buttons[index],
                                      color: Colors.blue[50],
                                      textColor: Colors.black,
                                    );
                                  } else {
                                    return MyButton(
                                      buttontapped: () {
                                        model.onTapButton(index);
                                      },
                                      buttonText: model.buttons[index],
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    );
                                  }
                                }), // GridView.builder
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
