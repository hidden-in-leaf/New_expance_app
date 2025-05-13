import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reminder_model.dart';
import '../models/transaction_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get stream of transactions for a user
  Stream<List<TransactionModel>> getTransactions(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add new transaction
  Future<void> addTransaction(String userId, TransactionModel transaction) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add(transaction.toMap());
  }


  // Update existing transaction
  Future<void> updateTransaction(
      String userId, String transactionId, TransactionModel transaction) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .update(transaction.toMap());
  }

  // Delete transaction
  Future<void> deleteTransaction(String userId, String transactionId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .delete();
  }

   // Fetch all categories for a user (ID and name)
  Stream<Map<String, String>> getCategories(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      final categoriesMap = <String, String>{};
      for (var doc in snapshot.docs) {
        categoriesMap[doc.id] = doc['name'];
      }

      return categoriesMap;
    });
  }

  // // Add a new category
  // Future<void> addCategory(String userId, String categoryName) async {
  //   final categoryRef = _firestore.collection('users').doc(userId).collection('categories');
  //   await categoryRef.add({
  //     'name': categoryName,
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  // }

  Future<String> addCategory(String uid, String categoryName) async {
  final docRef = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('categories')
      .add({'name': categoryName});

  return docRef.id; // ✅ Return the Firestore-generated ID
}


  // Update category name (does not affect old transactions)
  Future<void> updateCategory(String userId, String categoryId, String newCategoryName) async {
    final categoryRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId);

    await categoryRef.update({
      'name': newCategoryName,
    });
  }

  // Delete a category (optional: handle how old transactions use this category)
  Future<void> deleteCategory(String userId, String categoryId) async {
    final categoryRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId);

    await categoryRef.delete();
    
    // Optionally, you can reset old transactions to "Others" or some default category.
    final transactionsRef = _firestore.collection('users').doc(userId).collection('transactions');
    final querySnapshot = await transactionsRef.where('categoryId', isEqualTo: categoryId).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'categoryId': 'defaultCategoryId', // Or "Others" as a fallback
      });
    }
  }

Future<void> addReminder(ReminderModel reminder) async {
  final doc = FirebaseFirestore.instance
      .collection('users')
      .doc(reminder.userId)
      .collection('reminders')
      .doc(reminder.id);

  await doc.set(reminder.toMap());
}

Future<void> updateReminder(ReminderModel reminder) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(reminder.userId)
      .collection('reminders')
      .doc(reminder.id)
      .update(reminder.toMap());
}

Future<void> deleteReminder(String userId, String reminderId) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('reminders')
      .doc(reminderId)
      .delete();
}

Stream<List<ReminderModel>> getReminders(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('reminders')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ReminderModel.fromMap(doc.data())).toList());
}

}
