import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;

  String? phone;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;

  UserModel(this.uid, this.email);
}

class UserDetails {
  String? uid;
  String? authType;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? profileImage;
  int? userBalance;
  int? investmentAmount;
  List<dynamic>? ownedProperties;
  Timestamp? accountCreated;

  UserDetails(
      {this.uid,
      this.authType,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password,
      this.profileImage,
      this.userBalance,
        this.investmentAmount,
      this.ownedProperties,
      this.accountCreated});

  UserDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    userBalance = json['userBalance'];
    investmentAmount = json['investmentAmount'];
    lastName = json['lastName'];
    if (json['ownedProperties'] != null) {
      ownedProperties = <OwnedProperties>[];
      json['ownedProperties'].forEach((v) {
        ownedProperties!.add(new OwnedProperties.fromJson(v));
      });
      profileImage = json['profileImage'];
    }
    // return UserDetails(
    //     email: json['email'],
    //     firstName: json['firstName'],
    //     userBalance: json['userBalance'],
    //     lastName: json['lastName'],
    //     ownedProperties:  json['ownedProperties'].forEach((v) {
    //       ownedProperties!.add(new OwnedProperties.fromJson(v));
    //     });
    //     if (json['ownedProperties'] != null)
    // {
    //   ownedProperties = <RecentlyAdded>[];
    //   json['ownedProperties'].forEach((v) {
    //     ownedProperties!.add(new OwnedProperties.fromJson(v));
    //   });
    // }
    //     profileImage: json['profileImage']);
  }
}

class OwnedProperties {
  String? address;
  int? proportion;

  OwnedProperties({this.address, this.proportion});

  factory OwnedProperties.fromJson(Map<String, dynamic> json) {
    return OwnedProperties(
        address: json['address'], proportion: json['proportion']);
  }
}
