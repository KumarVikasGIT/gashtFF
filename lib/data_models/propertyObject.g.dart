// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propertyObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyObjects _$PropertyObjectsFromJson(Map<String, dynamic> json) =>
    PropertyObjects(
      status: json['status'] as String?,
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyObjectsToJson(PropertyObjects instance) =>
    <String, dynamic>{
      'status': instance.status,
      'properties': instance.properties,
    };
