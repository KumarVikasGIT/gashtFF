/*
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TranslationController extends GetxController {
  RxString currentLanguage = 'en'.obs; // Default language is English

  final _modelManager = OnDeviceTranslatorModelManager();
  var _englishLanguage = TranslateLanguage.english;
  var _arabicLanguage = TranslateLanguage.arabic;
  var kurdishLanguage = TranslateLanguage.turkish;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchModels();
  }

  final _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.arabic);

  Future<String> translateText(String text, String targetLanguage) async {

    //final String response =
    return await _onDeviceTranslator.translateText(text);
  }


  */
/*Future<Property> propertyText (Property property)
  {
    return await _modelManager.;
  }*//*


  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
  }

  Future<void> fetchModels() async {
    final bool responseEng = await _modelManager.downloadModel(TranslateLanguage.english.bcpCode);
    final bool responseAra = await _modelManager.downloadModel(TranslateLanguage.arabic.bcpCode);
    final bool responseKur = await _modelManager.downloadModel(TranslateLanguage.turkish.bcpCode);


    print("==>> responseEng $responseEng ==>>  responseAra $responseAra ==>>responseKur == $responseKur");


  }
}
*/
