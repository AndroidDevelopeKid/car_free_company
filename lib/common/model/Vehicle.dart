import 'package:json_annotation/json_annotation.dart';

part 'Vehicle.g.dart';
@JsonSerializable()
class Vehicle{
  String vehicleCode;//车辆编号
  String plateNumber;//车牌号
  String logisticsCompany;//所属物流公司
  String vehicleType;//车辆类型
  String businessType;//业务类型
  String carType;//车型
  String vehicleStatus;//车辆状态
  String vehicleOwnerName;//车主姓名
  String vehicleOwnerIdNumber;//车主身份证号
  String vehicleOwnerContactMode;//车主联系方式
  String frameNumber;//车架号
  String engineNumber;//发动机编号
  String joinDate;//加盟日期

  Vehicle(
      this.logisticsCompany,
      this.vehicleCode,
      this.engineNumber,
      this.vehicleType,
      this.frameNumber,
      this.businessType,
      this.carType,
      this.joinDate,
      this.plateNumber,
      this.vehicleOwnerContactMode,
      this.vehicleOwnerIdNumber,
      this.vehicleOwnerName,
      this.vehicleStatus
      );

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}