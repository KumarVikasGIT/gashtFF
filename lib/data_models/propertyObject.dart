
import 'model_propertyList.dart';
import 'package:json_annotation/json_annotation.dart';
part 'propertyObject.g.dart';

@JsonSerializable()
class PropertyObjects{

  String? status;
  List<Property>? properties;

  PropertyObjects({this.status, this.properties});


  factory PropertyObjects.fromJson(Map<String, dynamic> json) =>
      _$PropertyObjectsFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyObjectsToJson(this);


}
