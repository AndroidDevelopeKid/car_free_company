// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['fullName'] as String,
      json['organizationCode'] as String,
      json['organizationDisplayName'] as String,
      json['organizationFullName'] as String,
      json['organizationParentId'] as int,
      json['organizationType'] as String,
      json['organizationTypeText'] as String,
      json['phoneNumber'] as String,
      json['userName'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'organizationCode': instance.organizationCode,
      'organizationDisplayName': instance.organizationDisplayName,
      'organizationFullName': instance.organizationFullName,
      'organizationParentId': instance.organizationParentId,
      'organizationType': instance.organizationType,
      'organizationTypeText': instance.organizationTypeText
    };
