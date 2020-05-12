// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) {
  return VehicleModel(
    json['value'] as String,
    json['text'] as String,
    json['selected'] as bool,
  );
}

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
      'selected': instance.selected,
    };
