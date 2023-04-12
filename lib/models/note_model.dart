import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'package:modyfikacja_aplikacja/models/times_tamp_converter.dart';
part 'note_model.g.dart';
part 'note_model.freezed.dart';

@freezed
class NoteModel with _$NoteModel {
  const NoteModel._();
  factory NoteModel({
    required String note,
    required String id,
    @TimestampConverter() @JsonKey(name: 'date') required DateTime releaseDate,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  String releaseDateFormatted() {
    return DateFormat('dd.MM.yyyy').format(releaseDate);
  }
}
