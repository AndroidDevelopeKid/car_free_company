// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlacePick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePick _$PlacePickFromJson(Map<String, dynamic> json) {
  return PlacePick(
    json['id'] as int,
    json['parentId'] as int,
    (json['place'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PlacePickToJson(PlacePick instance) => <String, dynamic>{
      'parentId': instance.parentId,
      'id': instance.id,
      'place': instance.place,
    };
