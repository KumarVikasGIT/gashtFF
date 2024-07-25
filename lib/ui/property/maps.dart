import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../controllers/langaugeCotroller.dart';



class MapsProperty extends StatefulWidget {
  final Property propertyList;

  const MapsProperty( this.propertyList, {Key? key}) : super(key: key);

  @override
  State<MapsProperty> createState() => _MapsProperty();
}

class _MapsProperty extends State<MapsProperty> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  late  LatLng _center ;
  var customIcon;
  Future createMarker() async{
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/marker.png");
    setState(() {});
    marker =  Marker(
        markerId: MarkerId("Address"),
        icon: customIcon,
        position:_center);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  late Marker marker ;


  final TranslationController _translationController = Get.put(TranslationController());


      @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _center = LatLng(widget.propertyList.latitude!, widget.propertyList.longitude!);
    createMarker();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _markers["address"] = marker;

    return Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.harmattan().fontFamily,
      ),
      child: Scaffold(body:SingleChildScrollView(
       child: Column(children: [


         Row(children: [
           Container(
             margin: const EdgeInsets.only(left: 10,top: 20),
             width: 153,
             height: 42,
             child:  Stack(
               children: [
                 Positioned(
                   left: 0,
                   top: 24,
                   child:


                   FutureBuilder(future: _translationController.getTransaltion( widget.propertyList.city.toString()),
                       builder: (context,snapshot){
                         if(snapshot.hasData)
                         {
                           return         Text(
                            snapshot.data!,
                             textAlign: TextAlign.center,
                             style:  TextStyle(
                               color: Color(0xFF262626),
                               fontSize: 12,
                               fontFamily: GoogleFonts.harmattan().fontFamily,
                               fontWeight: FontWeight.w400,
                               letterSpacing: 0.60,
                             ),
                           );
                         }
                         else
                         {
                           return      Text(
                             widget.propertyList.city.toString(),
                             textAlign: TextAlign.center,
                             style:  TextStyle(
                               color: Color(0xFF262626),
                               fontSize: 12,
                               fontFamily: GoogleFonts.harmattan().fontFamily,
                               fontWeight: FontWeight.w400,
                               letterSpacing: 0.60,
                             ),
                           );
                         }
                       }),




                 ),
                  Positioned(
                   left: 0,
                   top: 0,
                   child:
                   FutureBuilder(future: _translationController
                       .getTransaltion( 'approximate_location'),
                       builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return        Text(
                         snapshot.data!,
                         style:  TextStyle(
                           color: Colors.black,
                           fontSize: 14,
                           fontFamily: GoogleFonts.harmattan().fontFamily,
                           fontWeight: FontWeight.w500,
                           height: 1.43,
                         ),
                       );
                     }
                     else
                     {
                       return       Text(
                         'Approximate location',
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 14,
                           fontFamily: GoogleFonts.harmattan().fontFamily,
                           fontWeight: FontWeight.w500,
                           height: 1.43,
                         ),
                       );
                     }
                   }),





                 ),
               ],
             ),
           ),
           const Spacer(),


           InkWell(
             onTap: (){
               MapsLauncher.launchCoordinates(_center.latitude,_center.longitude);
              /* Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>   const FullMapScreen(),//const PlayList( tag: 'Playlists',title:'Podcast'),
                 ),
               );*/

             },
             child:  Container(
               margin: const EdgeInsets.only(right: 10,top: 12,left: 10),
               width: 95,
               height: 29,
               decoration: ShapeDecoration(
                 color: Colors.white,
                 shape: RoundedRectangleBorder(
                   side: const BorderSide(width: 0.50, color: Color(0xFF8252AF)),
                   borderRadius: BorderRadius.circular(5),
                 ),
               ),
               child: Center(child:
               FutureBuilder(future: _translationController.getTransaltion( "view_on_map"),
                   builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return         Text(
                         snapshot.data!,
                         textAlign: TextAlign.center,
                         style:  TextStyle(
                           color: Color(0xFF8252AF),
                           fontSize: 12,
                           fontFamily: GoogleFonts.harmattan().fontFamily,
                           fontWeight: FontWeight.w400,
                         ),
                       );
                     }
                     else
                     {
                       return     Text(
                         'View on map',
                         style: TextStyle(
                           color: const Color(0xFF8252AF),
                           fontSize: 12,
                           fontFamily: GoogleFonts.harmattan().fontFamily,
                           fontWeight: FontWeight.w400,
                         ),
                       );
                     }
                   }),


                 ) ,
             ),
           ),






         ],),


        const SizedBox(

           height: 20,


        ),



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
         )
         ),
    );
  }
  
}