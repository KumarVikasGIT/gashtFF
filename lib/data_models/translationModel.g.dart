// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationModel _$TranslationModelFromJson(Map<String, dynamic> json) =>
    TranslationModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TranslationModelToJson(TranslationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'translations': instance.translations,
    };

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      translatedText: json['translatedText'] as String?,
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'translatedText': instance.translatedText,
    };
