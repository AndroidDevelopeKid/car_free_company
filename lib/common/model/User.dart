import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';
@JsonSerializable()
class User{
  User(
      this.fullName,
      this.organizationCode,
      this.organizationDisplayName,
      this.organizationFullName,
      this.organizationParentId,
      this.organizationType,
      this.organizationTypeText,
      this.phoneNumber,
      this.userName

      );
  String userName;
  String fullName;
  String phoneNumber;
  String organizationCode;
  String organizationDisplayName;
  String organizationFullName;
  int organizationParentId;
  int organizationType;
  String organizationTypeText;

  ///json转换为实体类
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  ///实体类到json
  Map<String, dynamic> toJson() => _$UserToJson(this);
  ///命名构造函数
  User.empty();
}