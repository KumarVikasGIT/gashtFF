

import 'dart:io';
import 'dart:typed_data';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/data_models/model_login.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:mj_image_slider/mj_options.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../loadingScreen.dart';
import '../../util/colors.dart';
import '../property/propertyImages.dart';
import 'package:dio/dio.dart';


class EditProperty extends StatefulWidget
{

  Property propertyList;
   EditProperty( this.propertyList, {super.key});


  @override
  State<EditProperty> createState() => _EditProperty();


}

class _EditProperty extends State<EditProperty> {

  final TextEditingController controllerPropertyName = TextEditingController();
  final TextEditingController controllerPropertyDescription = TextEditingController();
  final TextEditingController controllerAreaSqtft = TextEditingController();
  final TextEditingController controllerLivingDes = TextEditingController();
  final TextEditingController controllerBedroomDes = TextEditingController();
  final TextEditingController controllerKitchenDes = TextEditingController();
  final TextEditingController controllerWashroomDes = TextEditingController();
  final TextEditingController controllerPoolDes = TextEditingController();


  final TextEditingController controllerLivingNo = TextEditingController();
  final TextEditingController controllerBedroomNo = TextEditingController();
  final TextEditingController controllerKitchenNo = TextEditingController();
  final TextEditingController controllerWashroomNo = TextEditingController();
  final TextEditingController controllerPoolNo= TextEditingController();

  final TextEditingController controllerCity= TextEditingController();
  final TextEditingController controllerType= TextEditingController();

  final TextEditingController controllerPrice = TextEditingController();

  final TextEditingController controllerDOB = TextEditingController();

  List<DateTime?> _dialogCalendarPickerValue = [];


  bool selectedImg = false;
  List<Asset> images = <Asset>[];
  List<File> files = [];
  final List<String> itemsCounts = [
    'Zero',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven'
  ];
  late String livingNo,bedroomNo,kitchenNo,poolNo ,washroomNo;







  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerPrice.text = widget.propertyList.price.toString();
    controllerPropertyName.text = widget.propertyList.propertyName.toString();
    controllerPropertyDescription.text = widget.propertyList.propertyDescription.toString();
     controllerAreaSqtft.text = widget.propertyList.area.toString();
     controllerLivingDes.text = widget.propertyList.livDescription.toString();
     controllerBedroomDes.text = widget.propertyList.bedDescription.toString();
     controllerKitchenDes.text = widget.propertyList.kitDescription.toString();
     controllerWashroomDes.text = widget.propertyList.washDescription.toString();
    controllerPoolDes.text = widget.propertyList.poolDescription.toString();

    controllerLivingNo.text = widget.propertyList.livingroom.toString();
    controllerBedroomNo.text = widget.propertyList.bedroom.toString();
    controllerKitchenNo.text = widget.propertyList.kitchen.toString();
    controllerWashroomNo.text = widget.propertyList.washroom.toString();
    controllerPoolNo.text = widget.propertyList.pool.toString();
    controllerType.text = widget.propertyList.propertyType.toString();
    controllerCity.text = widget.propertyList.city.toString();




  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appColor,
          iconTheme: IconThemeData(color: Colors.white),

