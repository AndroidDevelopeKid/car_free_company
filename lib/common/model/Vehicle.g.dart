// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
      json['id'] as String,
      json['oUDisplayName'] as String,
      json['vehicleCode'] as String,
      json['engineNumber'] as String,
      json['vehicleTypeText'] as String,
      json['frameNumber'] as String,
      json['vehicleBusinessTypeText'] as String,
      json['modelsText'] as String,
      json['joiningDate'] as String,
      json['mainVehiclePlate'] as String,
      json['vehicleStateText'] as String,
      json['ownerName'] as String,
      json['ownerIDNumber'] as String,
      json['ownerPhone'] as String);
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'vehicleCode': instance.vehicleCode,
      'mainVehiclePlate': instance.mainVehiclePlate,
      'oUDisplayName': instance.oUDisplayName,
      'vehicleTypeText': instance.vehicleTypeText,
      'vehicleBusinessTypeText': instance.vehicleBusinessTypeText,
      'modelsText': instance.modelsText,
      'vehicleStateText': instance.vehicleStateText,
      'ownerName': instance.ownerName,
      'ownerIDNumber': instance.ownerIDNumber,
      'ownerPhone': instance.ownerPhone,
      'frameNumber': instance.frameNumber,
      'engineNumber': instance.engineNumber,
      'joiningDate': instance.joiningDate
    };
