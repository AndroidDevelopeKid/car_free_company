// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriverBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverBrief _$DriverBriefFromJson(Map<String, dynamic> json) {
  return DriverBrief(
      json['id'] as String,
      json['vehicleCode'] as String,
      json['driverIDNumber'] as String,
      json['driverName'] as String,
      json['driverPhone'] as String);
}

Map<String, dynamic> _$DriverBriefToJson(DriverBrief instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driverIDNumber': instance.driverIDNumber,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'vehicleCode': instance.vehicleCode
    };
