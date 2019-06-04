import 'package:json_annotation/json_annotation.dart';

part 'PlacePick.g.dart';
@JsonSerializable()
class PlacePick{
  int parentId;
  int id;
  List<String> place;

  PlacePick(
      this.id,
      this.parentId,
      this.place
      );

  factory PlacePick.fromJson(Map<String, dynamic> json) => _$PlacePickFromJson(json);

  Map<String, dynamic> toJson() => _$PlacePickToJson(this);

  PlacePick.empty();
}