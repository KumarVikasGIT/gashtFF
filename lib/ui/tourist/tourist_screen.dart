import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/tourist/tourist_detail_screen.dart';
import 'package:gasht/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../api/retrofit_interface.dart';
import '../../controller/tourist_controller.dart';
import '../../data_models/modelResortAvable.dart';
import '../../data_models/model_dart.dart';
import '../../data_models/model_propertyList.dart';
import '../../loadingScreen.dart';
import '../controllers/langaugeCotroller.dart';
import '../prefManager.dart';
import '../property/propertyDetails.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TouristScreen extends StatefulWidget {
   TouristScreen({super.key});

  @override
  State<TouristScreen> createState() => _TouristScreenState();
}

class _TouristScreenState extends State<TouristScreen> {
  final ctr = Get.put(TouristController());

  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctr.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('travel_to_cities',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: GoogleFonts.harmattan().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                color: AppColors.textBoxColor,
                border: Border.all(color: Color(0xFFECECEC)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                readOnly: false,
                autofocus: false,
                controller: _searchController,
                onChanged: ctr.searchCity,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: GoogleFonts.harmattan().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
                decoration:  InputDecoration(
                  //prefix: Container(width: 35,),

                  prefixIcon:const Icon(Icons.search, color: Colors.black38),
                  border: InputBorder.none,
                  hintText: tr("search_by_Cities"),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            // Container(
            //   child: TextFormField(
            //       controller: ctr.ctrCity,
            //       keyboardType: TextInputType.text,
            //       readOnly: true,
            //       onTap: (){
            //         ctr.showCity(context);
            //       },
            //       style: TextStyle(fontSize: 18,color: Colors.black,
            //         fontFamily: GoogleFonts.harmattan().fontFamily,
            //         fontWeight: FontWeight.w500,),
            //       decoration: InputDecoration(
            //         labelText: tr('Select City'),
            //         labelStyle: TextStyle(
            //           fontFamily: GoogleFonts.harmattan().fontFamily,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: const BorderSide(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15)
            //       ),
            //   ),
            // ),
           Obx(()
             => ctr.isLoad == true ? Expanded(
               child: Container(
                 child: Center(child: CircularProgressIndicator()),
               ),
             ) : Expanded(child: Obx(() => ctr.listCities.isNotEmpty ?
                 ListView.builder(
                     itemCount: ctr.listCities.length,
                     padding: const EdgeInsets.symmetric(vertical: 10),
                     itemBuilder: (itemBuilder,index){
                       Cities model = ctr.listCities[index];
                       return InkWell(
                         onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TouristDetailScreen(cities: model)));
                         },
                         child: Container(
                           height: 230,
                           margin: const EdgeInsets.only(bottom: 20),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: AppColors.primary,
                           ),
                           child: Stack(
                             children: [
                               Container(
                                 alignment: Alignment.center,
                                 width: double.maxFinite,
                                 child: model.image !=0 ? ClipRRect(
                                   borderRadius: BorderRadius.circular(10),
                                   child: Image(image:  CachedNetworkImageProvider(model.image!),fit: BoxFit.cover,width: double.maxFinite,height:double.maxFinite ,),
                                 ) : Container(),
                               ),
                               Container(
                                   alignment: Alignment.bottomCenter,
                                   child: Container(
                                     height: 50,
                                     alignment: Alignment.center,
                                     decoration: BoxDecoration(
                                       color: Colors.white.withOpacity(0.5),
                                       borderRadius: BorderRadius.circular(10)
                                         // gradient: LinearGradient(
                                         //     colors: [
                                         //       Colors.black.withOpacity(0.5),
                                         //       Colors.black.withOpacity(0.0),
                                         //     ],
                                         //     begin: Alignment.bottomCenter,
                                         //     end: Alignment.topCenter
                                         // )
                                     ),
                                     child: Text(
                                       tr(model.name!),
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontSize: 25,
                                         fontFamily: GoogleFonts.harmattan().fontFamily,
                                         fontWeight: FontWeight.w700,
                                         height: 1,
                                       ),
                                     ),
                                   )
                               )
                             ],
                           ),
                         ),
                       );
                     }
                 ) : Center(
                   child: Text("No data found",style: TextStyle(
                     fontFamily: GoogleFonts.harmattan().fontFamily,
                     fontWeight: FontWeight.w500,
                   ),),
                 ),
                 )
             ),
           )
          ],
        ),
      ),
    );
  }
}
