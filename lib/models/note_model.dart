import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:modyfikacja_aplikacja/models/times_tamp_converter.dart';
part 'note_model.g.dart';
part 'note_model.freezed.dart';

@freezed
class NoteModel with _$NoteModel {
  factory NoteModel({
    @JsonKey(name: 'note') required String note,
    @JsonKey(name: 'id') required String id,
    @TimestampConverter() @JsonKey(name: 'date') required DateTime releaseDate,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
