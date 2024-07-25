import 'package:json_annotation/json_annotation.dart';

part 'bookpropertyModel.g.dart';

@JsonSerializable()
class PropertyBookingModel {
  PropertyBookingModel({
    required this.status,
    required this.message,
    required this.url,
  });

  final String? status;
  final String? message;
  final String? url;

  factory PropertyBookingModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyBookingModelToJson(this);
}
