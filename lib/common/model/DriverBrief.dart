import 'package:json_annotation/json_annotation.dart';

part 'DriverBrief.g.dart';
@JsonSerializable()
class DriverBrief{
  String id;
  String driverIDNumber;//身份证号
  String driverName;//姓名
  String driverPhone;//电话
  String vehicleCode;//车辆编号

  DriverBrief(
      this.id,
      this.vehicleCode,
      this.driverIDNumber,
      this.driverName,
      this.driverPhone,
      );

  factory DriverBrief.fromJson(Map<String, dynamic> json) => _$DriverBriefFromJson(json);

  Map<String, dynamic> toJson() => _$DriverBriefToJson(this);
}