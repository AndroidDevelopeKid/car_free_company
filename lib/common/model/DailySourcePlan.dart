
import 'package:json_annotation/json_annotation.dart';

part 'DailySourcePlan.g.dart';
@JsonSerializable()
class DailySourcePlan{
  ///客户
  String customer;
  ///装地
  String loadPlace;
  ///卸地
  String unloadPlace;
  ///货物
  String goods;
  ///预计总吨数
  String estimatedTotalTon;
  ///预计总车数
  String estimatedTotalVehicles;
  ///计划日期
  String planDate;

  DailySourcePlan(
      this.customer,
      this.estimatedTotalTon,
      this.estimatedTotalVehicles,
      this.goods,
      this.loadPlace,
      this.planDate,
      this.unloadPlace
      );

  factory DailySourcePlan.fromJson(Map<String, dynamic> json) => _$DailySourcePlanFromJson(json);

  Map<String, dynamic> toJson() => _$DailySourcePlanToJson(this);

}