// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landlordDashboardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLandlordDashboard _$ModelLandlordDashboardFromJson(
        Map<String, dynamic> json) =>
    ModelLandlordDashboard(
      status: json['status'] as String?,
      propertyPosted: json['property_posted'] as int?,
      totalBooking: json['total_booking'] as int?,
      totalEarning: json['total_earning'] as int?,
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ModelLandlordDashboardToJson(
        ModelLandlordDashboard instance) =>
    <String, dynamic>{
      'status': instance.status,
      'property_posted': instance.propertyPosted,
      'total_booking': instance.totalBooking,
      'total_earning': instance.totalEarning,
      'avg_rating': instance.avgRating,
    };
