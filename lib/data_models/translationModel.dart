import 'package:json_annotation/json_annotation.dart';

part 'translationModel.g.dart';

@JsonSerializable()
class TranslationModel {
  TranslationModel({
    required this.data,
  });

  final Data? data;
  static const String dataKey = "data";


  factory TranslationModel.fromJson(Map<String, dynamic> json) => _$TranslationModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationModelToJson(this);

}

@JsonSerializable()
class Data {
  Data({
    required this.translations,
  });

  final List<Translation>? translations;
  static const String translationsKey = "translations";


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class Translation {
  Translation({
    required this.translatedText,
  });

  final String? translatedText;
  static const String translatedTextKey = "translatedText";


  factory Translation.fromJson(Map<String, dynamic> json) => _$TranslationFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);

}
