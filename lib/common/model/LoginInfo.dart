import 'package:json_annotation/json_annotation.dart';

part 'LoginInfo.g.dart';
@JsonSerializable()
class LoginInfo{
  String userName;//用户名
  String name;//姓名
  String phoneNumber;//手机号码
  String orgCode;//所属组织编码
  String orgAbbreviation;//所属组织简称
  String orgFullName;//所属组织全称
  String higherLevelOrg;//上级组织
  String orgType;//组织类型

  LoginInfo(
      this.phoneNumber,
      this.name,
      this.userName,
      this.higherLevelOrg,
      this.orgAbbreviation,
      this.orgCode,
      this.orgFullName,
      this.orgType
      );
  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}