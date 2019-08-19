import 'package:json_annotation/json_annotation.dart';

part 'VehicleGroup.g.dart';
@JsonSerializable()
class VehicleGroup{
  String value;//值
  String text;//显示文本
  bool selected;


  VehicleGroup(
      this.value,
      this.text,
      this.selected
      );

  factory VehicleGroup.fromJson(Map<String, dynamic> json) => _$VehicleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleGroupToJson(this);
}