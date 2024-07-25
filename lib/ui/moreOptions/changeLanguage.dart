import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:restart_app/restart_app.dart';
import 'dart:io';
import '../../main.dart';
import '../controllers/langaugeCotroller.dart';

class ChangeLanguage extends StatefulWidget{
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguage ();

}

class _ChangeLanguage extends State<ChangeLanguage>{

  bool valueEN = false;
  bool valueAb = false;
  bool valueKR = false;


  final TranslationController _translationController = Get.put(TranslationController());
  late String selectedLanguage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
selectedLanguage = _translationController.selectedTargetLanguage.bcpCode;

    if(_translationController.selectedTargetLanguage.bcpCode=="ar") {

      valueAb = true;

    }
    else if(_translationController.selectedTargetLanguage.bcpCode
        == "hi") {
      valueKR = true;
    }
    else {
      valueEN = true;    }

    print("selected langauge ===>> ${_translationController.selectedTargetLanguage.bcpCode}");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


  return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.appColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title:  Text( tr("change_language"),style : const TextStyle(color: Colors.white)),),
    body: Column(
      children: [

        const SizedBox(height: 10,),

        Row(children: [
          const SizedBox(width: 20,),

          Text(
            'English',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF555555),
              fontSize: 15,
              fontFamily: GoogleFonts.poppins.toString(),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.75,
            ),
          ),

          const Spacer(),
          Checkbox(
            value: valueEN,
            onChanged: (value) {
              setState(() {
                valueEN = value!;
                valueKR=false;
                valueAb = false;
                selectedLanguage="en";
                _translationController.changeTargetLanguage("en");
                                   context.setLocale(const Locale('en'));


                // EasyLocalization.of(context)?.setLocale(const Locale("en"));

              });
            },
          ),

          const SizedBox(width: 20,),


        ],),
        Row(children: [
          const SizedBox(width: 20,),

          Text(
            "عربي",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF555555),
              fontSize: 15,
              fontFamily: GoogleFonts.poppins.toString(),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.75,
            ),
          ),

          const Spacer(),
          Checkbox(
            value: valueAb,
            onChanged: (value) {
              setState(() {
               valueAb = value!;
               valueKR=false;
               valueEN = false;
               selectedLanguage="ar";
               _translationController.changeTargetLanguage("ar");
               context.setLocale(const Locale('ar'));

                //   EasyLocalization.of(context)?.setLocale(const Locale("ar"));

              });
            },
          ),

          const SizedBox(width: 20,),


        ],),
        Row(children: [
          const SizedBox(width: 20,),

          Text(
            "کۆردی",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF555555),
              fontSize: 15,
              fontFamily: GoogleFonts.poppins.toString(),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.75,
            ),
          ),

          const Spacer(),
          Checkbox(
            value: valueKR,
            onChanged: (value) {
              setState(() {
                valueKR = value!;
                valueAb=false;
                valueEN = false;
                selectedLanguage="ku";
                _translationController.changeTargetLanguage("ku");
                context.setLocale(const Locale('fa'));

              });
            },
          ),

          const SizedBox(width: 20,),


        ],),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColor,
              elevation: 2.5,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ), onPressed: () async {
            // loginValidator(context);


            if(selectedLanguage=="ar") {
              context.setLocale(const Locale('ar'));


            }
            else if(selectedLanguage == "ku") {
              context.setLocale(const Locale('fa'));

            }
            else {
              context.setLocale(const Locale('en'));
            }



           // exit(0);



           // context.setLocale(Locale(selectedLanguage));

          //  await FlutterRestart.restartApp();
       //  Restart.restartApp();

          //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false);


            //Get.reset(); // Clear all bindings and instances







            Restart.restartApp();


             //Get.offAllNamed('/');

          //  Restart.restartApp();
           // _restartApp(context);

          }, child:









          FutureBuilder(future: _translationController.getTransaltion( "change_language"),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return       Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,

                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts
                              .lato()
                              .fontFamily,
                          color: Colors.white)
                  );
                }
                else
                {
                  return

                    Text(
                        "Change Language", style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts
                            .lato()
                            .fontFamily,
                        color: Colors.white))
                  ;
                }
              }),


          ),
        ),

      ],
    )


  );
  }
  void _restartApp(BuildContext context) {
    void restart() {
      // This is where the app gets restarted
      runApp(EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('ku')],
        path: 'assets/l10n', // Path to your translations
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'), // Change the startLocale as needed
        child: MyApp(),
      ));
    }

    // Use WidgetsBinding.instance to add a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) => restart());
  }
  
}