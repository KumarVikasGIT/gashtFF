import 'package:json_annotation/json_annotation.dart';

part 'landlordDashboardModel.g.dart';

@JsonSerializable()
class ModelLandlordDashboard {
  ModelLandlordDashboard({
    required this.status,
    required this.propertyPosted,
    required this.totalBooking,
    required this.totalEarning,
    required this.avgRating,
  });

  final String? status;
  static const String statusKey = "status";


  @JsonKey(name: 'property_posted')
  final int? propertyPosted;
  static const String propertyPostedKey = "property_posted";


  @JsonKey(name: 'total_booking')
  final int? totalBooking;
  static const String totalBookingKey = "total_booking";


  @JsonKey(name: 'total_earning')
  final int? totalEarning;
  static const String totalEarningKey = "total_earning";


  @JsonKey(name: 'avg_rating')
  final double? avgRating;
  static const String avgRatingKey = "avg_rating";


  factory ModelLandlordDashboard.fromJson(Map<String, dynamic> json) => _$ModelLandlordDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$ModelLandlordDashboardToJson(this);

}
