import 'package:json_annotation/json_annotation.dart';

part 'Driver.g.dart';
@JsonSerializable()
class Driver{
  String idNumber;//身份证号
  String name;//姓名
  String phoneNumber;//电话
  String logisticsCompany;//所属物流公司
  String personType;//人员类型
  String vehicleCode;//车辆编号
  String idCardExpireDate;//身份证到期日期
  String personStatus;//人员状态
  String standbyContactPerson;//备用联系人
  String standbyContactAddress;//备用联系地址
  String standbyContactMode;//备用联系方式
  String driverLicenseNumber;//驾驶证号
  String driverLicenseExpireDate;//驾驶证到期日期
  Driver(
      this.name,
      this.vehicleCode,
      this.phoneNumber,
      this.driverLicenseExpireDate,
      this.driverLicenseNumber,
      this.idCardExpireDate,
      this.idNumber,
      this.logisticsCompany,
      this.personStatus,
      this.personType,
      this.standbyContactAddress,
      this.standbyContactMode,
      this.standbyContactPerson
      );

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}