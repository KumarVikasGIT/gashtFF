// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model_Login _$Model_LoginFromJson(Map<String, dynamic> json) => Model_Login(
      status: json['status'] as String?,
      message: json['message'] as String?,
      name: json['name'] as String?,
      token: json['token'] as String?,
      user_id: json['user_id'] as String?,
    );

Map<String, dynamic> _$Model_LoginToJson(Model_Login instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'name': instance.name,
      'token': instance.token,
      'user_id': instance.user_id,
    };
