// import 'package:aexpences/screens/reminder_screen.dart';
// import 'package:aexpences/services/utilitis.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/auth_service.dart';
// import 'add_transaction_screen.dart';
// import 'analytics_screen.dart';
// import '../services/firestore_service.dart';
// import '../models/transaction_model.dart';
// import '../widgets/transaction_tile.dart';
// import 'package:intl/intl.dart'; // For formatting dates

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   final AuthService _authService = AuthService();
//   final FirestoreService _firestoreService = FirestoreService();
//   User? user;
//   TextEditingController _searchController = TextEditingController();
//   late TabController _tabController;
//   List<TransactionModel> _filteredTransactions = [];
//   final _user = FirebaseAuth.instance.currentUser;

//   @override
//   void initState() {
//     super.initState();
//     user = _authService.getCurrentUser();
//     _tabController = TabController(length: 4, vsync: this);

//     // Listen for search changes
//     _searchController.addListener(() {
//       setState(() {
//         // Filter transactions based on the search query
//       });
//     });

//     _firestoreService.getCategories(_user!.uid).listen((newCategories) {
//       setState(() {
//         globalCategories = newCategories;
//       });
//     });
//   }

//   void _signOut() async {
//     await _authService.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (user == null) return const SizedBox();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Transactions"),
//         actions: [

//           IconButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const AddReminderScreen()),
//             ),
//             icon: const Icon(Icons.notifications),
//           ),

//           IconButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
//             ),
//             icon: const Icon(Icons.pie_chart),
//           ),
//           IconButton(
//             onPressed: _signOut,
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: "All Entries"),
//             Tab(text: "By Day"),
//             Tab(text: "By Month"),
//             Tab(text: "By Year"),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search transactions...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<TransactionModel>>(
//               stream: _firestoreService.getTransactions(user!.uid),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError)
//                   return const Text("Error loading transactions");
//                 if (!snapshot.hasData)
//                   return const Center(child: CircularProgressIndicator());

//                 final transactions = snapshot.data!;

//                 // Apply search filter
//                 if (_searchController.text.isNotEmpty) {
//                   _filteredTransactions = transactions
//                       .where((transaction) =>
//                           transaction.description
//                               .toLowerCase()
//                               .contains(_searchController.text.toLowerCase()) ||
//                           globalCategories[transaction.categoryId]!
//                               .toLowerCase()
//                               .contains(_searchController.text.toLowerCase()))
//                       .toList();
//                 } else {
//                   _filteredTransactions = transactions;
//                 }

//                 // Handle TabBar views
//                 return TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildAllEntriesTab(transactions),
//                     _buildGroupedByDayTab(),
//                     _buildGroupedByMonthTab(),
//                     _buildGroupedByYearTab(),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
//         ),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildAllEntriesTab(List<TransactionModel> transactions) {
//     final totalAmount =
//         transactions.fold(0.0, (sum, transaction) => sum + transaction.amount);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Total: \$${totalAmount.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 18)),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: _filteredTransactions.length,
//             itemBuilder: (context, index) {
//               return TransactionTile(
//                 transaction: _filteredTransactions[index],
//                 onDelete: () => _firestoreService.deleteTransaction(
//                     user!.uid, _filteredTransactions[index].id),
//                 onEdit: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => AddTransactionScreen(
//                       existingTransaction: _filteredTransactions[index],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGroupedByDayTab() {
//     Map<String, double> dailyTotal = {};
//     for (var transaction in _filteredTransactions) {
//       String date = DateFormat('yyyy-MM-dd').format(transaction.date);
//       dailyTotal[date] = (dailyTotal[date] ?? 0.0) + transaction.amount;
//     }

//     return _buildGroupedTab(dailyTotal);
//   }

//   Widget _buildGroupedByMonthTab() {
//     Map<String, double> monthlyTotal = {};
//     for (var transaction in _filteredTransactions) {
//       String month = DateFormat('yyyy-MM').format(transaction.date);
//       monthlyTotal[month] = (monthlyTotal[month] ?? 0.0) + transaction.amount;
//     }

//     return _buildGroupedTab(monthlyTotal);
//   }

//   Widget _buildGroupedByYearTab() {
//     Map<String, double> yearlyTotal = {};
//     for (var transaction in _filteredTransactions) {
//       String year = DateFormat('yyyy').format(transaction.date);
//       yearlyTotal[year] = (yearlyTotal[year] ?? 0.0) + transaction.amount;
//     }

//     return _buildGroupedTab(yearlyTotal);
//   }

//   Widget _buildGroupedTab(Map<String, double> groupedTotal) {
//     return ListView.builder(
//       itemCount: groupedTotal.length,
//       itemBuilder: (context, index) {
//         String key = groupedTotal.keys.elementAt(index);
//         double total = groupedTotal[key]!;
//         return ListTile(
//           title: Text(key),
//           trailing: Text('\$${total.toStringAsFixed(2)}'),
//         );
//       },
//     );
//   }
// }

