// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/transaction_model.dart';
// import '../services/firestore_service.dart';

// class AddTransactionScreen extends StatefulWidget {
//   final TransactionModel? existingTransaction;

//   const AddTransactionScreen({super.key, this.existingTransaction});

//   @override
//   State<AddTransactionScreen> createState() => _AddTransactionScreenState();
// }

// class _AddTransactionScreenState extends State<AddTransactionScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _customCategoryController = TextEditingController();
//   String _type = 'expense';
//   String _categoryId = ''; // Store category ID instead of name
//   DateTime _selectedDate = DateTime.now();
//   Map<String, String> categories = {}; // Map to hold category ID -> name
//   final _firestoreService = FirestoreService();
//   final _user = FirebaseAuth.instance.currentUser;
//   bool _isCustomCategory = false; // Flag to determine if custom category is being added

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existingTransaction != null) {
//       final tx = widget.existingTransaction!;
//       _amountController.text = tx.amount.toString();
//       _descController.text = tx.description;
//       _categoryId = tx.categoryId;
//       _type = tx.type;
//       _selectedDate = tx.date;
//     }
//     // Fetch categories from Firestore (ID -> name mapping)
//     _firestoreService.getCategories(_user!.uid).listen((newCategories) {
//       setState(() {
//         categories = newCategories;
//       });
//     });
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     final tx = TransactionModel(
//       id: widget.existingTransaction?.id ?? '',
//       amount: double.parse(_amountController.text),
//       categoryId: _categoryId, // Store categoryId
//       description: _descController.text,
//       type: _type,
//       date: _selectedDate,
//     );

//     if (widget.existingTransaction != null) {
//       await _firestoreService.updateTransaction(_user!.uid, tx.id, tx);
//     } else {
//       await _firestoreService.addTransaction(_user!.uid, tx);
//     }

//     Navigator.pop(context);
//   }

//   void _pickDate() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (date != null) {
//       setState(() => _selectedDate = date);
//     }
//   }

//   void _addCustomCategory() async {
//   final categoryName = _customCategoryController.text.trim();
//   if (categoryName.isNotEmpty) {
//     // Create a unique ID for the new category (or use Firestore's generated ID)
//     final newCategoryId = 'newCategoryId_${DateTime.now().millisecondsSinceEpoch}';
    
//     // Add the category to Firestore
//     await _firestoreService.addCategory(_user!.uid, categoryName);

//     setState(() {
//       // Add new category to the map with the generated ID
//       categories[newCategoryId] = categoryName;
//       _categoryId = newCategoryId; // Set the new category as selected
//       _isCustomCategory = false; // Reset the custom category flag
//     });
//   }
//   _customCategoryController.clear();
// }


//   @override
//   Widget build(BuildContext context) {
//     final isEditing = widget.existingTransaction != null;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEditing ? "Edit Transaction" : "Add Transaction"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Amount'),
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Enter amount' : null,
//               ),
//               TextFormField(
//                 controller: _descController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               // Dropdown for selecting category
//               DropdownButtonFormField(
//                 value: _categoryId.isEmpty ? null : _categoryId,
//                 items: categories.entries
//                     .map((entry) => DropdownMenuItem(
//                           value: entry.key,
//                           child: Text(entry.value),
//                         ))
//                     .toList()
//                   ..add(DropdownMenuItem(
//                     value: 'addNewCategory',
//                     child: Text('Add New Category'),
//                   )),
//                 onChanged: (value) {
//                   if (value == 'addNewCategory') {
//                     setState(() {
//                       _isCustomCategory = true; // Show custom category input field
//                     });
//                   } else {
//                     setState(() {
//                       _categoryId = value!; // Set selected category ID
//                       _isCustomCategory = false; // Hide custom category input
//                     });
//                   }
//                 },
//                 decoration: const InputDecoration(labelText: 'Category'),
//               ),
//               // If adding custom category, show text input field
//               if (_isCustomCategory)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _customCategoryController,
//                         decoration: const InputDecoration(labelText: 'Custom Category'),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: _addCustomCategory,
//                     ),
//                   ],
//                 ),
//               ListTile(
//                 title: const Text('Transaction Type'),
//                 trailing: DropdownButton<String>(
//                   value: _type,
//                   items: const [
//                     DropdownMenuItem(value: 'expense', child: Text('Expense')),
//                     DropdownMenuItem(value: 'income', child: Text('Income')),
//                   ],
//                   onChanged: (value) => setState(() => _type = value!),
//                 ),
//               ),
//               ListTile(
//                 title: const Text('Date'),
//                 subtitle: Text(DateFormat.yMMMMd().format(_selectedDate)),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: _pickDate,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: Text(isEditing ? 'Update' : 'Add'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../models/transaction_model.dart';
import '../services/firestore_service.dart';
import 'dart:ui';

class AddTransactionScreen extends StatefulWidget {
  final TransactionModel? existingTransaction;

  const AddTransactionScreen({super.key, this.existingTransaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _customCategoryController = TextEditingController();
  String _type = 'expense';
  String _categoryId = '';
  DateTime _selectedDate = DateTime.now();
  Map<String, String> categories = {};
  final _firestoreService = FirestoreService();
  final _user = FirebaseAuth.instance.currentUser;
  bool _isCustomCategory = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
    );
    
    _animationController.forward();
    
    if (widget.existingTransaction != null) {
      final tx = widget.existingTransaction!;
      _amountController.text = tx.amount.toString();
      _descController.text = tx.description;
      _categoryId = tx.categoryId;
      _type = tx.type;
      _selectedDate = tx.date;
    }
    
    // Fetch categories from Firestore
    _firestoreService.getCategories(_user!.uid).listen((newCategories) {
      setState(() {
        categories = newCategories;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    _customCategoryController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final tx = TransactionModel(
        id: widget.existingTransaction?.id ?? '',
        amount: double.parse(_amountController.text),
        categoryId: _categoryId,
        description: _descController.text,
        type: _type,
        date: _selectedDate,
      );

      if (widget.existingTransaction != null) {
        await _firestoreService.updateTransaction(_user!.uid, tx.id, tx);
      } else {
        await _firestoreService.addTransaction(_user!.uid, tx);
      }

      // Close loading dialog
      Navigator.pop(context);
      
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingTransaction != null
                ? 'Transaction updated successfully'
                : 'Transaction added successfully',
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Close screen
      Navigator.pop(context);
    } catch (e) {
      // Close loading dialog
      Navigator.pop(context);
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _pickDate() async {
    final ThemeData theme = Theme.of(context);
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme,
            dialogBackgroundColor: theme.scaffoldBackgroundColor,
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }


void _addCustomCategory() async {
  final categoryName = _customCategoryController.text.trim();
  if (categoryName.isEmpty) return;

  try {
    // ✅ Add the category and get the document ID from Firestore
    final newCategoryId = await _firestoreService.addCategory(_user!.uid, categoryName);

    setState(() {
      categories[newCategoryId] = categoryName;
      _categoryId = newCategoryId;
      _isCustomCategory = false;
    });

    _customCategoryController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category added successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding category: ${e.toString()}'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}


  // void _addCustomCategory() async {
  //   if (_customCategoryController.text.trim().isEmpty) return;

  //   final categoryName = _customCategoryController.text.trim();
  //   // Create a unique ID for the new category
  //   final newCategoryId = 'newCategoryId_${DateTime.now().millisecondsSinceEpoch}';
    
  //   try {
  //     // Add the category to Firestore
  //     await _firestoreService.addCategory(_user!.uid, categoryName);

  //     setState(() {
  //       // Add new category to the map
  //       categories[newCategoryId] = categoryName;
  //       _categoryId = newCategoryId;
  //       _isCustomCategory = false;
  //     });
      
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('New category added'),
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error adding category: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //   }
    
  //   _customCategoryController.clear();
  // }


  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTransaction != null;
    final colorScheme = Theme.of(context).colorScheme;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Transaction" : "Add Transaction",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showDeleteConfirmation(),
              tooltip: 'Delete Transaction',
            ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  
                  // Transaction Type Selector
                  _buildTypeSelector(),
                  
                  const SizedBox(height: 24),
                  
                  // Amount Field
                  _buildAmountField(),
                  
                  const SizedBox(height: 16),
                  
                  // Category Selector
                  _buildCategorySelector(),
                  
                  // Custom Category Input
                  if (_isCustomCategory)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _buildCustomCategoryInput(),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Description Field
                  _buildDescriptionField(),
                  
                  const SizedBox(height: 16),
                  
                  // Date Selector
                  _buildDateSelector(),
                  
                  const SizedBox(height: 32),
                  
                  // Submit Button
                  _buildSubmitButton(isEditing),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.light 
          ? Colors.grey.shade100 
          : Colors.grey.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _type = 'expense'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _type == 'expense' 
                        ? Theme.of(context).colorScheme.error.withOpacity(0.8) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Expense',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: _type == 'expense'
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _type = 'income'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _type == 'income' 
                        ? Colors.green.shade600 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Income',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: _type == 'income'
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light 
            ? Colors.grey.shade50 
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: _type == 'expense' 
              ? Theme.of(context).colorScheme.error 
              : Colors.green.shade600,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.attach_money_rounded,
            color: _type == 'expense' 
                ? Theme.of(context).colorScheme.error 
                : Colors.green.shade600,
          ),
          hintText: '0.00',
          hintStyle: GoogleFonts.poppins(
            fontSize: 28,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        validator: (value) => 
            value == null || value.isEmpty ? 'Please enter an amount' : null,
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light 
            ? Colors.white 
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DropdownButtonFormField<String>(
          value: _categoryId.isEmpty ? null : _categoryId,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 28,
          elevation: 0,
          isExpanded: true,
          dropdownColor: Theme.of(context).brightness == Brightness.light 
              ? Colors.white 
              : Colors.grey.shade800,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.category_outlined),
            hintText: 'Select Category',
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          items: [
            ...categories.entries.map((entry) => DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value),
            )),
            const DropdownMenuItem(
              value: 'addNewCategory',
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, size: 16),
                  SizedBox(width: 8),
                  Text('Add New Category'),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            if (value == 'addNewCategory') {
              setState(() {
                _isCustomCategory = true;
              });
            } else {
              setState(() {
                _categoryId = value!;
                _isCustomCategory = false;
              });
            }
          },
          validator: (value) => 
              (value == null || value.isEmpty) ? 'Please select a category' : null,
        ),
      ),
    );
  }

  Widget _buildCustomCategoryInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light 
              ? Colors.white 
              : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _customCategoryController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.edit_outlined),
                  hintText: 'New Category Name',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: _addCustomCategory,
                tooltip: 'Add Category',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light 
            ? Colors.white 
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _descController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.description_outlined),
          hintText: 'Description',
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light 
              ? Colors.white 
              : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.calendar_today_outlined),
            const SizedBox(width: 16),
            Text(
              DateFormat.yMMMMd().format(_selectedDate),
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_rounded),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isEditing) {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        isEditing ? 'UPDATE TRANSACTION' : 'ADD TRANSACTION',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Transaction',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this transaction?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              
              try {
                await _firestoreService.deleteTransaction(
                  _user!.uid, 
                  widget.existingTransaction!.id,
                );
                
                // Close loading dialog
                Navigator.pop(context);
                
                // Close screen
                Navigator.pop(context);
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transaction deleted successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } catch (e) {
                // Close loading dialog
                Navigator.pop(context);
                
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete: ${e.toString()}'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(
              'DELETE',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}