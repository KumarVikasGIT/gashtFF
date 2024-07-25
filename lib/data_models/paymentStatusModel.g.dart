// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentStatusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatusModel _$PaymentStatusModelFromJson(Map<String, dynamic> json) =>
    PaymentStatusModel(
      status: json['status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$PaymentStatusModelToJson(PaymentStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'amount': instance.amount,
    };
