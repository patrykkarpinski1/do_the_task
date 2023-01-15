import 'package:intl/intl.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.text,
    required this.releaseDate,
  });

  final String text;
  final String id;
  final DateTime releaseDate;

  String releaseDateFormatted() {
    return DateFormat.yMMMMd().format(releaseDate);
  }

  String releaseTimeFormatted() {
    return DateFormat.Hm().format(releaseDate);
  }
}
