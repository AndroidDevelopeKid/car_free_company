// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailySourcePlan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailySourcePlan _$DailySourcePlanFromJson(Map<String, dynamic> json) {
  return DailySourcePlan(
      json['cargoCategoryText'] as String,
      json['customerName'] as String,
      json['expectedTotalTon'] as String,
      json['expectedTruckAmount'] as String,
      json['loadPlaceIdName'] as String,
      json['sourceDate'] as String,
      json['unloadPlaceIdName'] as String,
      json['id'] as String);
}

Map<String, dynamic> _$DailySourcePlanToJson(DailySourcePlan instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'loadPlaceIdName': instance.loadPlaceIdName,
      'unloadPlaceIdName': instance.unloadPlaceIdName,
      'cargoCategoryText': instance.cargoCategoryText,
      'expectedTotalTon': instance.expectedTotalTon,
      'expectedTruckAmount': instance.expectedTruckAmount,
      'sourceDate': instance.sourceDate,
      'id': instance.id
    };
