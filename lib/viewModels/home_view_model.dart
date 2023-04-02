import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled8/model/base_model.dart';
import 'package:untitled8/model/estate_model.dart';
import 'package:untitled8/model/message_model.dart';
import 'package:untitled8/routes/route.dart';
import 'package:untitled8/services/estate_service.dart';
import 'package:untitled8/services/navigation_service.dart';
import 'package:untitled8/views/bottomNavScreen/home_screen.dart';
import 'package:untitled8/views/bottomNavScreen/profile_screen.dart';
import 'package:untitled8/views/bottomNavScreen/message_view.dart';
import 'package:untitled8/views/bottomNavScreen/search_view.dart';

import '../locator.dart';
import '../model/transaction_model.dart';
import '../model/user_model.dart';
import '../services/database.dart';
import '../services/firebase_authentication.dart';

class HomeViewModel extends BaseModel {
  bool onPressed = true;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TransactionModel? transaction = TransactionModel();
  final EstateService propertyDb = locator<EstateService>();
  final DatabaseInfo databaseInfo = locator<DatabaseInfo>();
  final MessageService _messageService = locator<MessageService>();
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController emailAddressController = TextEditingController();
  String? value = '';
  Property? sProperty;
  List<EstateModel> estate = [];
  List<MessageModel> message = [];
  UserDetails? user;
  List<dynamic>? images;
  bool isLoading = false;
  bool loading = false;
  late String address;
  late int ownedPercentage;
  late String totalReturn;
  late String monthlyReturn;
  late int purchasedPrice;
  late String purchaseDate;
  late int propertyPercentage;
  late String image;
  late String earning;
  late String purchaseType;
  late String propertyType;
  var price;

  void selection(
      {String? sAddress,
      int? sOwnedPercentage,
      String? sTotalReturn,
      String? sMonthlyReturn,
      int? sPurchasedPrice,
      String? sPurchaseDate,
      int? sPropertyPercentage,
      String? sImage,
      List<dynamic>? sImages}) {
    address = sAddress!;
    ownedPercentage = sOwnedPercentage!;
    totalReturn = sTotalReturn!;
    monthlyReturn = sMonthlyReturn!;
    propertyPercentage = sPropertyPercentage!;
    purchasedPrice = sPurchasedPrice!;
    purchaseDate = sPurchaseDate!;
    image = sImage!;
    images = sImages;

    //earning = sEarning!;
  }

  bool showAvg = false;
  bool toggle = false;
  bool selected = false;

  void selectedColor() {
    selected = !selected;
    notifyListeners();
  }

  void toggleButton() {
    toggle = !toggle;
    notifyListeners();
  }

  void selectedValue(String? type) {
    value = type;
    notifyListeners();
  }

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> loadProperty() async {
    //estate = _estateService.getEstateList();
    await propertyDb.getEstate();
    //     .then((value) {
    //   isLoading = false;
    //   notifyListeners();
    //   //estate = _estateService.getEstateList();
    // });
  }

  Future<void> onLoad() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLoading = true;
      notifyListeners();

      await propertyDb.getEstate();
      await propertyDb.filterEstate('Incomplete');

      //     .then((value) {
      //   estate = _estateService.getEstateList();
      //   isLoading = false;
      //   notifyListeners();
      // });
      _messageService.getMessage().then((value) {
        message = _messageService.getMessageList();
        isLoading = false;
        notifyListeners();
      });

