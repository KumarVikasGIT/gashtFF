import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_privacy.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import 'package:dio/dio.dart';

import '../controllers/langaugeCotroller.dart';

class TermsAndPolicy extends StatefulWidget {
  final String stringValue;

  const TermsAndPolicy({
    Key? key,
    required this.stringValue,
  }) : super(key: key);

  @override
  State<TermsAndPolicy> createState() => _TermsAndPolicy();
}

class _TermsAndPolicy extends State<TermsAndPolicy> {

  final TranslationController _translationController = Get.put(TranslationController());



  String privacyEnglish = "assets/images/privacypolicyEnglish.pdf";
  String privacyArabic = "assets/images/privacypolicyArabic.pdf";
  String privacyKurdish = "assets/images/privacypolicyKurdish.pdf";
  String termsEnglish = "assets/images/termsofUseEnglish.pdf";
  String termsArabic = "assets/images/termsofUseArabic.pdf";
  String termsKurdish= "assets/images/termsofUseKurdish.pdf";


String pdf = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }



  @override
  Widget build(BuildContext context) {

    if(widget.stringValue=="privacy_policy")
    {

      if(context.locale.languageCode=="ar")
      {
        pdf= privacyArabic;
      }
      if(context.locale.languageCode=="en")
      {
        pdf= privacyEnglish;
      }
      else
      {
        pdf= privacyKurdish;

      }
    }
    else
    {
      if(context.locale.languageCode=="ar")
      {
        pdf= termsArabic;
      }
      if(context.locale.languageCode=="en")
      {
        pdf= termsEnglish;
      }
      else
      {
        pdf= termsKurdish;

      }
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title:  FutureBuilder(future: _translationController.getTransaltion(widget.stringValue),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }
              else
              {
                return
                  Text(
                  widget.stringValue,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ;
              }
            }),

      ),

      body: SfPdfViewer.asset(
        pdf
        //  'assets/images/PrivacyPolicy.pdf'





        /* FutureBuilder<Model_Privacy>(
          future: getPrivacy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.green));
            }
            else if (snapshot.hasData){
              Model_Privacy conditons = snapshot.data!;

              log("=>>>>///// ${widget.stringValue}");

             return

               FutureBuilder(future:
               _translationController.getTransaltion( widget.stringValue == "terms_of_use" ? conditons.termsofuse.toString() : conditons.privacypolicy.toString()),
                   builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return                Container(
                           margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                           child:SfPdfViewer.asset(
                               'assets/images/PrivacyPolicy.pdf')



                         */
        /*
               Text(
                 widget.stringValue == "Terms of Use"
                     ? conditons.termsofuse.toString()
                     : conditons.privacypolicy.toString(),
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 14,
                   fontFamily: GoogleFonts.mulish.toString(),
                   fontWeight: FontWeight.w600,
                   height: 1.67,
                 ),
               ),

                       );

                     }
                     else
                     {
                       return
                         Container(
                             margin: const EdgeInsets.only(left: 10, right: 10, top: 5),

                           */
        /*
               Text(
                 widget.stringValue == "Terms of Use"
                     ? conditons.termsofuse.toString()
                     : conditons.privacypolicy.toString(),
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 14,
                   fontFamily: GoogleFonts.mulish.toString(),
                   fontWeight: FontWeight.w600,
                   height: 1.67,
                 ),
               ),

                         );

                     }
                   });


            }

            else if (snapshot.hasError) {
              //  profileModel = snapshot!;
              return Center(
                  child: Text("Encountered an error: ${snapshot.error}"));
            }
            else {
              return const Text("No internet connection");
            }

          },

        ),*/
      ),
    );
  }

  Future<Model_Privacy> getPrivacy()async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    return apiInterface.getTermsofuse();

  }

}

