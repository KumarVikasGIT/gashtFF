import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/tourist/property_detail_screen.dart';
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
import '../property/maps.dart';
import '../property/propertyDetails.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class TouristDetailScreen extends StatefulWidget {
  TouristDetailScreen({super.key,required this.cities});

  final Cities cities;

  @override
  State<TouristDetailScreen> createState() => _TouristDetailScreenState();
}

class _TouristDetailScreenState extends State<TouristDetailScreen> {

  late Cities data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height:300,
            width: MediaQuery.of(context).size.width,
            child:  Stack(
              children: [
                data.image == null ? Container() : Image(image:CachedNetworkImageProvider(data.image!),fit: BoxFit.fill,width: double.infinity,height: 300,),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      color: Colors.black.withOpacity(0.2),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.black.withOpacity(0.3),
                      //     Colors.black.withOpacity(0.1),
                      //   ],
                      //   begin: Alignment.bottomCenter,
                      //   end: Alignment.topCenter
                      // )
                    ),
                    child: Text(
                      tr(data.name!),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_sharp,color: Colors.white,size: 30,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )
          ),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              tr('discover-tranquility'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: GoogleFonts.harmattan().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(child: ListView.builder(
              itemCount: data.resorts.length,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              itemBuilder: (itemBuilder,index){
                Property model = data.resorts[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailScreen(property: model)));
                  },
                  child: Container(
                    height: 160,
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
                          child: model.images!.length !=0 ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image:  CachedNetworkImageProvider(model.images![0]),fit: BoxFit.cover,width: double.maxFinite,height:double.maxFinite,),
                          ) : Container(),
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter
                                  )
                              ),
                              child: Text(
                                model.propertyName!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                );
              }
          )
                   ),
        ],
      ),
    );
  }
}
