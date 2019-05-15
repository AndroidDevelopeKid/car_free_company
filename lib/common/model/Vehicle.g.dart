// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
      json['logisticsCompany'] as String,
      json['vehicleCode'] as String,
      json['engineNumber'] as String,
      json['vehicleType'] as String,
      json['frameNumber'] as String,
      json['businessType'] as String,
      json['carType'] as String,
      json['joinDate'] as String,
      json['plateNumber'] as String,
      json['vehicleOwnerContactMode'] as String,
      json['vehicleOwnerIdNumber'] as String,
      json['vehicleOwnerName'] as String,
      json['vehicleStatus'] as String);
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'vehicleCode': instance.vehicleCode,
      'plateNumber': instance.plateNumber,
      'logisticsCompany': instance.logisticsCompany,
      'vehicleType': instance.vehicleType,
      'businessType': instance.businessType,
      'carType': instance.carType,
      'vehicleStatus': instance.vehicleStatus,
      'vehicleOwnerName': instance.vehicleOwnerName,
      'vehicleOwnerIdNumber': instance.vehicleOwnerIdNumber,
      'vehicleOwnerContactMode': instance.vehicleOwnerContactMode,
      'frameNumber': instance.frameNumber,
      'engineNumber': instance.engineNumber,
      'joinDate': instance.joinDate
    };
