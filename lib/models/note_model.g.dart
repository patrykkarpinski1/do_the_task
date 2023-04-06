// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteModel _$$_NoteModelFromJson(Map<String, dynamic> json) => _$_NoteModel(
      note: json['note'] as String,
      id: json['id'] as String,
      releaseDate:
          const TimestampConverter().fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$$_NoteModelToJson(_$_NoteModel instance) =>
    <String, dynamic>{
      'note': instance.note,
      'id': instance.id,
      'date': const TimestampConverter().toJson(instance.releaseDate),
    };
