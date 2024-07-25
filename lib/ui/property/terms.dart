import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/langaugeCotroller.dart';



class Terms extends StatefulWidget {

  final Property propertyList;
  const Terms( this.propertyList, {Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _Terms();
}

class _Terms extends State<Terms> {

  List<String> items = [
    "The apartment is the best i have seen in my life and worth it ",
    "The apartment is the best i have seen in my life and worth it i have seen in my life and worth it",
    "The apartment is the best i have seen in my life and worth it i have seen in my life and worth it",
    "Terms",

  ];
  final TranslationController _translationController = Get.put(TranslationController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.harmattan().fontFamily,
      ),
      child: Scaffold(body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             alignment: Alignment.centerLeft,
             margin: const EdgeInsets.only(left: 10,top: 10),
             child:


             FutureBuilder
               (future: _translationController.getTransaltion('property_terms'),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return      Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 13,
                         fontFamily: GoogleFonts.harmattan().fontFamily,
                         fontWeight: FontWeight.w500,
                         height: 1.82,
                       ),
                     );
                   }
                   else
                   {
                     return
                          Text(
                         'Property Terms :',
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 13,
                           fontFamily: GoogleFonts.harmattan().fontFamily,
                           fontWeight: FontWeight.w500,
                           height: 1.82,
                         ),
                       );
                   }
                 }),



           ),

            const SizedBox(height: 10,),



          Container(
              margin: const EdgeInsets.only(left: 10,right: 10),

              child:

              FutureBuilder
                (future: _translationController.getTransaltion(  widget.propertyList.terms.toString()),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return      Text(
                        snapshot.data!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 1.82,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          widget.propertyList.terms.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 1.82,
                          ),
                        );
                    }
                  }),


          ),

          /*  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   const Icon(Icons.circle, color: Colors.black),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "${index+1}.  ${items[index]}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          maxLines: 2, // Adjust max lines as needed
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),*/


            const SizedBox(height: 20,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child:
              FutureBuilder
                (future: _translationController
                  .getTransaltion(  'cancelation_and_postponement_policy'),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return      Text(
                        snapshot.data!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 1.82,
                        ),
                      );
                    }
                    else
                    {
                      return
                        Text(
                          'Cancellation and postponement policy :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 1.82,
                          ),
                        );
                    }
                  }),



            ),

         /*   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Text(
                        "${index+1}.  ${items[index]}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          maxLines: 2, // Adjust max lines as needed
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),*/
            Container(
                margin: const EdgeInsets.only(left: 10,right: 10),

                child:
                FutureBuilder
                  (future: _translationController.getTransaltion(  widget.propertyList.cancellationPolicy.toString()),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return      Text(
                          snapshot.data!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 1.82,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            widget.propertyList.cancellationPolicy.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 1.82,
                            ),
                          );
                      }
                    }),



            )












          ],
        ),



      ),),
    );
  }
  
}