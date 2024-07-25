import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gasht/ui/tourist/property_img.dart';
import 'package:gasht/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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

class PropertyDetailScreen extends StatefulWidget {
  PropertyDetailScreen({super.key,required this.property});

  final Property property;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {

  late GoogleMapController mapController;
  late  LatLng _center ;
  var customIcon;
  late Marker marker ;
  final Map<String, Marker> _markers = {};

  late Property data;
  Timer? _timer;
  int _currentPage = 0;

  final _pageController = PageController(viewportFraction: 1.0, keepPage: true,initialPage: 0);

  _autoScroll(){
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < data.images!.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  Future createMarker() async{
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/marker.png");
    setState(() {});
    marker =  Marker(
        markerId: MarkerId("Address"),
        icon: customIcon,
        position:_center);

    _markers["address"] = marker;
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.property;
    _autoScroll();
    _center = LatLng(data.latitude!,data.longitude!);
    createMarker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 350,
              width: MediaQuery.of(context).size.width,
              child:  Stack(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyImg(property: data)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: data.images!.length,
                        itemBuilder: (_, index) {
                          return CachedNetworkImage(
                            imageUrl: data.images![index],imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),);
                        },
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                        )
                      ),
                      height: 50,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: data.images!.length,
                        effect: const ExpandingDotsEffect(
                         dotColor: Colors.white,
                         activeDotColor: Colors.white,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 4
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_sharp,color: Colors.white,size: 30,),
                      onPressed: () {
                        print("ds");
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 315,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              tr("description"),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Text(
                              data.propertyDescription!,
                              style: TextStyle(
                                color: Color(0xff717171),
                                fontSize: 16,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 25,),
                            Container(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr("approximate_location"),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: GoogleFonts.harmattan().fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(
                                        "${tr(data.city!)}",
                                        style: TextStyle(
                                          color: Color(0xff262626),
                                          fontSize: 16,
                                          fontFamily: GoogleFonts.harmattan().fontFamily,
                                          fontWeight: FontWeight.w500,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: (){
                                      MapsLauncher.launchCoordinates(_center.latitude,_center.longitude);
                                    },
                                    child:  Container(
                                      margin: const EdgeInsets.only(right: 10,top: 12,left: 10),
                                      width: 90,
                                      height: 30,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 0.50, color: Color(0xFF8252AF)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Center(child:Text(
                                        tr('view_on_map'),
                                        style: TextStyle(
                                          color: const Color(0xFF8252AF),
                                          fontSize: 12,
                                          fontFamily: GoogleFonts.harmattan().fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                      ) ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25,),
                            SizedBox(
                              height: 350,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _center,
                                  zoom: 11.0,
                                ),
                                markers: _markers.values.toSet(),
                              )
                              ,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
