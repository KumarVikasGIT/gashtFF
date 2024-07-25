import 'package:easy_localization/easy_localization.dart';
import 'package:gasht/data_models/model_propertyList.dart';

class ModelDashboard {
  ModelDashboard({
    required this.status,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.cities,
    required this.propertyTypes,
  });

  final String? status;
  static const String statusKey = "status";

  final String? text1;
  static const String text1Key = "text1";

  final String? text2;
  static const String text2Key = "text2";

  final String? text3;
  static const String text3Key = "text3";

  final String? text4;
  static const String text4Key = "text4";

  final List<City> cities;
  static const String citiesKey = "cities";

  final List<PropertyType> propertyTypes;
  static const String propertyTypesKey = "property_types";


  factory ModelDashboard.fromJson(Map<String, dynamic> json){
    return ModelDashboard(
      status: json["status"],
      text1: json["text1"],
      text2: json["text2"],
      text3: json["text3"],
      text4: json["text4"],
      cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      propertyTypes: json["property_types"] == null ? [] : List<PropertyType>.from(json["property_types"]!.map((x) => PropertyType.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "text1": text1,
    "text2": text2,
    "text3": text3,
    "text4": text4,
    "cities": cities.map((x) => x?.toJson()).toList(),
    "property_types": propertyTypes.map((x) => x?.toJson()).toList(),
  };


}

class City {
  City({
    required this.id,
    required this.name,
    required this.stateId,
    required this.image,
    required this.properties,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final int? stateId;
  static const String stateIdKey = "state_id";

  final String? image;
  static const String imageKey = "image";

  final List<Property> properties;
  static const String propertiesKey = "properties";




  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json["id"],
      name: json["name"].toString().toLowerCase(),
      stateId: json["state_id"],
      image: json["image"],
      properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "image": image,
    "properties": properties.map((x) => x.toJson()).toList(),
  };


  @override
  String toString() {
    return tr(name!);
  }




}
class PropertyType {
  PropertyType({
    required this.id,
    required this.propertyType,
    required this.image,
    required this.properties,
  });

  final int? id;
  static const String idKey = "id";

  final String? propertyType;
  static const String propertyTypeKey = "property_type";

  final String? image;
  static const String imageKey = "image";

  final List<Property> properties;
  static const String propertiesKey = "properties";


  factory PropertyType.fromJson(Map<String, dynamic> json){
    return PropertyType(
      id: json["id"],
      propertyType: json["property_type"],
      image: json["image"],
      properties: json["properties"] == null ? [] : List<Property>.from(json["properties"]!.map((x) => Property.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "property_type": propertyType,
    "image": image,
    "properties": properties.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString() {
    return tr(propertyType!);
  }


}
