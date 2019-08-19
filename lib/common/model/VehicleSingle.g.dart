// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleSingle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleSingle _$VehicleSingleFromJson(Map<String, dynamic> json) {
  return VehicleSingle(
      json['oUDisplayName'] as String,
      json['vehicleCode'] as String,
      json['engineNumber'] as String,
      json['vehicleTypeText'] as String,
      json['trailerFrameNumber'] as String,
      json['vehicleBusinessTypeText'] as String,
      json['modelsText'] as String,
      json['joiningDate'] as String,
      json['mainVehiclePlate'] as String,
      json['vehicleStateText'] as String,
      json['ownerName'] as String,
      json['ownerIDNumber'] as String,
      json['ownerPhone'] as String,
      json['originalOUId'] as int,
      json['models'] as String,
      json['vehicleBusinessType'] as String,
      json['vehicleState'] as String,
      json['vehicleType'] as String);
}

Map<String, dynamic> _$VehicleSingleToJson(VehicleSingle instance) =>
    <String, dynamic>{
      'vehicleCode': instance.vehicleCode,
      'mainVehiclePlate': instance.mainVehiclePlate,
      'originalOUId': instance.originalOUId,
      'oUDisplayName': instance.oUDisplayName,
      'vehicleType': instance.vehicleType,
      'vehicleTypeText': instance.vehicleTypeText,
      'vehicleBusinessType': instance.vehicleBusinessType,
      'vehicleBusinessTypeText': instance.vehicleBusinessTypeText,
      'models': instance.models,
      'modelsText': instance.modelsText,
      'vehicleState': instance.vehicleState,
      'vehicleStateText': instance.vehicleStateText,
      'ownerName': instance.ownerName,
      'ownerIDNumber': instance.ownerIDNumber,
      'ownerPhone': instance.ownerPhone,
      'trailerFrameNumber': instance.trailerFrameNumber,
      'engineNumber': instance.engineNumber,
      'joiningDate': instance.joiningDate
    };
