import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/enum/auth_state.dart';
import 'package:untitled8/model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/services/firebase_authentication.dart';
import 'package:untitled8/services/navigation_service.dart';
import 'package:untitled8/views/authScreen/login_screen.dart';
import 'package:untitled8/views/bottomNavScreen/home_screen.dart';

import '../locator.dart';
import '../routes/route.dart';

class AuthViewModel extends BaseModel {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController latNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  NavigationService? navigationService;
  final formKey = GlobalKey<FormState>();

  bool obscureText = false;
  bool obscure = false;

  void toggle() {
    obscureText = !obscureText;

    notifyListeners();
  }

  void toggleButton() {
    obscure = !obscure;
    notifyListeners();
  }

  bool isLoading = false;
  LoadingState _loadingState = LoadingState.DONE;
  final firebaseAuth = FirebaseAuthentication();

  LoadingState get loadingState => _loadingState;

  void signUpUser(
      {required SignUpType type,
      String? email,
      String? password,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      BuildContext? context}) async {
    //Provider.of<FirebaseAuthentication>(context!, listen: false);
    isLoading = true;
    notifyListeners();
    try {
      String? _returnString;
      switch (type) {
        case SignUpType.email:
          _returnString = await firebaseAuth.createUser(
              emailAddressController.text,
              confirmPassController.text,
              firstNameController.text,
              latNameController.text,
              phoneNoController.text);
          break;

        case SignUpType.google:
          _returnString = await firebaseAuth.logInUserWithGoogle();
          break;
        default:
      }
      if (_returnString == 'success') {
        isLoading = false;
        notifyListeners();
        Navigator.push(
            context!, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text(_returnString!), duration: Duration(seconds: 5)));
      }
    } catch (e) {}
  }

  Future<void> resetPassword({String? email, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    String returnError = 'Error';
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email!)
          .then((value) => {
                ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
                    content: Text('Email sent Successful'),
                    duration: Duration(seconds: 5))),
              });
      isLoading = false;
      notifyListeners();
    } on PlatformException catch (e) {
      loading = false;
      notifyListeners();
      e.toString();
    } catch (e) {
      print(e);
    }
  }

  FirebaseAuthentication firebaseProvider = FirebaseAuthentication();
  void loginUser(
      {@required LoginType? type,
      String? email,
      String? password,
      BuildContext? context}) async {
    try {
      String? _returnString;
      String _messageText;
      UserCredential credential;
      switch (type) {
        case LoginType.email:
          _returnString = await firebaseProvider.loginUser(
              emailAddressController.text, passwordController.text);
          break;

        case LoginType.google:
          _returnString = await firebaseProvider.logInUserWithGoogle();
          break;
        default:
      }

      if (_returnString == 'success') {
        isLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text('Login Successful'), duration: Duration(seconds: 5)));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text(_returnString!), duration: Duration(seconds: 5)));
      }
    } catch (e) {}
  }

  bool loading = false;





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
}
