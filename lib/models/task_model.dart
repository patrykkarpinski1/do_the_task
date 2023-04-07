import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modyfikacja_aplikacja/models/times_tamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TaskModel({
    required String text,
    required String id,
    required String categoryId,
    @TimestampConverter() @JsonKey(name: 'date') required DateTime releaseDate,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
