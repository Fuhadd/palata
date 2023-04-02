import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled8/model/estate_model.dart';
import 'package:untitled8/model/message_model.dart';

class EstateService {
  final EstateModel _estateModel = EstateModel();
  List<EstateModel>? estate = [];
  Property? property = Property();
  final List<EstateModel> _estate = [];

  List<EstateModel> getEstateList() {
    return _estate;
  }

  Future<List<EstateModel>?> getEstate() async {
    DocumentSnapshot estateSnapshot = await FirebaseFirestore.instance
        .collection("estate")
        .doc("collection")
        .get();

    print(estateSnapshot.data()); // to debug and see if data is returned

    Map<String, dynamic> values = estateSnapshot.data() as Map<String, dynamic>;
    var apartmentCategory = values['data'] as List<dynamic>;

    ///print("DATA${apartmentCategory}");
    // print('PROPERTY ${estateSnapshot.data()}');

    for (var value in apartmentCategory) {
      //_estateModel = EstateModel.fromJson(value);
      estate!.add(EstateModel.fromJson(value));
    }
    return estate;
  }

  Future<void> saveestate({
    required String address,
    required String amountLeft,
    required int availablePercentage,
    required int currentPrice,
    required String description,
    required List<Map> earn,
    required String image,
    required List<Map> images,
    required String monthlyIncome,
    required String monthlyReturn,
    required String percentage,
    required String percentageReturn,
    required String purchaseDate,
    required int purchasePrice,
    required String totalReturn,
    required String type,
    required String yearBuilt,
  }) async {
    DocumentReference estateSnapshot =
        FirebaseFirestore.instance.collection("estate").doc("collection");
    print(1334234345);
    try {
      await estateSnapshot.set(
          {
            'address': address,
            'amountLeft': amountLeft,
            'availablePercentage': availablePercentage,
            'currentPrice': currentPrice,
            'description': description,
            'earn': earn,
            'image': image,
            'images': images,
            'monthlyIncome': monthlyIncome,
            'monthlyReturn': monthlyReturn,
            'percentage': percentage,
            'percentageReturn': percentageReturn,
            'purchaseDate': purchaseDate,
            'purchasePrice': purchasePrice,
            'totalReturn': totalReturn,
            'type': type,
            'yearBuilt': yearBuilt,
            // 'matchedUsers': [uid.toString()]',
          },
          SetOptions(
            merge: true,
          ));
      return;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<EstateModel>?> filterEstate(String? data) async {
    CollectionReference estateSnapshot =
        FirebaseFirestore.instance.collection("estate");
    final cities = estateSnapshot
        .where("data", arrayContainsAny: ["type", data]).snapshots();

    //print(" FILTER RESULT ${cities.toString()}");
    // var apartmentCategory = value as List<dynamic>;
    // print("DATA${apartmentCategory}");
    // for (var value in apartmentCategory) {
    //   //_estateModel = EstateModel.fromJson(value);
    //   estate!.add(EstateModel.fromJson(value));
    // }

    return estate;
  }

  Future<String> updatePropertyList(
      {required String propertyName,
      required int? percentage,
      required int? price}) async {
    String returnValue = 'error';

    try {
      CollectionReference estateSnapshot =
          FirebaseFirestore.instance.collection("estate");
      DocumentSnapshot docSnapshot =
          await estateSnapshot.doc("collection").get();
      Map<String, dynamic> values = docSnapshot.data() as Map<String, dynamic>;
      var apartmentCategory = values['data'] as List<dynamic>;

      for (int index = 0; index < apartmentCategory.length; index++) {
        Map<String, dynamic> propertyList = apartmentCategory[index];
        if (propertyList["address"] == propertyName) {
          propertyList["availablePercentage"] = percentage;
          //propertyList["purchasePrice"] = price;
        }
      }

      await estateSnapshot
          .doc("collection")
          .update({"data": apartmentCategory});
      returnValue = 'success';
      //print("PROPERTY ALL$apartmentCategory");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return returnValue;
  }
}

// static final Firestore dbReference = Firestore.instance;
//
// static Future<void> currentUserChatroomChangeMuteOrFavouriteMethod({
// @required String chatroomId,
// @required bool muteValue,
// @required bool favouriteValue,
// @required ChatroomMuteFavouriteOption operationToBeDone,
// }) async {
//
// DocumentReference docRef = dbReference
//     .collection("user_chatrooms")
//     .document(CurrentUserDetails.id);
//
// DocumentSnapshot docSnapshot = await docRef.get();
// Map<String, dynamic> docData = docSnapshot.data;
//
// List<Map<String, dynamic>> userChatrooms =
// (docData["chatrooms"] as List<dynamic>)
//     .map((chatroom) => Map<String, dynamic>.from(chatroom))
//     .toList();
//
// for (int index = 0; index < userChatrooms.length; index++) {
// Map<String, dynamic> chatroom = userChatrooms[index];
// if (chatroom["chatroomId"] == chatroomId) {
// if (operationToBeDone == ChatroomMuteFavouriteOption.muteOperation) {
// chatroom["isMuted"] = !muteValue;
// } else {
// chatroom["isMarkedFavourite"] = !favouriteValue;
// }
//
// break;
// }
// }
//
// await docRef.updateData({"chatrooms": userChatrooms});
// }
class MessageService {
  MessageModel _messageModel = MessageModel();
  final List<MessageModel> _message = [];

  List<MessageModel> getMessageList() {
    return _message;
  }

  Future<void> getMessage() async {
    DocumentSnapshot messageSnapshot = await FirebaseFirestore.instance
        .collection("estate")
        .doc("message")
        .get();

    print(messageSnapshot.data()); // to debug and see if data is returned

    Map<String, dynamic> values =
        messageSnapshot.data() as Map<String, dynamic>;
    var messageCategory = values['data'] as List<dynamic>;
    print("DATA$messageCategory");

    for (var value in messageCategory) {
      _messageModel = MessageModel.fromJson(value);
      _message.add(_messageModel);
    }
  }
}
