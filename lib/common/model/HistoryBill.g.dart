// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryBill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryBill _$HistoryBillFromJson(Map<String, dynamic> json) {
  return HistoryBill(
      json['id'] as String,
      json['unloadPlaceName'] as String,
      json['skinbackDate'] as String,
      (json['outStockNetWeigh'] as num)?.toDouble(),
      json['outStockGenerateDate'] as String,
      json['loadPlaceName'] as String,
      (json['inStockNetWeigh'] as num)?.toDouble(),
      (json['inStockGrossWeigh'] as num)?.toDouble(),
      json['goodsName'] as String,
      json['deliveryOrderCode'] as String,
      json['deliveryOrderState'] as String,
      json['generateDate'] as String,
      json['vehicleCode'] as String,
      json['mainVehiclePlate'] as String,
      json['weighDate'] as String);
}

Map<String, dynamic> _$HistoryBillToJson(HistoryBill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleCode': instance.vehicleCode,
      'mainVehiclePlate': instance.mainVehiclePlate,
      'deliveryOrderCode': instance.deliveryOrderCode,
      'deliveryOrderState': instance.deliveryOrderState,
      'generateDate': instance.generateDate,
      'loadPlaceName': instance.loadPlaceName,
      'unloadPlaceName': instance.unloadPlaceName,
      'goodsName': instance.goodsName,
      'outStockGenerateDate': instance.outStockGenerateDate,
      'outStockNetWeigh': instance.outStockNetWeigh,
      'weighDate': instance.weighDate,
      'skinbackDate': instance.skinbackDate,
      'inStockGrossWeigh': instance.inStockGrossWeigh,
      'inStockNetWeigh': instance.inStockNetWeigh
    };
