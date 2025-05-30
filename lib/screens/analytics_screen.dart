// import 'package:aexpences/services/utilitis.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/firestore_service.dart';
// import '../models/transaction_model.dart';
// import '../widgets/pie_chart_widget.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   final _firestoreService = FirestoreService();
//   final _user = FirebaseAuth.instance.currentUser;

//   Map<String, double> categoryTotals = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   void _loadData() async {
//     final txs = await _firestoreService.getTransactions(_user!.uid).first;
//     final Map<String, double> totals = {};

//     for (var tx in txs) {
//       if (tx.type == 'expense') {
//         totals[globalCategories![tx.categoryId]!] = (totals[globalCategories[tx.categoryId]] ?? 0) + tx.amount;
//       }
//     }

//     setState(() => categoryTotals = totals);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Analytics'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: PieChartWidget(dataMap: categoryTotals),
//       ),
//     );
//   }
// }


import 'package:aexpences/services/utilitis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../models/transaction_model.dart';
import '../widgets/pie_chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with TickerProviderStateMixin {
  final _firestoreService = FirestoreService();
  final _user = FirebaseAuth.instance.currentUser;

  late TabController _tabController;
  late AnimationController _animationController;
  
  Map<String, double> categoryTotals = {};
  Map<String, double> monthlyExpenses = {};
  Map<String, double> monthlyIncome = {};
  List<TransactionModel> allTransactions = [];
  
  String selectedPeriod = 'This Month';
  String selectedChart = 'Categories';
  bool isLoading = true;
  
  double totalExpenses = 0;
  double totalIncome = 0;
  double avgDailySpend = 0;
  String topCategory = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _loadData();
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadData() async {
    setState(() => isLoading = true);
    
    try {
      final txs = await _firestoreService.getTransactions(_user!.uid).first;
      allTransactions = _filterTransactionsByPeriod(txs);
      
      _calculateCategoryTotals();
      _calculateMonthlyData();
      _calculateSummaryStats();
      
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
    
    setState(() => isLoading = false);
  }

  List<TransactionModel> _filterTransactionsByPeriod(List<TransactionModel> transactions) {
    final now = DateTime.now();
    DateTime startDate;
    
    switch (selectedPeriod) {
      case 'This Week':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'This Month':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Last 3 Months':
        startDate = DateTime(now.year, now.month - 3, 1);
        break;
      case 'This Year':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        return transactions;
    }
    
    return transactions.where((tx) => tx.date.isAfter(startDate)).toList();
  }

  void _calculateCategoryTotals() {
    final Map<String, double> expenseTotals = {};
    
    for (var tx in allTransactions) {
      if (tx.type == 'expense') {
        final categoryName = globalCategories![tx.categoryId] ?? 'Other';
        expenseTotals[categoryName] = (expenseTotals[categoryName] ?? 0) + tx.amount;
      }
    }
    
    categoryTotals = expenseTotals;
  }

  void _calculateMonthlyData() {
    final Map<String, double> expenses = {};
    final Map<String, double> income = {};
    
    for (var tx in allTransactions) {
      final monthKey = '${tx.date.month}/${tx.date.year}';
      
      if (tx.type == 'expense') {
        expenses[monthKey] = (expenses[monthKey] ?? 0) + tx.amount;
      } else {
        income[monthKey] = (income[monthKey] ?? 0) + tx.amount;
      }
    }
    
    monthlyExpenses = expenses;
    monthlyIncome = income;
  }

  void _calculateSummaryStats() {
    totalExpenses = allTransactions
        .where((tx) => tx.type == 'expense')
        .fold(0, (sum, tx) => sum + tx.amount);
    
    totalIncome = allTransactions
        .where((tx) => tx.type == 'income')
        .fold(0, (sum, tx) => sum + tx.amount);
    
    if (allTransactions.isNotEmpty) {
      final days = DateTime.now().difference(allTransactions.last.date).inDays + 1;
      avgDailySpend = totalExpenses / days;
    }
    
    if (categoryTotals.isNotEmpty) {
      topCategory = categoryTotals.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => selectedPeriod = value);
              _loadData();
            },
            icon: const Icon(Icons.calendar_today),
            itemBuilder: (context) => [
              'This Week',
              'This Month', 
              'Last 3 Months',
              'This Year'
            ].map((period) => PopupMenuItem(
              value: period,
              child: Text(period),
            )).toList(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Categories'),
            Tab(text: 'Trends'),
          ],
        ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(),
              _buildCategoriesTab(),
              _buildTrendsTab(),
            ],
          ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Selector
          _buildPeriodSelector(),
          const SizedBox(height: 16),
          
          // Summary Cards
          _buildSummaryCards(),
          const SizedBox(height: 20),
          
          // Quick Stats
          _buildQuickStats(),
          const SizedBox(height: 20),
          
          // Mini Charts
          _buildMiniCharts(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Chart Type Selector
          _buildChartTypeSelector(),
          const SizedBox(height: 20),
          
          // Main Chart
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            height: 350,
            child: selectedChart == 'Categories' 
              ? _buildPieChart()
              : _buildBarChart(),
          ),
          const SizedBox(height: 20),
          
          // Category List
          _buildCategoryList(),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Expense vs Income Chart
          _buildExpenseIncomeChart(),
          const SizedBox(height: 30),
          
          // Spending Pattern
          _buildSpendingPattern(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: ['This Week', 'This Month', 'Last 3 Months', 'This Year']
            .map((period) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => selectedPeriod = period);
                  _loadData();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: selectedPeriod == period 
                      ? Theme.of(context).primaryColor 
                      : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    period.split(' ').last,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedPeriod == period ? Colors.white : Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )).toList(),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Expenses',
            '₹${totalExpenses.toStringAsFixed(0)}',
            Icons.trending_down,
            Colors.red,
            0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            'Total Income',
            '₹${totalIncome.toStringAsFixed(0)}',
            Icons.trending_up,
            Colors.green,
            0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, double delay) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 24),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Stats',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('Avg. Daily', '₹${avgDailySpend.toStringAsFixed(0)}'),
              _buildStatItem('Top Category', topCategory.isNotEmpty ? topCategory : 'None'),
              _buildStatItem('Balance', '₹${(totalIncome - totalExpenses).toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildMiniCharts() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Expense Ratio', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Expanded(
                  child: categoryTotals.isNotEmpty
                    ? PieChartWidget(dataMap: categoryTotals, )
                    : const Center(child: Text('No data')),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Trend', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0.1)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.trending_up, color: Colors.blue, size: 32),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartTypeSelector() {
    return Row(
      children: ['Categories', 'Amount'].map((type) => 
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedChart = type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedChart == type 
                  ? Theme.of(context).primaryColor 
                  : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedChart == type ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildPieChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: categoryTotals.isNotEmpty
        ? PieChartWidget(dataMap: categoryTotals,)
        : const Center(child: Text('No expense data available')),
    );
  }

  Widget _buildBarChart() {
    if (categoryTotals.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(child: Text('No expense data available')),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: categoryTotals.values.isEmpty ? 0 : categoryTotals.values.reduce((a, b) => a > b ? a : b) * 1.2,
          barGroups: categoryTotals.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.value,
                  color: Colors.primaries[index % Colors.primaries.length],
                  width: 20,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final categories = categoryTotals.keys.toList();
                  if (value.toInt() < categories.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        categories[value.toInt()].length > 8 
                          ? '${categories[value.toInt()].substring(0, 8)}...'
                          : categories[value.toInt()],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text('₹${value.toInt()}', style: const TextStyle(fontSize: 10));
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Category Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...categoryTotals.entries.map((entry) => 
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.primaries[categoryTotals.keys.toList().indexOf(entry.key) % Colors.primaries.length].withOpacity(0.2),
                child: Icon(
                  Icons.category,
                  color: Colors.primaries[categoryTotals.keys.toList().indexOf(entry.key) % Colors.primaries.length],
                ),
              ),
              title: Text(entry.key),
              subtitle: Text('${((entry.value / totalExpenses) * 100).toStringAsFixed(1)}% of total'),
              trailing: Text(
                '₹${entry.value.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildExpenseIncomeChart() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense vs Income Trend',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: const FlTitlesData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: monthlyExpenses.entries.toList().asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: monthlyIncome.entries.toList().asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingPattern() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spending Insights',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            'Daily Average',
            '₹${avgDailySpend.toStringAsFixed(0)}',
            Icons.today,
            Colors.blue,
          ),
          _buildInsightItem(
            'Highest Category',
            topCategory.isNotEmpty ? topCategory : 'None',
            Icons.trending_up,
            Colors.orange,
          ),
          _buildInsightItem(
            'Savings Rate',
            totalIncome > 0 ? '${(((totalIncome - totalExpenses) / totalIncome) * 100).toStringAsFixed(1)}%' : '0%',
            Icons.savings,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}