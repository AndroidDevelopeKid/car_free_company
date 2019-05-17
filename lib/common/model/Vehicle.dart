import 'package:json_annotation/json_annotation.dart';

part 'Vehicle.g.dart';
@JsonSerializable()
class Vehicle{
  String id;
  String vehicleCode;//车辆编号
  String mainVehiclePlate;//车牌号
  String oUDisplayName;//所属物流公司
  String vehicleTypeText;//车辆类型
  String vehicleBusinessTypeText;//业务类型
  String modelsText;//车型
  String vehicleStateText;//车辆状态
  String ownerName;//车主姓名
  String ownerIDNumber;//车主身份证号
  String ownerPhone;//车主联系方式
  String frameNumber;//车架号
  String engineNumber;//发动机编号
  String joiningDate;//加盟日期

  Vehicle(
      this.id,
      this.oUDisplayName,
      this.vehicleCode,
      this.engineNumber,
      this.vehicleTypeText,
      this.frameNumber,
      this.vehicleBusinessTypeText,
      this.modelsText,
      this.joiningDate,
      this.mainVehiclePlate,
      this.vehicleStateText,
      this.ownerName,
      this.ownerIDNumber,
      this.ownerPhone
      );

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}