          centerTitle: true,
          title: const Text(
            "property_details", style: TextStyle(color: Colors.white),).tr(),),

        body: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [






                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   PropertyImages(widget.propertyList.images!),//const PlayList( tag: 'Playlists',title:'Podcast'),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 250,
                    child:  MJImageSlider(
                      options: MjOptions(
                        width: double.infinity,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      widgets: [...widget.propertyList.images!.map((e) => Image(image: NetworkImage(e),fit: BoxFit.fill,)).toList()],
                    ),

                  ),),

          _buildCalendarDialogButton(),

                const  SizedBox(height: 10,),

                Text(
                  'property_name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                const  SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: controllerPropertyName,
                  style: const TextStyle(color: Colors.black),
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Enter property name',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixStyle: const TextStyle(color: Colors.black),
                    suffixStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 10,),

                Text(
                  'what_makes_your_property_unique?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                const  SizedBox(height: 10,),
                SizedBox(
                  height: 150,
                  child: Center(child: TextField(
                    maxLines: 4,
                    enabled: false,
                    style: const TextStyle(color: Colors.black),

                    controller: controllerPropertyDescription,

                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixStyle: const TextStyle(color: Colors.black),
                      suffixStyle: const TextStyle(color: Colors.black),
                   //   hintText: 'Describe your property',
                      hintStyle:TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,

                        color: const Color(0xFF605D5D),
                      ) ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),),
                ),


                const  SizedBox(height: 10,),

                Text(
                  'area_of_your_property',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),

                const SizedBox(height: 10,),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerAreaSqtft,
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15,),

                Text(
                  'facilities',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily:GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: 0.60,
                  ),
                ).tr(),

                const SizedBox(height: 15,),

                //living room
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.door_sliding_outlined,    color: Color(0xFF605D5D),
                    ),
                    const SizedBox(width: 10,),

                    Text(
                      'living_room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),


                const  SizedBox(height: 10,),

                TextField(
                  controller: controllerLivingNo,
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),


                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    maxLines: 4,
                    controller: controllerLivingDes,
                    maxLength: 100,                    decoration: InputDecoration(
                 //   hintText: 'Describe your Living Room',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,

                      color: const Color(0xFF605D5D),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ),),
                ),


                const SizedBox(height: 1,),


                //bedroom
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.bed,    color: Color(0xFF605D5D),
                    ),
                    const SizedBox(width: 10,),

                    Text(
                      'bed_Rooms',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),


                const  SizedBox(height: 10,),

                TextField(
                  controller: controllerBedroomNo,
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    enabled: false,
                    style: const TextStyle(color: Colors.black),

                    controller: controllerBedroomDes,
                    maxLength: 100,                    decoration: InputDecoration(
                  //  hintText: 'Describe your  Bedroom',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,

                      color: const Color(0xFF605D5D),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ),),
                ),

                const SizedBox(height: 1,),
                //
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.soup_kitchen_outlined,    color: Color(0xFF605D5D),
                    ),
                    const SizedBox(width: 10,),

                    Text(
                      'kitchen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),


                const  SizedBox(height: 10,),

                TextField(
                  controller: controllerKitchenNo,
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    enabled: false,
                    style: const TextStyle(color: Colors.black),

                    controller: controllerKitchenDes,
                    maxLength: 100,                    decoration: InputDecoration(
                  //  hintText: 'Describe your Kitchen',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,

                      color: const Color(0xFF605D5D),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ),),
                ),


                //washroom

                const SizedBox(height: 1,),
                //
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.shower,    color: Color(0xFF605D5D),
                    ),
                    const SizedBox(width: 10,),

                    Text(
                      'washroom',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),


                const  SizedBox(height: 10,),

                TextField(
                  controller: controllerWashroomNo,
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    //hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    enabled: false,
                    style: const TextStyle(color: Colors.black),

                    controller: controllerWashroomDes,
                    maxLength: 100,                    decoration: InputDecoration(
                   // hintText: 'Describe your washroom',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,

                      color: const Color(0xFF605D5D),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ),),
                ),


                const SizedBox(height: 1,),


                //pool
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.pool,  color: Color(0xFF605D5D),
                    ),
                    const SizedBox(width: 10,),

                    Text(
                      'pool',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),


                const  SizedBox(height: 10,),

                TextField(
                  controller: controllerPoolNo,
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                  //  hintText: 'In Sq.ft',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerPoolDes,
                    enabled: false,
                    style: const TextStyle(color: Colors.black),

                    maxLength: 100,                    decoration: InputDecoration(
                  //  hintText: '',
                    hintStyle:TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins().fontFamily,

                      color: const Color(0xFF605D5D),
                    ) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  ),),
                ),



                const SizedBox(height: 10,),



                Text(
                  'where_is_located',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),

                const SizedBox(height: 10,),

                TextField(
                  controller: controllerCity,
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),




                const SizedBox(height: 10,),


            Text(
              'property_Type',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),

                const SizedBox(height: 10,),


                TextField(
                  controller: controllerType,
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

////////////////////////////////////////price///////////////////////



                const SizedBox(height: 10,),


                Text(
                  'price_(IQD)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),

                const SizedBox(height: 10,),


                TextField(
                  controller: controllerPrice,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),




                /*    Visibility(
                  visible: selectedImg,
                  child:  SizedBox(
                      width: double.maxFinite,
                      height: 250,
                      child:   GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: List.generate(
                            files.length, (index) {
                          //  Asset asset = images[index];
                          return Image.file(files[index]);
                        }),
                      )

                  ),),*/

                const SizedBox(height: 20,),


                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      elevation: 2.5,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: ()  {



                      //  logger.d("start time ====>>>>${controllerStartTime.text},,,,, end time ======>>>> ${controllerEndTime.text}");
                      nextPage(context);




                      // fetchList(context);


                    },


                    child: Text(
                        "update_Price", style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts
                            .harmattan()
                            .fontFamily,
                        color: Colors.white)).tr(),
                  ),

                )
              ],),
          ),
        ),

      );
  }


  _buildCalendarDialogButton() {
    const dayTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
    TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {

        return anniversaryTextStyle;
      },

      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(15),
                value: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white,
              );
              if (values != null) {
                
                var st =  _getValueText(config.calendarType, values,);


                if(st.contains("null"))
                  {


                  }
                else
                  {
                    _uploadUnavaialble(st);

                  }


                // ignore: avoid_print
                print(  "date == $st=== does null contains == ${st.contains("null")}");
                setState(() {
                  _dialogCalendarPickerValue = values;
                });
              }
            },
            child:  Text('mark_unavailable',style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily),).tr(),
          ),
        ],
      ),
    );
  }



  Future<void> _uploadUnavaialble(String values) async {


    List<String> dateParts = values.split(' to ');

    if (dateParts.length == 2) {
      String start_date = dateParts[0];
      String end_date = dateParts[1];


      buildLoading(context);


      RetrofitInterface retrofitInterface = RetrofitInterface(Dio());


      String ? token  = await PrefManager.getString("token");

      var model = await retrofitInterface.setUnavailability(token!, widget.propertyList.id!, start_date, end_date);


      if(model.status=="true")
        {

          Get.snackbar("Property set unavailable from $start_date to $end_date, Contact admin for any query","",colorText: Colors.white,backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);


        }
      else
        {
          Get.snackbar("Property not set unavailable, Contact admin for further ","",backgroundColor: AppColors.red,snackPosition: SnackPosition.BOTTOM);

        }

      Navigator.pop(context);




    } else {
      print("=====>>>>>>>>>>>>Invalid date range format");
    }


  }


  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values,) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }


