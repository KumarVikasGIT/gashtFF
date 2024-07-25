import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:gasht/data_models/translationModel.dart';
import 'package:gasht/multiLang/newLang.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis/translate/v3.dart';
//import 'package:googleapis/translate/v2.dart' as translate;
import 'package:easy_localization/easy_localization.dart';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';


class TranslationController extends GetxController {
  late TranslationController _controller;

  final TranslateLanguage sourceLanguage = TranslateLanguage.english;
  final TranslateLanguage targetLanguageKurdish = TranslateLanguage.hindi;
  final TranslateLanguage targetLanguage = TranslateLanguage.arabic;
  late  TranslateLanguage selectedTargetLanguage ;

  final logger = Logger();

  //final Translation translation = Translation();

  late OnDeviceTranslator onDeviceTranslator  ;
  final modelManager = OnDeviceTranslatorModelManager();
  final RxString data = RxString('');
  RxString _currentLocale = 'en'.obs; // Default locale is 'en'

  String apiKey = "AIzaSyBsfiEq7rCvgeVL0vQxP4Dy63E8GocViXg";



  //final apiKey = 'YOUR_GOOGLE_CLOUD_TRANSLATE_API_KEY'; // Replace with your API ke//



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

   // final client = await credentials.clientViaServiceAccount(credentials, translate.TranslateApi.cloudTranslationScope);

//translation.translatedText

   String  ? lang = await PrefManager.getString("lang");

    print ("langaueg ==>> $lang");
   if(lang!=null)
     {
       print ("langaueg ==>> $lang");
       changeTargetLanguage(lang);
     }
   else {
     onDeviceTranslator = OnDeviceTranslator(
         sourceLanguage: sourceLanguage, targetLanguage: targetLanguage);
    selectedTargetLanguage = targetLanguage;
   }
    final bool response = await modelManager.downloadModel(sourceLanguage.bcpCode,isWifiRequired: false);
    final bool response1 = await modelManager.downloadModel(targetLanguage.bcpCode,isWifiRequired: false);
    final bool response2 = await modelManager.downloadModel(targetLanguageKurdish.bcpCode,isWifiRequired: false);


    print("==>> responseEng $response ==>>  responseAra $response1==>>responseKur == $response2");

  }



  String setString(String text){

    return "";

  }

  Future<String>  getTransaltion(String text)  async {



    var title = tr(text) ;


    print("====>>>>>>>>>>>>>>>> title text $text translated === $title");

    //logger.d("title text ===>> $text translated ===>> $title");




    // logger.d( tr("property_terms"),);


    return title;



   /* if(selectedTargetLanguage.bcpCode=="ar"||selectedTargetLanguage.bcpCode=="en") {

      //Static function
      return title;
    }
    else
      {
        var title = tr(text) ;

        print("====>>>>>>>>>>>>>>>> title jtext $text translated === $title");
        //Static function
        return title;

      }*/

   /* if(selectedTargetLanguage.bcpCode=="hi")
      {
        var headers = {
          'Content-Type': 'application/json'
        };
        var data = json.encode({
          "key": "AIzaSyBsfiEq7rCvgeVL0vQxP4Dy63E8GocViXg",
          "q": text,
          "source": "en",
          "target": "ckb",
          "format": "text"
        });
        var dio = Dio();
        var response = await dio.request(
          'https://translation.googleapis.com/language/translate/v2?key=AIzaSyBsfiEq7rCvgeVL0vQxP4Dy63E8GocViXg',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );


        if(response.statusCode==200)
          {
            TranslationModel translationModel = TranslationModel.fromJson(json.decode(response.toString()));

            log("==>>> translated datat =======>>>>>>>>>>  ${json.encode(response.data)}");
            return Future.value(translationModel.data!.translations?[0].translatedText!);




          }
        else
          {
            return Future.value(" ");

          }

      }

    else
      {
        return Future.value("");

      }
*/






  }

  void changeTargetLanguage(String selectedLanguage) async {


   if(selectedLanguage=="ar") {
     selectedTargetLanguage = targetLanguage;
    // setLocale(languageCode)

   }
   else if(selectedLanguage == "ku") {
     selectedTargetLanguage = targetLanguageKurdish;







   }
   else {
     selectedTargetLanguage = sourceLanguage;
   }




  // _currentLocale.value = selectedLanguage;
  // EasyLocalization.of(Get.context!)?.setLocale(Locale(selectedLanguage));

   //Get.locale! = Locale(selectedLanguage);


   print("slelected language ==???$selectedLanguage");

   // Update onDeviceTranslator with the new target language
      onDeviceTranslator = OnDeviceTranslator(sourceLanguage: sourceLanguage, targetLanguage: selectedTargetLanguage);


   PrefManager.saveString("lang", selectedLanguage);
      // Notify listeners about the change
      update();
    }

/*
   String getLang()  {

  //  TranslateLanguage selectedTargetLanguage;

    if(selectedLanguage=="ar") {
      selectedTargetLanguage = targetLanguage;
    }
    else if(selectedLanguage == "kr") {
      selectedTargetLanguage = targetLanguageKurdish;
    }
    else {
      selectedTargetLanguage = sourceLanguage;
    }
    // Update onDeviceTranslator with the new target language
    onDeviceTranslator = OnDeviceTranslator(sourceLanguage: sourceLanguage, targetLanguage: selectedTargetLanguage);

    // Notify listeners about the change
    update();
  }
*/




}