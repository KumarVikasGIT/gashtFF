// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Profile _$Model_ProfileFromJson(Map<String, dynamic> json) =>
    Model_Profile(
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      userType: json['userType'] as String?,
      id_proof: json['id_proof'] as String?,
    );

Map<String, dynamic> _$Model_ProfileToJson(Model_Profile instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'email': instance.email,
      'phone': instance.phone,
      'userType': instance.userType,
      'id_proof': instance.id_proof,
    };
