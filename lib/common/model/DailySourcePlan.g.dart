// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailySourcePlan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailySourcePlan _$DailySourcePlanFromJson(Map<String, dynamic> json) {
  return DailySourcePlan(
      json['customer'] as String,
      json['estimatedTotalTon'] as String,
      json['estimatedTotalVehicles'] as String,
      json['goods'] as String,
      json['loadPlace'] as String,
      json['planDate'] as String,
      json['unloadPlace'] as String);
}

Map<String, dynamic> _$DailySourcePlanToJson(DailySourcePlan instance) =>
    <String, dynamic>{
      'customer': instance.customer,
      'loadPlace': instance.loadPlace,
      'unloadPlace': instance.unloadPlace,
      'goods': instance.goods,
      'estimatedTotalTon': instance.estimatedTotalTon,
      'estimatedTotalVehicles': instance.estimatedTotalVehicles,
      'planDate': instance.planDate
    };