/*
  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values,) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
*/





  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    const AlbumSetting albumSetting = AlbumSetting(
      fetchResults: {
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumFavorites,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.album,
          subtype: PHAssetCollectionSubtype.albumRegular,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumSelfPortraits,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumPanoramas,
        ),
        PHFetchResult(
          type: PHAssetCollectionType.smartAlbum,
          subtype: PHAssetCollectionSubtype.smartAlbumVideos,
        ),
      },
    );

    String error = 'No Error Detected';



    const SelectionSetting selectionSetting = SelectionSetting(
      min: 0,
      max: 3,
      unselectOnReachingMax: true,
    );
    const DismissSetting dismissSetting = DismissSetting(
      enabled: true,
      allowSwipe: true,
    );
    const ThemeSetting themeSetting = ThemeSetting(
      backgroundColor: AppColors.appColor,
      selectionFillColor: AppColors.appColor,
      selectionStrokeColor: AppColors.appColor,
      previewSubtitleAttributes: TitleAttribute(fontSize: 12.0),
      previewTitleAttributes: TitleAttribute(
        foregroundColor: AppColors.appColor,
      ),
      albumTitleAttributes: TitleAttribute(
        foregroundColor:AppColors.appColor,
      ),
    );
    const ListSetting listSetting = ListSetting(
      spacing: 5.0,
      cellsPerRow: 4,
    );




    const CupertinoSettings iosSettings = CupertinoSettings(
      fetch: FetchSetting(album: albumSetting),
      theme: themeSetting,
      selection: selectionSetting,
      dismiss: dismissSetting,
      list: listSetting,
    );
    try {
      resultList = await MultiImagePicker.pickImages(

        selectedAssets: images,
        cupertinoOptions:const CupertinoOptions(
          doneButton:
          UIBarButtonItem(title: 'Confirm', tintColor:AppColors.appColor),
          cancelButton:
          UIBarButtonItem(title: 'Cancel', tintColor: Colors.red),
          albumButtonColor: AppColors.appColor,
          settings: iosSettings,
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: AppColors.appColor,
          actionBarTitle: "Pick photos",
          allViewTitle: "All Photos",
          enableCamera: true,
          useDetailsView: true,
          maxImages: 5,
          selectCircleStrokeColor: AppColors.appColor,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      multipart();
    });
  }

  Future<void> multipart() async {
    // ... (Your existing code to fetch images)

    // Prepare the images for upload as MultipartFile objects

    List <File> file = [];

    for (Asset asset in images) {
      ByteData byteData = await asset.getByteData();
      final buffer = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${asset.name}');

      await tempFile.writeAsBytes(buffer);

      if (tempFile.existsSync()) {
        file.add(tempFile);
        selectedImg = true;
      }




    }

    setState(() {
      files = file;
    });

  }

  Future<void> nextPage(BuildContext context) async {

    RegExp phoneRegex = RegExp(r'^\d+(\.\d{1,2})?$');


    if (controllerPrice.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:const Text('property_price_is_required').tr(), backgroundColor: Colors.red));
      return;
    }

    if(!phoneRegex.hasMatch(controllerPrice.text.trim()))
      {

        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:const Text('property_price_is_required').tr(), backgroundColor: Colors.red));

        return;


      }

  /*  else if(controllerPropertyDescription.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Property Description is required'),
          backgroundColor: Colors.red));
      return;
    }

    else if(controllerAreaSqtft.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sq.ft of property is required'),
          backgroundColor: Colors.red));
      return;
    }*/



    else {



      buildLoading(context);
      String ? token = await PrefManager.getString("token");

      Dio dio = Dio();
      dio.options.baseUrl = 'https://gasht.co/public/api';

      FormData formData = FormData();
      formData.fields.add(MapEntry('token', token!));
      formData.fields.add(MapEntry('id', widget.propertyList.id.toString()));
      formData.fields.add(MapEntry('rent', controllerPrice.text.toString()));
      Response response = await dio.post(
        '/createProperty',
        // Replace with your API endpoint for uploading business data
        data: formData,
      );
      if (response.statusCode == 200) {
        print('=====>>>>>>>Business data uploaded successfully.');
        print('==========>>>>>>>Response: ${response.data}');



        Model_Login model = Model_Login.fromJson(response.data);




        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Property price updated successfully'),
            backgroundColor: Colors.green));


      } else {
        print(
            '=====>>>>>>>>>Failed to upload business data. Status code: ${response
                .statusCode}');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to update the price. Contact admin"),
            backgroundColor: Colors.red));
      }

    }
  }


}