      //await databaseInfo.getUserInfo(firebaseUser!.uid);
      if (kDebugMode) {
        print('UUUUUU $user');
      }
      //     .then((value) {
      //   user = value;
      //   if (kDebugMode) {
      //     print('USERSSS$value');
      //   }
      // });
    });
  }

  convertToInt(String input) {
    int.parse(input);
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void navigateToEstatePage() {
    _navigationService.navigateTo(Routes.ESTATE_VIEW);
  }

  void navigateToPercentagePage() {
    _navigationService.navigateTo(Routes.PERCENTAGE_VIEW);
  }

  void navigateBack() {
    _navigationService.goBack();
  }

  void navigateSearch() {
    _navigationService.popAndPush(Routes.SEARCH_VIEW);
  }

  String userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    'DEL',
  ];

  onTapButton(int index) {
    userInput += buttons[index];
    notifyListeners();
  }

  clearButton() {
    userInput = '';
    answer = '0';
    notifyListeners();
  }

  int? amountLeft;
  int? percentageLeft;
  String? uid;
  int? ownPercentage;
  int? currentBalance;
  int? investmentAmt;
  String? messages;

  Future<String> updateOwnedProperty(
      String? uid, String? pickedAddress, String? type) async {
    print('OWNEDPROPERTIES $ownPercentage');
    loading = true;
    notifyListeners();
    String returnValue = 'error';
    try {
      String _propertiesText = await databaseInfo.setAndUpdateProperties(
          uid: uid,
          address: pickedAddress,
          proportion: ownPercentage,
          type: type);
      String _messageText =
          await databaseInfo.updateUserMessage(uid: uid, message: messages);
      String returnString = await propertyDb.updatePropertyList(
          propertyName: "$pickedAddress",
          price: amountLeft,
          percentage: percentageLeft);
      String _updateUserBalanceText =
          await databaseInfo.updateUser(currentBalance, investmentAmt, uid);

      if (_propertiesText == "success" &&
          returnString == "success" &&
          _updateUserBalanceText == "success" &&
          _messageText == "success") {
        loading = false;
        await databaseInfo.getUserInfo(uid);
        _navigationService.navigateTo(Routes.HOME_SCREEN);
        notifyListeners();

        clearButton();
        returnValue = "success";
        // print('ALL DOCUMENT UPDATED ');
      }
    } on PlatformException catch (e) {
      loading = false;
      notifyListeners();
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> updateMessage(BuildContext context, String? uid,
      {String? message}) async {
    loading = true;
    notifyListeners();
    String returnValue = 'error';
    try {
      String _messageText =
          await databaseInfo.updateUserMessage(uid: uid, message: message);

      print('Interest Message $_messageText');

      if (_messageText == "success") {
        loading = false;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      loading = false;
      notifyListeners();
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> updateInterest(
      {String? email, String? address, String? uid}) async {
    loading = true;
    notifyListeners();
    String returnValue = 'error';

    try {
      String _propertiesText = await databaseInfo.setAndUpdateInterest(
          uid: uid, email: email, address: address);
      await databaseInfo.getUserInfo(uid);
      if (_propertiesText == "success") {
        loading = false;
        notifyListeners();
        _navigationService.navigateTo(Routes.HOME_SCREEN);
        returnValue = "success";
      }
    } on PlatformException catch (e) {
      loading = false;
      notifyListeners();
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String?> createTransaction(String email, String firstName,
      String lastName, String sales, String purchase, String amount) async {
    isLoading = true;
    notifyListeners();
    String returnValue = 'error';
    //UserModel? userModel = UserModel(_user!.uid, _user!.email);
    try {
      transaction!.email = email.trim();
      transaction!.firstName = firstName.trim();
      transaction!.lastName = lastName.trim();
      transaction!.sale = sales.trim();
      transaction?.purchase = purchase.trim();
      transaction?.amount = amount.trim();
      String _returnString =
          await TransactionInfo().createTransaction(transaction!);
      print(_returnString);
      if (_returnString == "success") {
        isLoading = false;
        notifyListeners();
        _navigationService.navigateTo(Routes.HOME_SCREEN);
        //Navigator.pushNamed(context, Routes.HOME_SCREEN);
        clearButton();
        returnValue = "success";
        print('Firstore success');
      }
    } on PlatformException catch (e) {
      isLoading = false;
      notifyListeners();
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  bool load = false;
  FirebaseAuthentication firebaseProvider = FirebaseAuthentication();

  Future<String> logOutUser() async {
    loading = true;
    notifyListeners();
    String returnValue = 'error';
    try {
      bool logOut = await firebaseProvider.logout();

      if (logOut == true) {
        loading = false;
        notifyListeners();
        _navigationService.navigateTo(Routes.LOGIN_SCREEN);
        print('Property Purchase or Sell success');
      }
    } on PlatformException catch (e) {
      loading = false;
      notifyListeners();
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<void> deleteCurrentAccount(BuildContext context) async {
    load = true;
    notifyListeners();
    String returnString = 'User account cannot be deleted';
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Account Deleted'), duration: Duration(seconds: 5)));
      logOutUser();
      load = false;
      notifyListeners();
    } on PlatformException catch (e) {
      load = false;
      notifyListeners();
      returnString = e.toString();
    } catch (e) {
      print(e);
    }
  }
}
