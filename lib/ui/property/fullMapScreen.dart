import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/property/propertyDetails.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import '../controllers/langaugeCotroller.dart';
import '../dashboard/controllers/dashboardController.dart';
import '../dashboard/controllers/propertyController.dart';


enum perState{
  Not,
  Denied,
  Granted
}
class FullMapScreen extends StatefulWidget {
  List<Property> propertyList;
  FullMapScreen(this.propertyList, {Key? key}) : super(key: key);

  @override
  State<FullMapScreen> createState() => _FullMapScreen();
}

class _FullMapScreen extends State<FullMapScreen> {


  late GoogleMapController mapController;


  final PropertyTypeController _proType  = Get.put(PropertyTypeController());
  PropertyController propertyController = Get.put(PropertyController());
  final TranslationController _translationController = Get.put(TranslationController());
  int cityId = 0;
  int propertyId = 0;

  perState _state = perState.Not;
  bool isLoad = true;

  //final LatLng _center = const LatLng(37.42796133580664, -122.085749655962);
  LatLng _currentPos =  LatLng(37.42796133580664, -122.085749655962);
  final logger  = Logger();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final Set<Marker> _markers = {};
  Property? _selectedProperty;
  var customIcon;

  Future createMarker() async{
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/marker.png");
    setState(() {});
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _state = perState.Denied;
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _state = perState.Denied;
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _state = perState.Denied;
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if(_state != perState.Denied){
      var pos = await Geolocator.getCurrentPosition();
      print("currentPos ${pos}");

      _currentPos = LatLng(pos.latitude, pos.longitude);
    }

    setState(() {
      _state = perState.Granted;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    createMarker();
    _determinePosition();
    //  _setupMarkers();

  }
  Set<Marker>  _setupMarkers(){




    for (Property property in widget.propertyList) {
      if (property.latitude != null && property.longitude != null) {
        //  LatLng position = LatLng(property.latitude!, property.longitude!);


        // logger.d("position:===$position");


        Marker marker = Marker(
          markerId: MarkerId(property.id.toString()),
          position: LatLng(property.latitude!, property.longitude!),
          icon: customIcon,
          onTap: () {
            _onMarkerTapped(property);
          },

        );

        _markers.add(marker);

        //logger.d("size of _marker:===${_markers.length}");


      }
      else
      {
        //logger.d("size of _marker in else case:===${_markers.length}");


      }
    }

    if(_markers.isNotEmpty)
    {
      return _markers;
    }
    else
    {
      return _markers;
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            _state == perState.Not ? Container(color: Colors.white,) : GoogleMap(
              onTap: (LatLng latLng) {
                // showBottom(latLng,context);
                //   logger.d(message)
              },
              markers: _setupMarkers() ,
              /* markers: {
               Marker(
                markerId: MarkerId("Sydney"),
                position: LatLng(28.41350001,77.04150001),
                 onTap: () {
                   _onMarkerTapped(widget.propertyList[0]);
                 },
              ), // Marker
            },*/


              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPos,
                zoom: 11.0,
              ),
            ),
            Positioned(
              top: 50.0,
              right: 0.0,
              left: 0,
              child:  Center(
                child: Container(
                  width: 154,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF5A409B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 1,
                        offset: Offset(1, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),


                  child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const   Icon(Icons.filter_list_outlined,color: Colors.white,),
                      const SizedBox(width: 5,),

                      InkWell(
                        onTap: _showFilter,
                        child: Text(
                          'filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                            letterSpacing: 1,
                          ),
                        ).tr(),
                      ),


                      const VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'listing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                            letterSpacing: 1,
                          ),
                        ).tr(),
                      ),


                    ],
                  ) ,

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onMarkerTapped(Property property) {
    setState(() {
      _selectedProperty = property;
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return  InkWell(
          child:  Container(

              margin: const EdgeInsets.only(left: 20,right: 20, top: 5,bottom: 5),
              width: double.infinity,
              height: 300,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.70, color:Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              child: Column(children: [
                Image.network(property.images![0].toString(),height: 140,fit: BoxFit.fill,width: double.infinity,),

                //for price and heart
                Row(
                  children: [

                    Container(
                      margin: const EdgeInsets.only(left: 10,top: 5),
                      child:   Text(
                        "${property.price} AED ",
                        style: TextStyle(
                          color: const Color(0xFF303030),
                          fontSize: 13,
                          fontFamily:GoogleFonts.inter.toString(),
                          fontWeight: FontWeight.w600,
                          height: 1.54,
                        ),
                      ),
                    ),

                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 10,top: 5),
                      child:   IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined)),
                    ),

                  ],

                ),


                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.bed),
                    Text(
                      property.bedroom.toString(),
                      style: TextStyle(
                        color: const Color(0xFF3D405B),
                        fontSize: 10,
                        fontFamily: GoogleFonts.inter.toString(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.crop_square),
                    Text(
                      property.area.toString(),
                      style: TextStyle(
                        color: const Color(0xFF3D405B),
                        fontSize: 10,
                        fontFamily: GoogleFonts.inter.toString(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10,top: 5),
                      child:   Text(
                        "${property.propertyName} (${property.propertyType})",
                        style: TextStyle(
                          color: const Color(0xFF303030),
                          fontSize: 13,
                          fontFamily:GoogleFonts.inter.toString(),
                          fontWeight: FontWeight.w600,
                          height: 1.54,
                        ),
                      ),
                    ),

                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 10,top: 5),
                      child:
                      Text(
                        'Unit Code(${property.id})',
                        style: TextStyle(
                          color: const Color(0xFF4F4F4F),
                          fontSize: 11,
                          fontFamily: GoogleFonts.poppins.toString(),
                          fontWeight: FontWeight.w400,
                          height: 1.82,
                        ),
                      ),
                    ),
                  ],
                ),
/*
                Row(
                  children: [

                    Container(
                      margin: const EdgeInsets.only(left: 0,top: 5),
                      child:   IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye_outlined,color: Colors.yellow,)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10,top:5),
                      child:     Text(
                        '1,300 views',
                        style: TextStyle(
                          color: const Color(0xFFFBBC05),
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins.toString(),
                          fontWeight: FontWeight.w400,
                        ),
                      ), ),

                  ],

                )
*/

              ],
              )
          ),



          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>    PropertyDetails(property,"",""),//const PlayList( tag: 'Playlists',title:'Podcast'),
              ),
            );
          },
        );
      },
    );
  }

  _showFilter(){

    var startValue = 0.0;
    var endValue = 1500.0;
    Get.bottomSheet(
      StatefulBuilder(
          builder: (context, setState) {
            return   Container(
              color: Colors.white,
              height: 800,
              margin: const EdgeInsets.only(left: 10,right: 10),

              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Text(
                          'filter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                          ),
                        ).tr()
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      alignment: Alignment.centerLeft,
                      child: FlutterSlider(
                        values: [startValue, endValue],
                //              ignoreSteps: [
                //                FlutterSliderIgnoreSteps(from: 120, to: 150),
                //                FlutterSliderIgnoreSteps(from: 160, to: 190),
                //              ],
                        max: 5000,
                        min: 0,
                        // maximumDistance: 300,
                        rangeSlider: true,
                        //  rtl: true,
                        handlerAnimation: const FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: null,
                            duration: Duration(milliseconds: 700),
                            scale: 1.4),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          setState(() {
                            startValue = lowerValue;
                            endValue = upperValue;
                            propertyController.filterProperties(lowerValue, upperValue, "");

                          });
                        },
                      ),
                    ),

                    Obx(() =>   ListView.builder(

                      itemCount: _proType.wishlist.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        bool values = propertyController.selectedIds.contains( _proType.wishlist[index].propertyType!);

                        return Container(
                          margin: const EdgeInsets.only(left: 20,top: 15),
                          alignment: Alignment.centerLeft,

                          child:   Row(children: [


                            CircleAvatar(
                                radius: 30, // Image radius
                                backgroundImage: CachedNetworkImageProvider( _proType.wishlist[index].image!,)
                            ),



                            const SizedBox(width: 10,),

                            FutureBuilder(future: _translationController.getTransaltion(_proType.wishlist[index].propertyType!), builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return      Text(snapshot.data!
                                  ,style: TextStyle(
                                    color: const Color(0xFF434343),
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              else
                              {
                                return  Text(_proType.wishlist[index].propertyType!
                                  ,style: TextStyle(
                                    color: const Color(0xFF434343),
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                            }),


                            const Spacer(),


                            Checkbox(value: values,
                              onChanged: (bool? value) {
                                setState(() {
                                  values = !values;
                                  print("bool object ===>>$values");

                                  if (value != null && value) {
                                    propertyController.toggleSelection(_proType.wishlist[index].propertyType!);
                                  } else {
                                    propertyController.toggleSelection(_proType.wishlist[index].propertyType!);
                                  }
                                });
                              },),


                            const SizedBox(width: 10,),
                          ],),
                        );



                      },)
                    ),


                  ],
                ),
              ),
            );
          }
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}