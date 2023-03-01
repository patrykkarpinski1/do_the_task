import 'package:intl/intl.dart';

class NoteModel {
  NoteModel({required this.note, required this.id, required this.releaseDate});
  final String note;
  final String id;
  final DateTime releaseDate;
  String releaseDateFormatted() {
    return DateFormat.yMMMMd().format(releaseDate);
  }
}
