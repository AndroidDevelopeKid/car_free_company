import 'package:json_annotation/json_annotation.dart';

part 'TransportPlace.g.dart';
@JsonSerializable()
class TransportPlace{
  String value;
  String text;
  int parentId;
  int id;
  TransportPlace(
      this.id,
      this.parentId,
      this.text,
      this.value
      );
  ///json转换为实体类
  factory TransportPlace.fromJson(Map<String, dynamic> json) => _$TransportPlaceFromJson(json);
  ///实体类到json
  Map<String, dynamic> toJson() => _$TransportPlaceToJson(this);
  ///命名构造函数
  TransportPlace.empty();

}