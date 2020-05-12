// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleState _$VehicleStateFromJson(Map<String, dynamic> json) {
  return VehicleState(
    json['value'] as String,
    json['text'] as String,
    json['selected'] as bool,
  );
}

Map<String, dynamic> _$VehicleStateToJson(VehicleState instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
      'selected': instance.selected,
    };
