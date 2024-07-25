// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownerTermsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerTermsModel _$OwnerTermsModelFromJson(Map<String, dynamic> json) =>
    OwnerTermsModel(
      status: json['status'] as String?,
      cancellationPolicy: (json['cancellation_policy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      terms:
          (json['terms'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OwnerTermsModelToJson(OwnerTermsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'cancellation_policy': instance.cancellationPolicy,
      'terms': instance.terms,
    };
