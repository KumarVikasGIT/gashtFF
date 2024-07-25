// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookpropertyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyBookingModel _$PropertyBookingModelFromJson(
        Map<String, dynamic> json) =>
    PropertyBookingModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PropertyBookingModelToJson(
        PropertyBookingModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'url': instance.url,
    };
