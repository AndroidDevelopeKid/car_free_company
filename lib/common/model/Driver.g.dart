// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
      json['name'] as String,
      json['vehicleCode'] as String,
      json['phoneNumber'] as String,
      json['driverLicenseExpireDate'] as String,
      json['driverLicenseNumber'] as String,
      json['idCardExpireDate'] as String,
      json['idNumber'] as String,
      json['logisticsCompany'] as String,
      json['personStatus'] as String,
      json['personType'] as String,
      json['standbyContactAddress'] as String,
      json['standbyContactMode'] as String,
      json['standbyContactPerson'] as String);
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'idNumber': instance.idNumber,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'logisticsCompany': instance.logisticsCompany,
      'personType': instance.personType,
      'vehicleCode': instance.vehicleCode,
      'idCardExpireDate': instance.idCardExpireDate,
      'personStatus': instance.personStatus,
      'standbyContactPerson': instance.standbyContactPerson,
      'standbyContactAddress': instance.standbyContactAddress,
      'standbyContactMode': instance.standbyContactMode,
      'driverLicenseNumber': instance.driverLicenseNumber,
      'driverLicenseExpireDate': instance.driverLicenseExpireDate
    };
