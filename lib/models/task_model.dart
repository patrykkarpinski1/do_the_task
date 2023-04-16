import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '/models/times_tamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
class TaskModel with _$TaskModel {
  const TaskModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TaskModel({
    required String text,
    required String id,
    required String categoryId,
    @TimestampConverter() @JsonKey(name: 'date') required DateTime releaseDate,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

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
