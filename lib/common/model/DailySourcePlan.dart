
import 'package:json_annotation/json_annotation.dart';

part 'DailySourcePlan.g.dart';
@JsonSerializable()
class DailySourcePlan{
  ///客户
  String customerName;
  ///装地
  String loadPlaceIdName;
  ///卸地
  String unloadPlaceIdName;
  ///货物
  String cargoCategoryText;
  ///预计总吨数
  String expectedTotalTon;
  ///预计总车数
  String expectedTruckAmount;
  ///计划日期
  String sourceDate;
  String id;

  DailySourcePlan(
      this.cargoCategoryText,
      this.customerName,
      this.expectedTotalTon,
      this.expectedTruckAmount,
      this.loadPlaceIdName,
      this.sourceDate,
      this.unloadPlaceIdName,
      this.id
      );

  factory DailySourcePlan.fromJson(Map<String, dynamic> json) => _$DailySourcePlanFromJson(json);

  Map<String, dynamic> toJson() => _$DailySourcePlanToJson(this);

}