// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      text: json['text'] as String,
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      releaseDate:
          const TimestampConverter().fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'id': instance.id,
      'category_id': instance.categoryId,
      'date': const TimestampConverter().toJson(instance.releaseDate),
    };