import 'package:aexpences/screens/reminder_screen.dart';
import 'package:aexpences/services/utilitis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../widgets/delete_dialouge.dart';
import 'add_transaction_screen.dart';
import 'analytics_screen.dart';
import '../services/firestore_service.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  User? user;
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  List<TransactionModel> _filteredTransactions = [];
  final _user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    user = _authService.getCurrentUser();
    _tabController = TabController(length: 4, vsync: this);

    // Listen for search changes
    _searchController.addListener(() {
      setState(() {
        // Filter transactions based on the search query
      });
    });

    _firestoreService.getCategories(_user!.uid).listen((newCategories) {
      setState(() {
        globalCategories = newCategories;
      });
    });
  }

  void _signOut() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return const SizedBox();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              radius: 20,
              child: Text(
                user!.email?.substring(0, 1).toUpperCase() ?? "U",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  user!.email?.split('@')[0] ?? "User",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddReminderScreen()),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: _firestoreService.getTransactions(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return _buildErrorState("Error loading transactions");
          if (!snapshot.hasData)
            return const Center(
              child: CircularProgressIndicator(),
            );

          final transactions = snapshot.data!;

          // Apply search filter
          if (_searchController.text.isNotEmpty) {
            _filteredTransactions = transactions
                .where((transaction) =>
                    transaction.description
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()) ||
                    globalCategories[transaction.categoryId]!
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                .toList();
          } else {
            _filteredTransactions = transactions;
          }

          return Column(
            children: [
              _buildBalanceCard(transactions),
              _buildSearchBar(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAllEntriesTab(transactions),
                    _buildGroupedByDayTab(),
                    _buildGroupedByMonthTab(),
                    _buildGroupedByYearTab(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
      //   ),
      //   elevation: 2,
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(List<TransactionModel> transactions) {
    double totalIncome = transactions
        .where((transaction) => transaction.type == "income")
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    double totalExpense = transactions
        .where((transaction) => transaction.type != "income")
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    double balance = totalIncome - totalExpense;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Color.fromARGB(255, 71, 148, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white.withOpacity(0.8),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "My Wallet",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "₹${balance.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceItem(
                  "Income",
                  totalIncome,
                  Icons.arrow_upward,
                  Colors.green[300]!,
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
                _buildBalanceItem(
                  "Expenses",
                  totalExpense,
                  Icons.arrow_downward,
                  Colors.red[300]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceItem(
      String title, double amount, IconData icon, Color iconColor) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "₹${amount.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search transactions...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Clip ripple to rounded shape
        child: Material(
          color: Colors.transparent,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.pressed)) {
                    return Theme.of(context).primaryColor.withOpacity(0.1);
                  }
                  return Colors.transparent;
                },
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Day"),
                Tab(text: "Month"),
                Tab(text: "Year"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllEntriesTab(List<TransactionModel> transactions) {
    if (_filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: _filteredTransactions.length,
        itemBuilder: (context, index) {
          final transaction = _filteredTransactions[index];

          // Group header logic
          final bool showHeader = index == 0 ||
              !_isSameDay(_filteredTransactions[index].date,
                  _filteredTransactions[index - 1].date);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader) ...[
                const SizedBox(height: 8),
                _buildDateHeader(transaction.date),
                const SizedBox(height: 8),
              ],
              _buildTransactionCard(transaction),
            ],
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateHeader(DateTime date) {
    final now = DateTime.now();
    String headerText;

    if (_isSameDay(date, now)) {
      headerText = "Today";
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      headerText = "Yesterday";
    } else {
      headerText = DateFormat('E, MMM d').format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        headerText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionModel transaction) {
    final categoryName = globalCategories[transaction.categoryId] ?? "Unknown";
    final IconData categoryIcon = _getCategoryIcon(categoryName);
    final Color categoryColor = _getCategoryColor(categoryName);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddTransactionScreen(
            existingTransaction: transaction,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Dismissible(
          key: Key(transaction.id),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            return await deleteDialouge(context);
          },
          onDismissed: (direction) {
            _firestoreService.deleteTransaction(user!.uid, transaction.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    categoryIcon,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      transaction.type == "income"
                          ? "+ ₹${transaction.amount.toStringAsFixed(2)}"
                          : "- ₹${transaction.amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: transaction.type == "income"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('h:mm a').format(transaction.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final categoryLower = category.toLowerCase();

    if (categoryLower.contains('food') || categoryLower.contains('grocery')) {
      return Icons.restaurant;
    } else if (categoryLower.contains('transport')) {
      return Icons.directions_car;
    } else if (categoryLower.contains('shopping')) {
      return Icons.shopping_cart;
    } else if (categoryLower.contains('bill') ||
        categoryLower.contains('utility')) {
      return Icons.receipt;
    } else if (categoryLower.contains('entertainment')) {
      return Icons.movie;
    } else if (categoryLower.contains('health')) {
      return Icons.favorite;
    } else if (categoryLower.contains('salary') ||
        categoryLower.contains('income')) {
      return Icons.attach_money;
    } else if (categoryLower.contains('travel')) {
      return Icons.flight;
    } else if (categoryLower.contains('education')) {
      return Icons.school;
    } else {
      return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    final categoryLower = category.toLowerCase();

    if (categoryLower.contains('food') || categoryLower.contains('grocery')) {
      return Colors.orange;
    } else if (categoryLower.contains('transport')) {
      return Colors.blue;
    } else if (categoryLower.contains('shopping')) {
      return Colors.purple;
    } else if (categoryLower.contains('bill') ||
        categoryLower.contains('utility')) {
      return Colors.indigo;
    } else if (categoryLower.contains('entertainment')) {
      return Colors.pink;
    } else if (categoryLower.contains('health')) {
      return Colors.red;
    } else if (categoryLower.contains('salary') ||
        categoryLower.contains('income')) {
      return Colors.green;
    } else if (categoryLower.contains('travel')) {
      return Colors.amber;
    } else if (categoryLower.contains('education')) {
      return Colors.cyan;
    } else {
      return Colors.teal;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "No transactions found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isNotEmpty
                ? "Try a different search term"
                : "Add your first transaction",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          if (_searchController.text.isEmpty)
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
              ),
              icon: const Icon(Icons.add),
              label: const Text("Add Transaction"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGroupedByDayTab() {
    Map<String, List<TransactionModel>> dailyTransactions = {};

    for (var transaction in _filteredTransactions) {
      String date = DateFormat('yyyy-MM-dd').format(transaction.date);
      if (!dailyTransactions.containsKey(date)) {
        dailyTransactions[date] = [];
      }
      dailyTransactions[date]!.add(transaction);
    }

    return _buildGroupedTabContent(dailyTransactions);
  }

  Widget _buildGroupedByMonthTab() {
    Map<String, List<TransactionModel>> monthlyTransactions = {};

    for (var transaction in _filteredTransactions) {
      String month = DateFormat('yyyy-MM').format(transaction.date);
      if (!monthlyTransactions.containsKey(month)) {
        monthlyTransactions[month] = [];
      }
      monthlyTransactions[month]!.add(transaction);
    }

    return _buildGroupedTabContent(monthlyTransactions);
  }

  Widget _buildGroupedByYearTab() {
    Map<String, List<TransactionModel>> yearlyTransactions = {};

    for (var transaction in _filteredTransactions) {
      String year = DateFormat('yyyy').format(transaction.date);
      if (!yearlyTransactions.containsKey(year)) {
        yearlyTransactions[year] = [];
      }
      yearlyTransactions[year]!.add(transaction);
    }

    return _buildGroupedTabContent(yearlyTransactions);
  }

  Widget _buildGroupedTabContent(
      Map<String, List<TransactionModel>> groupedTransactions) {
    if (groupedTransactions.isEmpty) {
      return _buildEmptyState();
    }

    // Sort the keys in reverse chronological order
    final sortedKeys = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: sortedKeys.length,
        itemBuilder: (context, index) {
          final dateKey = sortedKeys[index];
          final transactions = groupedTransactions[dateKey]!;

          // Calculate totals for this date group
          double totalIncome = transactions
              .where((t) => t.type == "income")
              .fold(0.0, (sum, t) => sum + t.amount);

          double totalExpense = transactions
              .where((t) => t.type != "income")
              .fold(0.0, (sum, t) => sum + t.amount);

          double balance = totalIncome - totalExpense;

          // Format the date based on tab type
          String formattedDate;
          if (dateKey.length == 10) {
            // Day format (yyyy-MM-dd)
            final date = DateFormat('yyyy-MM-dd').parse(dateKey);
            formattedDate = DateFormat('MMMM d, yyyy').format(date);
          } else if (dateKey.length == 7) {
            // Month format (yyyy-MM)
            final date = DateFormat('yyyy-MM').parse(dateKey);
            formattedDate = DateFormat('MMMM yyyy').format(date);
          } else {
            // Year format (yyyy)
            formattedDate = dateKey;
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        balance >= 0
                            ? "+ ₹${balance.toStringAsFixed(2)}"
                            : "- ₹${balance.abs().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: balance >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Income",
                          totalIncome,
                          Icons.arrow_upward,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          "Expenses",
                          totalExpense,
                          Icons.arrow_downward,
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Transactions (${transactions.length})",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...transactions
                      .take(3)
                      .map((t) => _buildMiniTransactionTile(t)),
                  if (transactions.length > 3)
                    TextButton(
                      onPressed: () {
                        // Show all transactions in this group
                      },
                      child: Text(
                        "View all ${transactions.length} transactions",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, double amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTransactionTile(TransactionModel transaction) {
    final categoryName = globalCategories[transaction.categoryId] ?? "Unknown";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getCategoryColor(categoryName).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(categoryName),
              color: _getCategoryColor(categoryName),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction.type == "income"
                ? "+₹${transaction.amount.toStringAsFixed(2)}"
                : "-₹${transaction.amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: transaction.type == "income" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
            );
          }
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
           const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            activeIcon: Icon(Icons.insert_chart),
            label: 'Analytics',
          ),
         
          // const BottomNavigationBarItem(
          //   icon: Icon(Icons.settings_outlined),
          //   activeIcon: Icon(Icons.settings),
          //   label: 'Settings',
          // ),
        ],
      ),
    );
  }
}
