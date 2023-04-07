import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo_note_model.freezed.dart';
part 'photo_note_model.g.dart';

@freezed
class PhotoNoteModel with _$PhotoNoteModel {
  factory PhotoNoteModel(
    String id,
    String photo,
  ) = _PhotoNoteModel;

  factory PhotoNoteModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoNoteModelFromJson(json);
}
