// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleGroup _$VehicleGroupFromJson(Map<String, dynamic> json) {
  return VehicleGroup(json['value'] as String, json['text'] as String,
      json['selected'] as bool);
}

Map<String, dynamic> _$VehicleGroupToJson(VehicleGroup instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
      'selected': instance.selected
    };
