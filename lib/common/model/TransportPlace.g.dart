// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransportPlace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportPlace _$TransportPlaceFromJson(Map<String, dynamic> json) {
  return TransportPlace(
    json['id'] as int,
    json['parentId'] as int,
    json['text'] as String,
    json['value'] as String,
  );
}

Map<String, dynamic> _$TransportPlaceToJson(TransportPlace instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
      'parentId': instance.parentId,
      'id': instance.id,
    };
