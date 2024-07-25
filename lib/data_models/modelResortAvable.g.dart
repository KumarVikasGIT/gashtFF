// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelResortAvable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResortAvailable _$ModelResortAvailableFromJson(
        Map<String, dynamic> json) =>
    ModelResortAvailable(
      status: json['status'] as String?,
      propertyDetail: json['property_detail'] == null
          ? null
          : Property.fromJson(json['property_detail'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ModelResortAvailableToJson(
        ModelResortAvailable instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'property_detail': instance.propertyDetail,
    };
