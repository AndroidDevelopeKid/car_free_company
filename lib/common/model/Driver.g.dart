// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
    json['originalOUId'] as int,
    json['ouDisplayName'] as String,
    json['vehicleCode'] as String,
    json['driverIDNumber'] as String,
    json['driverName'] as String,
    json['driverPhone'] as String,
    json['personTypeText'] as String,
    json['personStateText'] as String,
    json['buckupContactPerson'] as String,
    json['buckupContactPersonAddress'] as String,
    json['buckupContactPersonPhone'] as String,
    json['driverLicenseID'] as String,
    json['certificateEndDate'] as String,
    json['dlCertificateEndDate'] as String,
    json['personState'] as String,
    json['personType'] as String,
  );
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'originalOUId': instance.originalOUId,
      'driverIDNumber': instance.driverIDNumber,
      'driverName': instance.driverName,
      'driverPhone': instance.driverPhone,
      'ouDisplayName': instance.ouDisplayName,
      'personType': instance.personType,
      'personTypeText': instance.personTypeText,
      'vehicleCode': instance.vehicleCode,
      'certificateEndDate': instance.certificateEndDate,
      'personState': instance.personState,
      'personStateText': instance.personStateText,
      'buckupContactPerson': instance.buckupContactPerson,
      'buckupContactPersonAddress': instance.buckupContactPersonAddress,
      'buckupContactPersonPhone': instance.buckupContactPersonPhone,
      'driverLicenseID': instance.driverLicenseID,
      'dlCertificateEndDate': instance.dlCertificateEndDate,
    };
