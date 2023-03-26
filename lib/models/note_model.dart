import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoteModel {
  NoteModel({required this.note, required this.id, required this.releaseDate});
  final String note;
  final String id;
  final DateTime releaseDate;
  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        note = json['note'],
        releaseDate = (json['date'] as Timestamp).toDate();
  String noteDate() {
    return DateFormat('dd.MM.yyyy').format(releaseDate);
  }
}
