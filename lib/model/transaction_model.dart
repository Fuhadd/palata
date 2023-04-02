import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? firstName;
  String? lastName;
  String? purchase;
  String? sale;
  String? email;
  String? amount;
  Timestamp? transactionCreated;

  TransactionModel(
      {this.firstName,
      this.lastName,
      this.purchase,
      this.sale,
      this.email,
      this.amount,
      this.transactionCreated});
}
