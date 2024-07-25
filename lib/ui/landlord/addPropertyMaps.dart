
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/loadingScreen.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/landlord/bottomLandlord.dart';
import 'package:gasht/ui/landlord/landDashboard.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/dashboardModel.dart';
import '../../util/colors.dart';
import '../dashboard/controllers/dashboardController.dart';
import '../prefManager.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:path/path.dart' as p;



class AddPropertyMaps extends StatefulWidget
{
  String propertyName;
  String propertyDes;
  String area;
  String  livingNo;
  String  livingDes;
  String bedroomNo;
  String bedroomDes;
  String kitchenNo ;
  String kitchenDes;
  String poolNo;
  String poolDes;
  List<File> files1;
  String washRoomNo;
  String washroomDes;

   AddPropertyMaps(this.propertyName,this.propertyDes,this.area,this.livingNo,this.livingDes,this.bedroomNo,this.bedroomDes,this.kitchenNo,
       this.kitchenDes,this.poolNo,this.poolDes,  this.files1, this.washroomDes,this.washRoomNo  ,{super.key});


  @override
  State<AddPropertyMaps> createState() => _AddPropertyMaps();


}

class _AddPropertyMaps extends State<AddPropertyMaps> {


  late GoogleMapController mapController;


  final PropertyTypeController cityCOntroller = Get.put(PropertyTypeController());

  final TranslationController _translationController = Get.put(TranslationController());

  late  LatLng _center =  const LatLng(37.42796133580664, -122.085749655962);

  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerFullAddress = TextEditingController();
  final TextEditingController controllerLatitude = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();

  final TextEditingController controllerTerms = TextEditingController();
  final TextEditingController controllerCals = TextEditingController();





  List<String> selectedTexts = [];
  List<String> selectedCalTexts = [];

   String controllerCity = '';
   String state='';
   String propertyType='';
   String rentType='';
   String tententType = '';
   String smokingType = '';


 /* final rentTypeList = [
         "Daily", "Weekly", "Monthly"

   ];*/

  final smokingList = [
    "No Smoking", "Smoking allowed", "Outside the property"

  ];

  final tententTypeList = [
    //"Only Boys", "Only Girls", "Co-Living","Family","Bachelors","Working Professionals"
    tr("for_singles"),
    tr("for_families"),
    tr("both-families-singles"),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = <Marker>{};


 CameraPosition cameraPosition = const CameraPosition(
  target:  LatLng(37.42796133580664, -122.085749655962),
  zoom: 15.0,
  );

  String lati='';
  String longi='';
  String? _currentAddress;
  Position? _currentPosition;
  List<Asset> images = <Asset>[];
  List<File> files = [];

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        markers.clear(); // Remove any existing markers

        _currentPosition = position;


        _center = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);


        cameraPosition =  CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 15.0,
        );





        print("===========>>>>>>>>>>>>>>>...VCamera position........ $cameraPosition");
        markers.add(
          Marker(
            markerId: MarkerId(

              "${_currentPosition!.latitude}${_currentPosition!.longitude}"
            ),
            position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );



        lati = "${_currentPosition?.latitude??''}";
        longi = "${_currentPosition?.longitude??''}";
        controllerLatitude.text = "${_currentPosition?.latitude??''},${_currentPosition?.longitude??''}";

        print(">>>----- latitude longitude  ${controllerLatitude.text}");

      });
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }



  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        controllerFullAddress.text =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode},${place.administrativeArea},${place.postalCode}';
      controllerFullAddress.text =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode},${place.administrativeArea},${place.postalCode}';
      });

      // Add a marker at the fetched position
      _addMarker(LatLng(position.latitude, position.longitude));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _addMarker(LatLng position) {
    setState(() {
      markers.clear(); // Remove any existing markers
      markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
    });
  }

