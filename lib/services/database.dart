import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:untitled8/model/transaction_model.dart';
import 'package:untitled8/model/user_model.dart';

class DatabaseInfo {
  final String? uid;

  DatabaseInfo({this.uid});
  UserDetails? user;

  UserDetails? getUserDetails() {
    return user;
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserDetails userDetails = UserDetails();

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<String> createUser(UserDetails user, String message) async {
    String returnValue = 'error';
    Map messageMap = {"message": message, "date": Timestamp.now()};
    try {
      await _collectionReference.doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'phoneNumber': user.phone,
        'profileImage': user.profileImage,
        'accountCreated': Timestamp.now(),
        'userBalance': 30000000,
        'ownedProperties': [],
        'investmentAmount': 0,
        'Messages': FieldValue.arrayUnion([messageMap])
        //'ownedProperties': []
      });

      returnValue = 'success';
      print('Database success');
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> updateUserMessage({String? uid, String? message}) async {
    String returnValue = 'error';
    Map messageMap = {"date": Timestamp.now(), "message": message};

    try {
      _collectionReference.doc(uid).get().then((value) async {
        if (value.data().toString().contains("Messages") == false) {
          await _collectionReference.doc(uid).update({
            "Messages": FieldValue.arrayUnion([messageMap]),
          });
        } else {
          await _collectionReference.doc(uid).update({
            "Messages": FieldValue.arrayUnion([messageMap]),
          });
        }
      });

      returnValue = 'success';
      print('PROPERTY success');
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> setAndUpdateInterest(
      {String? uid, String? email, String? address}) async {
    String returnValue = 'error';
    Map showInterest = {
      "email": email,
      "address": address,
    };

    try {
      _collectionReference.doc(uid).get().then((value) async {
        if (value.data().toString().contains("interest") == true) {
          await _collectionReference.doc(uid).update({
            "interest": FieldValue.arrayUnion([showInterest]),
          });
        } else {
          DocumentSnapshot docSnapshot =
              await _collectionReference.doc(uid).get();
          Map<String, dynamic> values =
              docSnapshot.data() as Map<String, dynamic>;
          var interest = values["interest"] as List<dynamic>;
          for (int index = 0; index < interest.length; index++) {
            Map<String, dynamic> propertyList = interest[index];
            print('SHOW $propertyList ');
            if (propertyList["address"] == address) {
              propertyList["address"] = address;

              await _collectionReference
                  .doc(uid)
                  .update({"interest": interest});
            }
          }
        }
      });

      returnValue = 'success';
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> setAndUpdateProperties(
      {String? uid, String? address, int? proportion, String? type}) async {
    String returnValue = 'error';
    Map owned = {
      "address": address,
      "proportion": proportion,
    };

    try {
      _collectionReference.doc(uid).get().then((value) async {
        if (value.data().toString().contains("ownedProperties") == false) {
          await _collectionReference.doc(uid).update({
            "ownedProperties": FieldValue.arrayUnion([owned]),
          });
        } else if (value.data().toString().contains(address!) == false) {
          await _collectionReference.doc(uid).update({
            "ownedProperties": FieldValue.arrayUnion([owned]),
          });
          // await _collectionReference.doc(uid).update({
          //   "ownedProperties": FieldValue.arrayUnion([owned]),
          // });

        } else if (value.data().toString().contains("proportion") == 0) {
          await _collectionReference.doc(uid).update({
            "ownedProperties": FieldValue.arrayRemove([owned]),
          });
        } else {
          DocumentSnapshot docSnapshot =
              await _collectionReference.doc(uid).get();
          Map<String, dynamic> values =
              docSnapshot.data() as Map<String, dynamic>;
          print('SHOW $values');
          var properties = values["ownedProperties"] as List<dynamic>;
          for (int index = 0; index < properties.length; index++) {
            Map<String, dynamic> propertyList = properties[index];
            print('SHOW $propertyList ');
            if (propertyList["address"] == address && type == 'Buy') {
              propertyList["proportion"] += proportion;
              // propertyList["proportion"] = type == 'Buy'
              //     ? propertyList["proportion"] += proportion
              //     : propertyList["proportion"] -= proportion;

              await _collectionReference
                  .doc(uid)
                  .update({"ownedProperties": properties});
            } else {
              await _collectionReference.doc(uid).update({
                "ownedProperties": FieldValue.arrayRemove([owned]),
              });
            }
            //value.data().toString().contains(address!) == true
            //propertyList["address"].toString().contains(address!) == true

          }

          print("UPDATED PROPERTY LLLLL$properties");
        }
      });

      returnValue = 'success';
      print('PROPERTY success');
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<String> updateUser(
      int? userBalance, int? investmentAmount, String? uid) async {
    String returnValue = 'error';

    try {
      await _collectionReference.doc(uid).update(
          {'userBalance': userBalance, 'investmentAmount': investmentAmount});

      returnValue = 'success';
      print('Database success');
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<UserDetails> getUserInfo(String? uid) async {
    String? firstName;

    try {
      DocumentSnapshot _docSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userDetails.uid = uid;
      userDetails.firstName = firstName;
      print(34444);
      // print(_docSnap.data());
      userDetails.firstName = _docSnap["firstName"];
      print(1);

      userDetails.email = _docSnap["email"];
      print(2);
      userDetails.lastName = _docSnap["lastName"];
      print(3);
      userDetails.profileImage = _docSnap["profileImage"];
      print(4);
      userDetails.userBalance = _docSnap["userBalance"];
      print(5);
      userDetails.accountCreated = _docSnap["accountCreated"];
      print(6);
      userDetails.ownedProperties = _docSnap["ownedProperties"];
      print(7);
      userDetails.investmentAmount = _docSnap["investmentAmount"];
      print(8);

      if (kDebugMode) {
        //print("OWNED ${userDetails.ownedProperties}");
        // print("USER DETAILS ${_docSnap.data()}");
        //print('NAME ${userDetails.userBalance}');
      }
    } catch (e) {
      print(e);
    }
    return userDetails;
  }

  UserDetails _userInfo(DocumentSnapshot snapshot) {
    return UserDetails(
      uid: uid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      ownedProperties: snapshot['ownedProperties'],
      accountCreated: snapshot['accountCreated'],
    );
  }

  Stream<UserDetails> get userData {
    return _collectionReference.doc(uid).snapshots().map(_userInfo);
  }
}

class TransactionInfo {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('transaction');

  Future<String> createTransaction(TransactionModel transaction) async {
    String returnValue = 'error';

    try {
      await _collectionReference.doc().set({
        'firstName': transaction.firstName,
        'lastName': transaction.lastName,
        'email': transaction.email,
        'sale': transaction.sale,
        'amount': transaction.amount,
        'timeStamp': Timestamp.now(),
        'purchase': transaction.purchase
      });

      returnValue = 'success';
      //print('Database success');
    } catch (e) {
      print(e);
    }
    return returnValue;
  }

  Future<TransactionModel> getUserInfo(String uid) async {
    TransactionModel transDetails = TransactionModel();

    try {
      DocumentSnapshot _docSnap = await FirebaseFirestore.instance
          .collection('transaction')
          .doc()
          .get();
      transDetails.firstName = _docSnap["firstName"];
      transDetails.lastName = _docSnap["lastName"];
      transDetails.email = _docSnap["email"];
      transDetails.purchase = _docSnap["purchase"];
      transDetails.sale = _docSnap["sale"];
      transDetails.transactionCreated = _docSnap["timeStamp"];
    } catch (e) {
      print(e);
    }
    return transDetails;
  }

  TransactionModel _transactionInfo(DocumentSnapshot snapshot) {
    return TransactionModel(
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName'],
        email: snapshot['email'],
        sale: snapshot['sale'],
        purchase: snapshot['purchase'],
        amount: snapshot['amount'],
        transactionCreated: snapshot['timeStamp']
        // uid: uid,
        // firstName: snapshot['firstName'],
        // lastName: snapshot['lastName'],
        // email: snapshot['email'],
        // accountCreated: snapshot['accountCreated'],
        );
  }

  Stream<TransactionModel> get userData {
    return _collectionReference.doc().snapshots().map(_transactionInfo);
  }
}
