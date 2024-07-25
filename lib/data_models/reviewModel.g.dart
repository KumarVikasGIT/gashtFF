// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      propertyId: json['property_id'] as int?,
      userName: json['user_name'] as String?,
      rating: json['rating'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'property_id': instance.propertyId,
      'user_name': instance.userName,
      'rating': instance.rating,
      'comment': instance.comment,
    };
