import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final double amount;
  final String categoryId;  // Use categoryId instead of category
  final String description;
  final String type;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.categoryId,  // Change here
    required this.description,
    required this.type,
    required this.date,
  });

  // Convert TransactionModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'categoryId': categoryId,  // Change here
      'description': description,
      'type': type,
      'date': date,
    };
  }

  // Create TransactionModel from Firestore snapshot
  factory TransactionModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TransactionModel(
      id: documentId,
      amount: map['amount'],
      categoryId: map['categoryId'],  // Change here
      description: map['description'],
      type: map['type'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
