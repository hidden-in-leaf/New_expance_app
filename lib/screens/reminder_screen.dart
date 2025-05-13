import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/reminder_model.dart';
import '../services/firestore_service.dart';
import '../services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _repeatType = 'once';
  int? _customIntervalMonths;
  int? _timesPerDay;
  int? _daysRepeatCount;

  final _user = FirebaseAuth.instance.currentUser;
  final _firestoreService = FirestoreService();

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now();
    final scheduledDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    if (scheduledDate.isBefore(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Scheduled time is in the past")),
      );
      return;
    }

    final reminder = ReminderModel(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      note: _noteController.text.trim(),
      datetime: scheduledDate,
      repeatType: _repeatType,
      customIntervalMonths:
          _repeatType == 'custom' ? _customIntervalMonths : null,
      timesPerDay: _repeatType == 'daily' ? _timesPerDay : null,
      daysRepeatCount: _repeatType == 'daily' ? _daysRepeatCount : null,
      userId: _user!.uid,
    );

    await NotificationService.scheduleReminder(
      id: 1,
      title: 'Pay Electricity Bill',
      body: 'Reminder to pay your electricity bill',
      scheduledDate: DateTime(2025, 5, 9, 17, 17),
      repeatType:
          'once', // Options: oneTime, daily, monthly, quarterly, yearly, custom
    );

    await _firestoreService.addReminder(reminder);
    await NotificationService.scheduleReminder(
      id: 1,
      title: 'Pay Electricity Bill',
      body: 'Reminder to pay your electricity bill',
      scheduledDate: DateTime(2025, 5, 9, 17, 16),
      repeatType:
          'once', // Options: oneTime, daily, monthly, quarterly, yearly, custom
    );

    //------

//   For a custom repeat every 3 months, for example:

// dart
// Copy
// await NotificationService.scheduleReminder(
//   id: 2,
//   title: 'Quarterly Maintenance',
//   body: 'Check water filter',
//   scheduledDate: DateTime(2025, 6, 10, 10, 0),
//   repeatType: 'custom',
//   customMonths: 3,
// );
// For a daily reminder 3 times per day for 10 days:

// dart
// Copy
// await NotificationService.scheduleReminder(
//   id: 3,
//   title: 'Take Medicine',
//   body: 'Time to take your medicine',
//   scheduledDate: DateTime(2025, 6, 10, 8, 0), // First trigger
//   repeatType: 'daily',
//   timesPerDay: 3,
//   repeatForDays: 10,
// );

    //----

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text("Date"),
                subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: const Text("Time"),
                subtitle: Text(_selectedTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              DropdownButtonFormField<String>(
                value: _repeatType,
                decoration: const InputDecoration(labelText: "Repeat Type"),
                items: const [
                  DropdownMenuItem(value: 'once', child: Text('Once')),
                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                  DropdownMenuItem(
                      value: 'quarterly', child: Text('Quarterly')),
                  DropdownMenuItem(value: 'yearly', child: Text('Yearly')),
                  DropdownMenuItem(
                      value: 'custom', child: Text('Custom Months')),
                ],
                onChanged: (value) => setState(() => _repeatType = value!),
              ),
              if (_repeatType == 'custom')
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Custom Interval (Months)'),
                  onChanged: (val) => _customIntervalMonths = int.tryParse(val),
                ),
              if (_repeatType == 'daily') ...[
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Times Per Day'),
                  onChanged: (val) => _timesPerDay = int.tryParse(val),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Repeat Days Count'),
                  onChanged: (val) => _daysRepeatCount = int.tryParse(val),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Save Reminder"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
