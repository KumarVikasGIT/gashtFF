
import 'package:path/path.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../util/colors.dart';
import 'addPropertyMaps.dart';

class AddProperty extends StatefulWidget
{

  const AddProperty({super.key});


  @override
  State<AddProperty> createState() => _AddProperty();


}

class _AddProperty extends State<AddProperty> {

  final TextEditingController controllerPropertyName = TextEditingController();
  final TextEditingController controllerPropertyDescription = TextEditingController();
  final TextEditingController controllerAreaSqtft = TextEditingController();

  final TextEditingController controllerLivingDes = TextEditingController();
  final TextEditingController controllerBedroomDes = TextEditingController();
  final TextEditingController controllerKitchenDes = TextEditingController();
  final TextEditingController controllerWashroomDes = TextEditingController();

  final TextEditingController controllerPoolDes = TextEditingController();


  bool selectedImg = false;
  List<Asset> images = <Asset>[];
  List<File> files = [];
  final List<String> itemsCounts = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7'
  ];
  late String livingNo,bedroomNo,kitchenNo,poolNo ,washroomNo;

  final TranslationController _translationController = Get.put( TranslationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appColor,
          iconTheme: IconThemeData(color: Colors.white),

          centerTitle: true,
          title:
          FutureBuilder(future: _translationController.getTransaltion(
            "add_Property_Details",

          ),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return       Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily),
                  );
                }
                else
                {
                  return

                    Text(
                     "Add Property Details",

                      style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily),
                    );
                }
              }),
        ),

        //  const Text("Add Property Details", style: TextStyle(color: Colors.white),),),

        body: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              const  SizedBox(height: 10,),
                FutureBuilder(future: _translationController.getTransaltion(
                  "enter_Property_Name",

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                           "Property Name",
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),


                const  SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: controllerPropertyName,

                  decoration: InputDecoration(
                    hintText: tr('enter_Property_Name'),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const  SizedBox(height: 10,),

                FutureBuilder(future: _translationController.getTransaltion(
                  'what_makes_your_property_unique?',

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'What makes your property unique?',
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),

                const  SizedBox(height: 10,),
                SizedBox(
                  height: 150,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerPropertyDescription,
                    maxLength: 250,
                    decoration: InputDecoration(
                      hintText: tr('describe_your_property',),
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

                FutureBuilder(future: _translationController.getTransaltion(
                  'area_of_your_property',

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'Area of your property (in meters)',
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),



                const SizedBox(height: 10,),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerAreaSqtft,
                  decoration: InputDecoration(
                    hintText: tr("in_meters"),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15,),

                FutureBuilder(future: _translationController.getTransaltion(
                  'facilities',

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'Facilities',
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),



                const SizedBox(height: 15,),

                //living room
                Row(
                  children: [
                    const SizedBox(width: 5,),

                    const Icon(Icons.door_sliding_outlined,    color: Color(0xFF605D5D),
                  ),
                    const SizedBox(width: 10,),
                    FutureBuilder(future: _translationController.getTransaltion(
                      'living_room',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Living Rooms',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                          }
                        }),


                  ],
                ),


                const  SizedBox(height: 10,),

                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint:  Text(
                    tr("select_number_of_available_rooms"),
                    style: const TextStyle(fontSize: 14),
                  ),
                  items: itemsCounts
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF605D5D),
                      ),
                    ),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select living room .';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when selected item is changed.
                    livingNo = value.toString();
                  },
                  onSaved: (value) {
                    livingNo = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerLivingDes,
                    maxLength: 100,                    decoration: InputDecoration(
                      hintText: tr("describe_Your_Living_rooms"),
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

                    FutureBuilder(future: _translationController.getTransaltion(
                      'bed_Rooms',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Bedrooms',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                          }
                        }),

                  ],
                ),


                const  SizedBox(height: 10,),

                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint:  Text(
                    tr("select_number_of_available_rooms"),
                    style: TextStyle(fontSize: 14),
                  ),
                  items: itemsCounts
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style:  TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,

                        color: const Color(0xFF605D5D),
                      ),
                    ),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select bedroom.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    bedroomNo = value.toString();

                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    bedroomNo = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerBedroomDes,
                    maxLength: 100,                    decoration: InputDecoration(
                      hintText: tr('describe_your_Bed_Rooms'),
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

                    FutureBuilder(future: _translationController.getTransaltion(
                      'kitchen',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Kitchen',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                          }
                        }),

                  ],
                ),


                const  SizedBox(height: 10,),

                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint:  Text(
                    tr("select_number_of_Kitchen"),
                    style: TextStyle(fontSize: 14),
                  ),
                  items: itemsCounts
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style:  TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,

                        color: const Color(0xFF605D5D),
                      ),
                    ),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select  no of Kitchen.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    kitchenNo = value.toString();

                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    kitchenNo = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerKitchenDes,
                    maxLength: 100,                    decoration: InputDecoration(
                      hintText: tr('describe_your_Kitchen'),
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

                    FutureBuilder(future: _translationController.getTransaltion(
                      'washroom',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Washrooms',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                          }
                        }),

                  ],
                ),


                const  SizedBox(height: 10,),

                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'select_Number_of_washroom',
                    style: TextStyle(fontSize: 14),
                  ).tr(),
                  items: itemsCounts
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style:  TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,

                        color: const Color(0xFF605D5D),
                      ),
                    ),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select  no of washrooms.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    washroomNo = value.toString();

                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    washroomNo = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerWashroomDes,
                    maxLength: 100,                    decoration: InputDecoration(
                      hintText: tr('describe_your_Washroom'),
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

                    FutureBuilder(future: _translationController.getTransaltion(
                      'pool',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Pools',
                                style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                          }
                        }),

                  ],
                ),


                const  SizedBox(height: 10,),

                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Add more decoration..
                  ),
                  hint:  Text(
                    tr("select_number_of_Pools"),
                    style: const TextStyle(fontSize: 14),
                  ),
                  items: itemsCounts
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style:  TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins().fontFamily,

                        color: const Color(0xFF605D5D),
                      ),
                    ),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select  no of pools.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    poolNo = value.toString();

                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    poolNo = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                const  SizedBox(height: 15,),

                SizedBox(
                  height: 120,
                  child: Center(child: TextField(
                    maxLines: 4,
                    controller: controllerPoolDes,
                    maxLength: 100,                    decoration: InputDecoration(
                      hintText: tr("describe_your_pool"),
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

                const  SizedBox(height: 1,),


                const SizedBox(height: 10,),

                FutureBuilder(future: _translationController.getTransaltion(
                  'images',

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'Images',
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),


                const SizedBox(height: 5,),

                Center(
                  child: Image.asset("assets/images/gallery.png",height: 50,alignment: Alignment.center,),

                ),
                const SizedBox(height: 5,),

                InkWell(
                  onTap: (){
                    loadAssets();
                  },
                  child:    Center(
                      child:
                      FutureBuilder(future: _translationController.getTransaltion(
                        'add_photos'

                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14,color: Colors.blue,fontFamily: GoogleFonts.poppins().fontFamily),
                              );
                            }
                            else
                            {
                              return

                                Text(
                                  '+ Add Photos',
                                  style: TextStyle(fontSize: 14,color: Colors.blue,fontFamily: GoogleFonts.poppins().fontFamily),
                                );
                            }
                          }),



                  ),),
                const SizedBox(height: 5,),

                 Center(child:

                FutureBuilder(future: _translationController.getTransaltion(
                  'browse_pics_to_upload'

                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'Browse pics to upload',
                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily),
                          );
                      }
                    }),

                )
                ,

                const SizedBox(height: 30,),

                Visibility(
                  visible: selectedImg,
                  child:  SizedBox(
                      width: double.maxFinite,
                      //height: 250,
                      child:   GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: List.generate(
                            files.length, (index) {
                          //  Asset asset = images[index];
                          return Column(
                            children: [
                              Expanded(child: Image.file(files[index],height: 250,)),
                              const SizedBox(height: 5,),
                              Text(basename(files[index].path),style: TextStyle(fontSize: 10,color: Colors.black,fontFamily: GoogleFonts.lato().fontFamily),textAlign: TextAlign.center,)
                            ],
                          );
                        }),
                      )

                  ),),

                const SizedBox(height: 30,),


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


                    child:

                    FutureBuilder(future: _translationController.getTransaltion(
                      'next',

                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: GoogleFonts.lato().fontFamily),
                            );
                          }
                          else
                          {
                            return

                              Text(
                                'Next',
                                style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: GoogleFonts.lato().fontFamily),
                              );
                          }
                        }),



                  ),

                )
              ],),
          ),
        ),

      );
    }

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
      min: 1,
      max: 20,
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
          UIBarButtonItem(title: 'Confirm', tintColor:Colors.white),
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
          maxImages: 20,
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

  void nextPage(BuildContext context) {

    for(var element in files){
      final ext = extension(element.path).toLowerCase();
      if(ext  != '.png' && ext  != '.jpeg' && ext  != '.jpg'){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content:const Text('invalid-img').tr(),
            backgroundColor: Colors.red));
        return;
      }
    }

    if (controllerPropertyName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content:const Text('property_name_is_required').tr(),
          backgroundColor: Colors.red));
    return;
    }
    else if(controllerPropertyDescription.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content:const Text('property_Description_is_required').tr(),
            backgroundColor: Colors.red));
        return;
      }
