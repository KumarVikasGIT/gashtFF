// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyQuoteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyQuoteModel _$DailyQuoteModelFromJson(Map<String, dynamic> json) =>
    DailyQuoteModel(
      status: json['status'] as String?,
      quote: json['quote'] as String?,
    );

Map<String, dynamic> _$DailyQuoteModelToJson(DailyQuoteModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'quote': instance.quote,
    };
