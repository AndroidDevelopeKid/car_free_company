import 'package:json_annotation/json_annotation.dart';

part 'VehicleModel.g.dart';
@JsonSerializable()
class VehicleModel{
  String value;//值
  String text;//显示文本
  bool selected;


  VehicleModel(
      this.value,
      this.text,
      this.selected
      );

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}