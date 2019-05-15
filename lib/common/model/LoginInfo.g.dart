// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) {
  return LoginInfo(
      json['phoneNumber'] as String,
      json['name'] as String,
      json['userName'] as String,
      json['higherLevelOrg'] as String,
      json['orgAbbreviation'] as String,
      json['orgCode'] as String,
      json['orgFullName'] as String,
      json['orgType'] as String);
}

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'orgCode': instance.orgCode,
      'orgAbbreviation': instance.orgAbbreviation,
      'orgFullName': instance.orgFullName,
      'higherLevelOrg': instance.higherLevelOrg,
      'orgType': instance.orgType
    };
