import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAeqsAebeSjpgPUg-1QxUUD54yA99fMcfo",
          authDomain: "expenses-c41c5.firebaseapp.com",
          databaseURL: "https://expenses-c41c5-default-rtdb.firebaseio.com",
          projectId: "expenses-c41c5",
          storageBucket: "expenses-c41c5.firebasestorage.app",
          messagingSenderId: "418300017547",
          appId: "1:418300017547:web:a5672529387b61c147cd8e",
          measurementId: "G-JBB0MN2NC3"),
    );
  } else {
    await Firebase.initializeApp(); // Android & iOS
  }

  await NotificationService.init();

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
