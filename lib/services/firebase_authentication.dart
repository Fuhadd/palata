import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled8/constant/strings.dart';
import 'package:untitled8/model/transaction_model.dart';
import 'package:untitled8/model/user_model.dart';

import '../locator.dart';
import 'database.dart';

class FirebaseAuthentication {
  String? _firstName;
  String? _lastName;
  UserDetails? userDetails = UserDetails();
  TransactionModel? transaction = TransactionModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseInfo databaseInfo = locator<DatabaseInfo>();
  String message =
      'Congratulations on joining the Palata platform,  we’re glad to have you!';

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  auth.User? _user;

  UserModel? _firebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(user.uid, user.email);
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUser);
  }

  //Create Account
  Future<String?> createUser(String email, String password, String firstName,
      String lastName, String phoneNumber) async {
    String returnValue = 'error';
    String profileImage = userImage1;
    //UserModel? userModel = UserModel(_user!.uid, _user!.email);
    try {
      var rng = Random();
      var num = rng.nextInt(10);

      if (num % 2 == 0) {
        profileImage = userImage2;
      }

      auth.UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userDetails!.uid = credential.user!.uid;
      userDetails!.email = credential.user!.email;
      userDetails!.firstName = firstName.trim();
      userDetails!.lastName = lastName.trim();
      userDetails!.profileImage = profileImage;
      userDetails!.phone = phoneNumber.trim();
      //lastName = lastName.trim();
      String returnString =
          await DatabaseInfo().createUser(userDetails!, message);
      print(returnString);
      if (returnString == "success") {
        returnValue = "success";
        print('Firstore success');
      }
    } on PlatformException catch (e) {
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  //Create Account

  Future<String> logInUserWithGoogle() async {
    String returnValue = 'error';
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final auth.AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      auth.UserCredential authResult =
          await _auth.signInWithCredential(credential);
      if (authResult.additionalUserInfo!.isNewUser) {
        userDetails!.uid = authResult.user!.uid;
        userDetails!.email = authResult.user!.email;
        userDetails!.firstName = authResult.user!.displayName;
        userDetails!.profileImage = authResult.user!.photoURL;
        //userDetails!.accountCreated = Timestamp.now();
        DatabaseInfo().createUser(userDetails!, message);
      }
      await databaseInfo.getUserInfo(authResult.user!.uid);
      userDetails = await DatabaseInfo().getUserInfo(authResult.user!.uid);
      if (userDetails != null) {
        returnValue = "success";
      }
    } on PlatformException catch (e) {
      returnValue = e.toString();
    } catch (e) {
      print(e);
    }

    return returnValue;
  }

  //Login Firebase
  Future<String?> loginUser(String email, String password) async {
    String returnValue = 'error';
    try {
      auth.UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print(12333);
      await databaseInfo.getUserInfo(credential.user!.uid);

      print('USER ID ${credential.user!.uid}');
      //return _firebaseUser(credential.user);
      returnValue = 'success';
    } catch (e) {
      returnValue = e.toString();
    }
    return returnValue;
  }

  //SignOut Firebase
  Future<bool> logout() async {
    try {
      _firebaseAuth.signOut();
      return true;
    } on auth.FirebaseAuthException {
      return false;
    }
  }
}