final  PropertyTypeController _propertyTypeController = Get.put(PropertyTypeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // categoryList = widget.model.categories;
    _getCurrentPosition();




  }

  RetrofitInterface apiInterface = RetrofitInterface(Dio());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title:
        FutureBuilder(future: _translationController.getTransaltion(

          'add_Location_and_Terms',

        ),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: GoogleFonts.harmattan().fontFamily),
                );
              }
              else
              {
                return

                  Text(
                    'Add Location and Terms',
                    style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: GoogleFonts.harmattan().fontFamily),
                  );
              }
            }),
      ),



      body:
     Obx((){
        if (_propertyTypeController.isLoading.isTrue) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Colors.green));
        }
        else if (_propertyTypeController.isLoading.isFalse){
          var cities = _propertyTypeController.cityList;
          var propertyTypeList  = _propertyTypeController.propertyType;
          return  SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 350,
                  child:  GoogleMap(
                    onTap: _handleTap,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    buildingsEnabled: true,
                    onMapCreated: _onMapCreated,
                    markers: markers,
                    initialCameraPosition:cameraPosition,
                  ) ,
                ),

                const  SizedBox(height: 10,),

                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: SingleChildScrollView(
                    child:
                    Column(
                        crossAxisAlignment:  CrossAxisAlignment.start,

                        children:[
                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'landlord_ID',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Landlord ID',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),




                          const SizedBox(height: 10,),

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
                                  'add_photos',

                                ),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,color: Colors.blue,fontFamily: GoogleFonts.harmattan().fontFamily),
                                        );
                                      }
                                      else
                                      {
                                        return

                                          Text(
                                            '+ Add Photo',
                                            style: TextStyle(fontSize: 14,color: Colors.blue,fontFamily: GoogleFonts.harmattan().fontFamily),
                                          );
                                      }
                                    }),


                            ),),
                          const SizedBox(height: 5,),

                           Center(child:
                           FutureBuilder(future: _translationController.getTransaltion(
                             'browse_pics_to_upload',

                           ),
                               builder: (context,snapshot){
                                 if(snapshot.hasData)
                                 {
                                   return       Text(
                                     snapshot.data!,
                                     textAlign: TextAlign.center,
                                     style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                   );
                                 }
                                 else
                                 {
                                   return

                                     Text(
                                       'Browse pics to upload',
                                       style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                     );
                                 }
                               }),

                           ),

                          const SizedBox(height: 10,),

                          Visibility(
                            visible: selectedImg,
                            child:  SizedBox(
                                width: double.maxFinite,
                                //height: 150,
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
                                        Text(p.basename(files[index].path),style: TextStyle(fontSize: 10,color: Colors.black,fontFamily: GoogleFonts.lato().fontFamily),textAlign: TextAlign.center,)
                                      ],
                                    );
                                  }),
                                )

                            ),),
                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'where_is_located',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Where is it located?',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),


                          const SizedBox(height: 10,),


                          CustomDropdown<City>.search(
                            hintText: tr('select_city'),
                            maxlines: 1,
                            items: cities!, // Use the name property for display
                            excludeSelected: false,
                            onChanged: (value) {
                              log('changing value to: ${value.id}');

                              controllerCity = value.id.toString();
                              state = value.stateId.toString();
                            },
                          ),


                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'full_address',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Full address',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),


                          const SizedBox(height: 10,),

                          TextField(
                            keyboardType: TextInputType.text,
                            controller: controllerFullAddress,

                            decoration: InputDecoration(
                              hintText: 'including landmark',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'latidude_and_longidude',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Latitude and Longitude',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),

                          const SizedBox(height: 10,),

                          TextField(
                            keyboardType: TextInputType.text,
                            controller: controllerLatitude,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: '0.0,0.0',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'property_Type',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Property Types',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),



                          CustomDropdown<PropertyType>(
                            hintText: tr('select_the_property_type'),
                            maxlines: 1,
                            items: propertyTypeList, // Use the name property for display
                            excludeSelected: false,
                            onChanged: (value) {
                              //log('changing value to: ${value.id}');
                              propertyType = value.id.toString();

                            },
                          ),
                          const SizedBox(height: 10,),
/*
                          FutureBuilder(future: _translationController.getTransaltion(
                            'Rent Type',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Rent Type',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),


                          CustomDropdown<String>(
                            hintText: 'Select rent type',
                            maxlines: 1,
                            items: rentTypeList, // Use the name property for display
                            excludeSelected: false,
                            onChanged: (value) {
                              //log('changing value to: ${value.id}');
                              rentType = value;

                            },
                          ),
                          const SizedBox(height: 10,),*/

                          FutureBuilder(future: _translationController.getTransaltion(
                            'tenant_type',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Tenant Type',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),


                          CustomDropdown<String>(
                            hintText: tr('select_the_tentant_type'),
                            maxlines: 1,
                            items: tententTypeList, // Use the name property for display
                            excludeSelected: false,
                            onChanged: (value) {
                              //log('changing value to: ${value.id}');
                              tententType = value;

                            },
                          ),
                          const SizedBox(height: 10,),

                          FutureBuilder(future: _translationController.getTransaltion(
                            'smoking_type',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Smoking Type',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),


                          CustomDropdown<String>(
                            hintText: tr('select_Smoking_type'),
                            maxlines: 1,
                            items: smokingList, // Use the name property for display
                            excludeSelected: false,
                            onChanged: (value) {
                              //log('changing value to: ${value.id}');
                              smokingType = value;

                            },
                          ),
                          const SizedBox(height: 10,),

                          FutureBuilder(future: _translationController.getTransaltion(
                            'price_(IQD)',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Price (AED)',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),



                          const SizedBox(height: 10,),


                          TextField(
                            keyboardType: TextInputType.number,
                            controller: controllerPrice,

                            decoration: InputDecoration(
                              hintText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),





                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'phone_no',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Phone',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),

                          const SizedBox(height: 10,),


                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: controllerPhone,

                            decoration: InputDecoration(
                              hintText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const  SizedBox(height: 10,),
//////////////////////////////////////


                          const SizedBox(height: 10,),
                          FutureBuilder(future: _translationController.getTransaltion(
                            'property_terms',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Select Terms and Conditions',
                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),

                          const SizedBox(height: 10,),


                           SizedBox(
                            height: 250,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:  cityCOntroller.terms.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title:


                                //  Text(texts[index]),

                                  FutureBuilder(future: _translationController.getTransaltion(
                                    cityCOntroller.terms[index],

                                  ),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return       Text(
                                            snapshot.data!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                          );
                                        }
                                        else
                                        {
                                          return

                                            Text(
                                              cityCOntroller.terms[index],
                                              textAlign: TextAlign.start,

                                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                            );
                                        }
                                      }),




                                  value: selectedTexts.contains(  cityCOntroller.terms[index],),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null && value) {
                                        // Add text to the selected list
                                        selectedTexts.add(  cityCOntroller.terms[index]);
                                      } else {
                                        // Remove text from the selected list
                                        selectedTexts.remove(  cityCOntroller.terms[index],);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),


                          const SizedBox(height: 10,),




                          ////manual terms input

                          SizedBox(
                            height: 150,
                            child: Center(child: TextField(
                              maxLines: 4,
                              controller: controllerTerms,
                              maxLength: 250,
                              decoration: InputDecoration(
                              hintText: tr('add_manually_The_Terms_and_Conditions'),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: GoogleFonts.harmattan().fontFamily,

                                color: const Color(0xFF605D5D),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            ),),
                          ),
                          const  SizedBox(height: 10,),
//////////////////////////////// cancellation policy

                          FutureBuilder(future: _translationController.getTransaltion(
                            'cancelation_and_postponement_policy',

                          ),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                  );
                                }
                                else
                                {
                                  return

                                    Text(
                                      'Select Cancellation policy',

                                      style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                    );
                                }
                              }),

                          const SizedBox(height: 10,),


                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:  cityCOntroller.cancalltion.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title:


                                  //  Text(texts[index]),

                                  FutureBuilder(future: _translationController.getTransaltion(
                                    cityCOntroller.cancalltion[index],

                                  ),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return       Text(
                                            snapshot.data!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                          );
                                        }
                                        else
                                        {
                                          return

                                            Text(
                                              cityCOntroller.cancalltion[index],
                                              textAlign: TextAlign.start,

                                              style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                                            );
                                        }
                                      }),




                                  value: selectedCalTexts.contains(  cityCOntroller.terms[index],),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null && value) {
                                        // Add text to the selected list
                                        selectedCalTexts.add(  cityCOntroller.terms[index]);
                                      } else {
                                        // Remove text from the selected list
                                        selectedCalTexts.remove(  cityCOntroller.terms[index],);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),


                          const SizedBox(height: 10,),




                          ////manual terms input

                          SizedBox(
                            height: 150,
                            child: Center(child: TextField(
                              maxLines: 4,
                              controller: controllerCals,
                              maxLength: 250,
                              decoration: InputDecoration(
                                hintText: tr('add_manually_Cancellation_Policy'),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,

                                  color: const Color(0xFF605D5D),
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),),
                          ),
                          const  SizedBox(height: 10,),


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

                                for(var element in files){
                                  final ext = p.extension(element.path).toLowerCase();
                                  if(ext  != '.png' && ext  != '.jpeg' && ext  != '.jpg'){
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                        content:const Text('invalid-img').tr(),
                                        backgroundColor: Colors.red));
                                    return;
                                  }
                                }

                                if(controllerCity.isEmpty)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                      content:const Text('select_city').tr(),
                                      backgroundColor: Colors.red,));
                                    return;

                                  }
                             /*   if(rentType.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Select the rent type'),
                                    backgroundColor: Colors.red,));
                                  return;

                                }*/
                                //
                                if(tententType.isEmpty)
                                {


                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content:const Text('select_the_tentant_type').tr(),
                                    backgroundColor: Colors.red,));

                                  return;


                                }
                                if(smokingType.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content:const Text('select_Smoking_type').tr(),
                                    backgroundColor: Colors.red,));
                                  return;
                                }
                                if(controllerPrice.text.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('property_price_is_required'),
                                    backgroundColor: Colors.red,));
                                  return;

                                }
                                if (!isNumeric(controllerPrice.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('numeric_price').tr(),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                if(controllerPhone.text.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content:const Text('phone_no').tr(),
                                    backgroundColor: Colors.red,));
                                  return;

                                }
                                if(controllerTerms.text.isEmpty&&selectedTexts.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content: const Text('add_manually_The_Terms_and_Conditions').tr(),
                                    backgroundColor: Colors.red,));
                                  return;
                                }
                                if(controllerCals.text.isEmpty&&selectedCalTexts.isEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content:const Text('cancelation_and_postponement_policy').tr(),
                                    backgroundColor: Colors.red,));
                                  return;
                                }


                                else {

                                  if(controllerTerms.text.isNotEmpty) {
                                    selectedTexts.add(controllerTerms.text);
                                  }
                                  if(controllerCals.text.isNotEmpty) {
                                    selectedCalTexts.add(controllerCals.text);
                                  }
                                  buildLoading(context);
                                   // logger.d("start time ====>>>>${controllerStartTime.text},,,,, end time ======>>>> ${controllerEndTime.text}");
                                  uploadData(context)
                                      .then((success) {
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                        content:const Text(
                                            'Property_Sent_for_approval_Successfully').tr(),
                                        backgroundColor: Colors.green,));
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      Navigator.of(context)
                                          .pop(); // Close the dialog

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                            return const BottomLandlord();
                                          }));
                                    }

                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Failed to add business"),
                                        backgroundColor: Colors.red,));
                                      Navigator.of(context).pop();
                                    }
                                  });
                                }

                                // fetchList(context);


                              },


                              child:
                              FutureBuilder(future: _translationController.getTransaltion(
                                'next',

                              ),
                                  builder: (context,snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: GoogleFonts
                                                .harmattan()
                                                .fontFamily),
                                      );
                                    }
                                    else {
                                      return
                                        Text(
                                            "Next",
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts
                                                    .lato()
                                                    .fontFamily,
                                                color: Colors.white));
                                    }
                                  })


                             ,
                            ),

                          ),

                          ////////////////////



                        ]
                    ),
                  ),
                )




              ],
            ),
          );

        }
        else {
          return const Text("No internet connection");
        }

      }),



    );
  }



  Future<ModelDashboard> getDashboard() async {
    try {
    //  String? token = await PrefManager.getString("token");
      return apiInterface.getDashboard("");

    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
  }


  void _handleTap(LatLng tappedPoint) {
    setState(() {
      controllerLatitude.text = '${tappedPoint.latitude},${tappedPoint.longitude}';

      markers.clear(); // Remove any existing markers
      markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ),
      );
    });
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
          maxImages: 1,
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
  bool selectedImg = false;

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

  Future<bool> uploadData(BuildContext context) async {
    try {
      String ? token = await PrefManager.getString("token");

      Dio dio = Dio();
      dio.options.baseUrl = 'https://gasht.co/public/api';

      FormData formData = FormData();
      formData.fields.add(MapEntry('token', token!));
      formData.fields.add(MapEntry('title', widget.propertyName));
      formData.fields.add(MapEntry('size', widget.area));
      formData.fields.add(const MapEntry('sizeUnit', 'meters'));
      formData.fields.add(MapEntry('rent', controllerPrice.text));
      formData.fields.add(MapEntry('rentType', rentType));
      formData.fields.add(MapEntry('description', widget.propertyDes));
      formData.fields.add(MapEntry('city', controllerCity));
      formData.fields.add(MapEntry('latitude', lati));
      formData.fields.add(MapEntry('longitude', longi));
      formData.fields.add(MapEntry('livingrooms', widget.livingNo));
      formData.fields.add(MapEntry('livingdescription', widget.livingDes));
      formData.fields.add(MapEntry('bedrooms', widget.bedroomNo));
      formData.fields.add(MapEntry('beddescription', widget.bedroomDes));
      formData.fields.add(MapEntry('kitchen', widget.kitchenNo));
      formData.fields.add(MapEntry('kitchendescription', widget.kitchenDes));
      formData.fields.add(MapEntry('washroom', widget.kitchenNo));
      formData.fields.add(MapEntry('washdescription', widget.livingDes));
      formData.fields.add(MapEntry('pool', widget.poolNo));
      formData.fields.add(MapEntry('pooldescription', widget.poolDes));
      formData.fields.add(MapEntry('state', state));
      formData.fields.add( MapEntry('propertyTerms',  selectedTexts.join(', ')));
      formData.fields.add( MapEntry('cancellationPolicy', selectedCalTexts.join(', ')));

      formData.fields.add(MapEntry('propertyTypes', propertyType));
      formData.fields.add(MapEntry('tenentType', tententType));
      formData.fields.add(MapEntry('smoking', smokingType));
      formData.fields.add(MapEntry('phone', controllerPhone.text));


      for (int i = 0; i < widget.files1.length; i++) {
        formData.files.add(
          MapEntry(
            'images[]',
            await MultipartFile.fromFile(widget.files1[i].path),
          ),
        );
      }
      formData.files.add(
        MapEntry(
          'id_proof',
          await MultipartFile.fromFile(files[0].path),
        ),
      );
      Response response = await dio.post(
        '/createProperty',
        // Replace with your API endpoint for uploading business data
        data: formData,
      );
      print("response property $response");

      if (response.statusCode == 200) {
        print('=====>>>>>>>Business data uploaded successfully.');
        print('==========>>>>>>>Response: ${response.data}');
        return true;
      } else {
        print(
            '=====>>>>>>>>>Failed to upload business data. Status code: ${response
                .statusCode}');
        return false;
      }
    }

  catch (e) {
  print('=====>>>>>Error uploading business data: $e');
  return false;
  }

  }
  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}