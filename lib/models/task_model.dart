import 'package:cloud_firestore/cloud_firestore.dart';
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
  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        categoryId = json['category_id'],
        releaseDate = (json['date'] as Timestamp).toDate();

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
