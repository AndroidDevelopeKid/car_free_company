import 'package:json_annotation/json_annotation.dart';

part 'Driver.g.dart';
@JsonSerializable()
class Driver{
  String id;
  String driverIDNumber;//身份证号
  String driverName;//姓名
  String driverPhone;//电话
  String ouDisplayName;//所属物流公司 ??signingOrganization
  String personTypeText;//人员类型
  String vehicleCode;//车辆编号
  String certificateEndDate;//身份证到期日期
  String personStateText;//人员状态
  String buckupContactPerson;//备用联系人
  String buckupContactPersonAddress;//备用联系地址
  String buckupContactPersonPhone;//备用联系方式
  String driverLicenseID;//驾驶证号
  String dlCertificateEndDate;//驾驶证到期日期
  Driver(
      this.id,
      this.ouDisplayName,
      this.vehicleCode,
      this.driverIDNumber,
      this.driverName,
      this.driverPhone,
      this.personTypeText,
      this.personStateText,
      this.buckupContactPerson,
      this.buckupContactPersonAddress,
      this.buckupContactPersonPhone,
      this.driverLicenseID,
      this.certificateEndDate,
      this.dlCertificateEndDate
      );

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}