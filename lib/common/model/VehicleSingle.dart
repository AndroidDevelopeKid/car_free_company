import 'package:json_annotation/json_annotation.dart';

part 'VehicleSingle.g.dart';
@JsonSerializable()
class VehicleSingle{
  String vehicleCode;//车辆编号
  String mainVehiclePlate;//车牌号
  int originalOUId;
  String oUDisplayName;//所属物流公司
  String vehicleType;//车辆类型
  String vehicleTypeText;//车辆类型显示文本
  String vehicleBusinessType;//业务类型
  String vehicleBusinessTypeText;//业务类型显示文本
  String models;//车型
  String modelsText;//车型显示文本
  String vehicleState;//车辆状态
  String vehicleStateText;//车辆状态显示文本
  String ownerName;//车主姓名
  String ownerIDNumber;//车主身份证号
  String ownerPhone;//车主联系方式
  String trailerFrameNumber;//车架号
  String engineNumber;//发动机编号
  String joiningDate;//加盟日期

  VehicleSingle(
      this.oUDisplayName,
      this.vehicleCode,
      this.engineNumber,
      this.vehicleTypeText,
      this.trailerFrameNumber,
      this.vehicleBusinessTypeText,
      this.modelsText,
      this.joiningDate,
      this.mainVehiclePlate,
      this.vehicleStateText,
      this.ownerName,
      this.ownerIDNumber,
      this.ownerPhone,
      this.originalOUId,
      this.models,
      this.vehicleBusinessType,
      this.vehicleState,
      this.vehicleType
      );

  factory VehicleSingle.fromJson(Map<String, dynamic> json) => _$VehicleSingleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleSingleToJson(this);
}