/*   else if (controllerCity.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Property City is required'),
          backgroundColor: Colors.red));
      return;
    }*/
    else if(controllerAreaSqtft.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content:const Text('area_of_property_is_required').tr(),
          backgroundColor: Colors.red));
      return;
    }


  /*  else if (livingNo
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Living r Id is required'),
          backgroundColor: Colors.red));
    }

    else if (bedroomNo
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sub Category Id is required'),
          backgroundColor: Colors.red));
    }
    else if (controllerBusinessDescription.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Business Description is required'),
          backgroundColor: Colors.red));
    }
    else if (facilitieId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Facility is required'), backgroundColor: Colors.red));
    }

    else if (controllerStartTime.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Start time is required'),
          backgroundColor: Colors.red));
    }
    else if (controllerStartTime.text
        .trim()=="Select Time") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Opening  time is required'),
          backgroundColor: Colors.red));
    }
    else if (controllerEndTime.text
        .trim()=="Select Time") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Closing  time is required'),
          backgroundColor: Colors.red));
    }
    else if (controllerEndTime.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Closing time is required'),
          backgroundColor: Colors.red));
    }*/


    else if (files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content:const Text('at_least_one_image_is_required').tr(),
          backgroundColor: Colors.red));
    }

    else {

     // logger.d("facilities sata added ====>>>${facilitieId.toString()}");

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return AddPropertyMaps(controllerPropertyName.text,controllerPropertyDescription.text,controllerAreaSqtft.text,livingNo,controllerLivingDes.text,bedroomNo,controllerBedroomDes.text,kitchenNo,controllerKitchenDes.text,poolNo,controllerPoolDes.text,files,controllerWashroomDes.text,washroomNo);
      }));

     /* Navigator.push(
          context, MaterialPageRoute(builder: (context) {
        return AddBusiness2(widget.model,controllerBusinessName.text,categoryId,subCategoryId,controllerBusinessDescription.text,facilitieId,controllerStartTime.text,controllerEndTime.text,files,weekoff);
      }));*/
    }
  }


}