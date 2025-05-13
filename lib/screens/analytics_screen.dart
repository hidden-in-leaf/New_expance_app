import 'package:aexpences/services/utilitis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/transaction_model.dart';
import '../widgets/pie_chart_widget.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _firestoreService = FirestoreService();
  final _user = FirebaseAuth.instance.currentUser;

  Map<String, double> categoryTotals = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final txs = await _firestoreService.getTransactions(_user!.uid).first;
    final Map<String, double> totals = {};

    for (var tx in txs) {
      if (tx.type == 'expense') {
        totals[globalCategories![tx.categoryId]!] = (totals[globalCategories[tx.categoryId]] ?? 0) + tx.amount;
      }
    }

    setState(() => categoryTotals = totals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChartWidget(dataMap: categoryTotals),
      ),
    );
  }
}
