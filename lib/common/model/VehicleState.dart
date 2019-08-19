import 'package:json_annotation/json_annotation.dart';

part 'VehicleState.g.dart';
@JsonSerializable()
class VehicleState{
  String value;//值
  String text;//显示文本
  bool selected;


  VehicleState(
      this.value,
      this.text,
      this.selected
      );

  factory VehicleState.fromJson(Map<String, dynamic> json) => _$VehicleStateFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleStateToJson(this);
}