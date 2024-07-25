import 'package:gasht/ui/property/propertyDetails.dart';

import 'bookingDetailsModel.dart';
import 'model_propertyList.dart';

class ModelResort {
  ModelResort({
    required this.status,
    required this.cities,
  });

  final String? status;
  static const String statusKey = "status";

  final List<Cities> cities;
  static const String citiesKey = "cities";


  factory ModelResort.fromJson(Map<String, dynamic> json){
    return ModelResort(
      status: json["status"],
      cities: json["cities"] == null ? [] : List<Cities>.from(json["cities"]!.map((x) => Cities.fromJson(x))),
    );
  }
}

class Cities {
  Cities({
    required this.id,
    required this.name,
    required this.stateId,
    required this.image,
    required this.resorts,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final int? stateId;
  static const String stateIdKey = "state_id";

  final String? image;
  static const String imageKey = "image";

  final List<Property> resorts;
  static const String resortsKey = "resorts";


  factory Cities.fromJson(Map<String, dynamic> json){
    return Cities(
      id: json["id"],
      name: json["name"],
      stateId: json["state_id"],
      image: json["image"],
      resorts: json["resorts"] == null ? [] : List<Property>.from(json["resorts"]!.map((x) => Property.fromJson(x))),
    );
  }



}

