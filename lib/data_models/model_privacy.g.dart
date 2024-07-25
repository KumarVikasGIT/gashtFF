// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_privacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Privacy _$Model_PrivacyFromJson(Map<String, dynamic> json) =>
    Model_Privacy(
      status: json['status'] as String?,
      termsofuse: json['termsofuse'] as String?,
      privacypolicy: json['privacypolicy'] as String?,
    );

Map<String, dynamic> _$Model_PrivacyToJson(Model_Privacy instance) =>
    <String, dynamic>{
      'status': instance.status,
      'termsofuse': instance.termsofuse,
      'privacypolicy': instance.privacypolicy,
    };
