import 'package:intl/intl.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.text,
    required this.releaseDate,
    required this.categoryId,
  });

  final String text;
  final String id;
  final DateTime releaseDate;
  final String categoryId;

  String day() {
    return DateFormat.d().format(releaseDate);
  }

  String month() {
    return DateFormat.MMMM().format(releaseDate);
  }

  String dayFullName() {
    return DateFormat.EEEE().format(releaseDate);
  }

  String releaseTimeFormatted() {
    return DateFormat.Hm().format(releaseDate);
  }
}
