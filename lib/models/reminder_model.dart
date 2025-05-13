class ReminderModel {
  final String id;
  final String title;
  final String note;
  final DateTime datetime;
  final String repeatType; // once, daily, monthly, quarterly, yearly, custom
  final int? customIntervalMonths;
  final int? timesPerDay;
  final int? daysRepeatCount;
  final String userId;

  ReminderModel({
    required this.id,
    required this.title,
    required this.note,
    required this.datetime,
    required this.repeatType,
    this.customIntervalMonths,
    this.timesPerDay,
    this.daysRepeatCount,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'note': note,
    'datetime': datetime.toIso8601String(),
    'repeatType': repeatType,
    'customIntervalMonths': customIntervalMonths,
    'timesPerDay': timesPerDay,
    'daysRepeatCount': daysRepeatCount,
    'userId': userId,
  };

  static ReminderModel fromMap(Map<String, dynamic> map) => ReminderModel(
    id: map['id'],
    title: map['title'],
    note: map['note'],
    datetime: DateTime.parse(map['datetime']),
    repeatType: map['repeatType'],
    customIntervalMonths: map['customIntervalMonths'],
    timesPerDay: map['timesPerDay'],
    daysRepeatCount: map['daysRepeatCount'],
    userId: map['userId'],
  );
}
