import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_dart.dart';
import 'package:gasht/loadingScreen.dart';
import 'package:gasht/ui/moreOptions/profile.dart';
import 'package:gasht/ui/property/propertyList.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dio/dio.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/dashboardModel.dart';
import '../../tranlations/locale_keys.g.dart';
import '../authentication/login.dart';
import '../controllers/langaugeCotroller.dart';
import '../moreOptions/notification.dart';
import '../prefManager.dart';
import '../tourist/tourist_screen.dart';
import 'allCitys.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin{

  late List<City>originalList = [];
  late List<City> model = [];

  String startDate = '';
  String endDate = '';
  String _range = '';
  int propertyId = 0;
  int cityId = 0;

  late TabController _tabController;

  List<Icon>iconList = [

    const Icon(Icons.border_all_outlined),
    const Icon(Icons.apartment),
    const Icon(Icons.landscape_outlined),
    const Icon(Icons.villa_outlined),
    const Icon(Icons.villa_outlined),


  ];



  final DateRangePickerController _controller = DateRangePickerController();


  RetrofitInterface apiInterface = RetrofitInterface(Dio());


  var logger  = Logger();

  late List<City> citiesMaster ;

  late List<PropertyType> propertyType ;
  late Future<String> fetchData;

  final TextEditingController _searchController = TextEditingController();
  final String _searchText = '';
  String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  late DateTime lastDialogTime;

  final TranslationController _translationController = Get.put(TranslationController());



  @override
  void initState() {
    super.initState();
   initPrefs();

    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> initPrefs() async {

    lastDialogTime = DateTime.fromMillisecondsSinceEpoch(await PrefManager.getInt('lastDialogTime') ?? 0);
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastDialogTime);

    if (difference.inHours >= 24) {
      // Enough time has passed, show the dialog
      fetchData = fetchDataFromApi();

      // Update lastDialogTime
      PrefManager.setInt('lastDialogTime', now.millisecondsSinceEpoch);
    }
  }
  Future<String> fetchDataFromApi() async {
    final response = await apiInterface.getDailyQuote();

    if (response.status == "true") {
      // Simulate parsing the response and extracting relevant data

      String apiData =     response.quote!;




      // Show a dialog after data is fetched
      showDialogOnDataFetched(apiData);

      return apiData;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar:AppBar(
        elevation: 0,
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        actions: [



          const SizedBox(width: 20),


          InkWell(
            onTap:()  async {
              print(LocaleKeys.property_name); //String

              //x context.setLocale(const Locale("ar"));

              String? token = await PrefManager.getString("token");

              if (token != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Profile("Customer"),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login("Customer"),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffe1dbf0)
                  ),
                  child: Image.asset(
                    'assets/images/profile-img.png', // Replace with your image URL
                    width: 30, // Set your desired width
                    height: 30, // Set your desired height
                    fit: BoxFit.cover, // Adjust the BoxFit property as needed
                  ),
                ),

              ],
            )
          ),

          Spacer(),

          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    print(LocaleKeys.property_name); //String
                    String? token = await PrefManager.getString("token");
                    if (token != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Notifications("Customer"),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login("Customer"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                ),
                const SizedBox(width: 10),


              ],
            ),
          ),

        ],
      ),


      body: SingleChildScrollView(
        child:
        Column(children: [
          Container(
            height: 65,
            decoration: const ShapeDecoration(
              color:AppColors.appColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),

            child:  Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child:
                   InkWell(
                       onTap: ()=> _showSearchCityBottomSheet(context),
                       child: Container(
                      alignment: Alignment.center,
                      margin:const EdgeInsets.only(left: 10,right: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.textBoxColor,
                        border: Border.all(color: AppColors.textBoxColor),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor.withOpacity(.05),
                            spreadRadius: .5,
                            blurRadius: .5,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        readOnly: true,
                        enabled: false,
                        controller: _searchController,
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          hintText: tr("search"),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ))
                ),

                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),


          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 10,top: 10,right: 10),
            child: Text(
              "experience_Kurdistans_charm_in_our_cozy_homes_!",
              style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                , color: const Color(0xFF3C3C3C),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                 )
              ,).tr(),


          ),

          Container(
            margin: const EdgeInsets.only(left: 10,top: 10,right: 10),
            child: Text(
              "filled_with_warm_hospitality_and_cultural_pride_Your_stay_promises_magic_and_true_beauty",
              style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                , color: const Color(0xFF3C3C3C),

                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.33,
                letterSpacing: 0.75,
              )
              ,).tr(),


          ),


          //////////////////// property type
          FutureBuilder(future: getDashboard(), builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Colors.green));
            }
            else if (snapshot.hasData){
              var cities = snapshot.data?.cities;
              originalList = cities!;
              citiesMaster = originalList;

              return  SizedBox(
                height: 185,
                child: ListView.builder(
                  itemCount: cities.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return
/*

                      FutureBuilder(future: _translationController.getTransaltion(cities[index].name!), builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return     Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  cityId = cities[index].id!;

                                  _showApparmentBottomSheet(context, index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 150,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                      image: CachedNetworkImageProvider(cities![index].image!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Text(
                               snapshot.data! ,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          );
                        }
                        else
                        {
                          return    Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  cityId = cities[index].id!;

                                  _showApparmentBottomSheet(context, index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 150,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                      image: CachedNetworkImageProvider(cities![index].image!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Text(
                                cities[index].name!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          );;
                        }
                      });
*/


                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cityId = cities[index].id!;

                            _showApparmentBottomSheet(context, index);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            width: 150,
                            height: 140,
                            decoration: BoxDecoration(
                              image:  DecorationImage(
                                image: CachedNetworkImageProvider(cities![index].image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        Text(
                          cities[index].name!.toLowerCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr()
                      ],
                    );
                  },
                ),
              );

            }
            else {
              return const Text("No internet connection");
            }

          }),





          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 10,top: 10,right: 10),
            child: Text('feel_at_home_in_any_place',
              style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                , color: const Color(0xFF3C3C3C),
                fontSize: 18,
                fontWeight: FontWeight.w600,

              )
              ,).tr(),


          ),


          //////


/*
          FutureBuilder(future: _translationController.getTransaltion('Wherever your destination is in Saudi, Your home\nis ready to host you'), builder: (context,snapshot){
            if(snapshot.hasData)
            {
              return   Container(
                alignment: Alignment.centerLeft,

                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text(snapshot.data!,

                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
            else
            {
              return   Container(
                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text('Your passport to unforgettable adventures and seamless travel experiences. Plan, explore, and make lasting memories with us.',
                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),

                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
          }),
*/

          Container(
            margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
            child: Text(
              "we_got_a_cozy_place_waiting_for_you_no_matter_where_your_adventures_take_you",
              style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                , color: const Color(0xFF3C3C3C),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.33,
                letterSpacing: 0.75,
              )
              ,).tr()
            ,


          ),




          FutureBuilder(future: getDashboard(), builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Colors.green));
            }
            else if (snapshot.hasData){
              var propertyTypes = snapshot.data?.propertyTypes;
              propertyType =  snapshot.data!.propertyTypes;
              return


                SizedBox(
                height: 185,
                child: ListView.builder(
                  itemCount: propertyTypes?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      FutureBuilder(future: _translationController.getTransaltion(propertyType[index].propertyType!), builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return      Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  propertyId = propertyType[index].id!;
                                  _showCityBottomSheet(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 150,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                      image: CachedNetworkImageProvider(propertyTypes![index].image!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Text(
                               snapshot.data!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          );
                        }
                        else
                        {
                          return      Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  propertyId = propertyType[index].id!;
                                  _showCityBottomSheet(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 150,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                      image: CachedNetworkImageProvider(propertyTypes![index].image!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Text(
                                propertyTypes[index].propertyType!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          );
                        }
                      });





                  },
                ),
              );

            }
            else {
              return const Text("No internet connection");
            }

          }),



          //resorts data
          InkWell(
            onTap: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => TouristScreen()));

              // buildLoading(context);
              //  getData().then((data) {
              //    Navigator.pop(context);
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AllCitys(data: data),
              //     ),
              //   );
              // });


            //  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllCitys()  ));

            },
            child:   Container(
              margin: const EdgeInsets.all(10),
             // padding:  const EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/resortImg.png"),
                  fit: BoxFit.fill,
                ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

              ),

              child:   Column(

                children: [

                  const Spacer(),
                  Container(
                    height: 49,
                    decoration:  ShapeDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                    ),
                    child:


                    Center(child:

                    FutureBuilder(future: _translationController.getTransaltion("tourist_Places"), builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return    Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w600,
                             ),
                        );
                      }
                      else
                      {
                        return    Text(
                          'Resort',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF262626),
                            fontSize: 12.60,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            height: 1.89,
                            letterSpacing: 0.38,
                          ),
                        );
                      }
                    }),






                    ),
                  )


                ],

              ),

            ),

          ),


          Container(
            margin: const EdgeInsets.only(top: 10,),
            width: double.infinity,
            height: 150,
            decoration: ShapeDecoration(
              color: AppColors.appColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.only(top: 10,),

                  child:

                  FutureBuilder(future: _translationController.getTransaltion("host_with_us"), builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return     Text(
                        snapshot.data!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 1.11,
                          letterSpacing: 0.90,
                        ),
                      );
                    }
                    else
                    {
                      return     Text(
                        'Host with us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 1.11,
                          letterSpacing: 0.90,
                        ),
                      );
                    }
                  }),





                ),


                FutureBuilder(future: _translationController.
                getTransaltion("Begin_Your_Hosting_Journey_Do"), builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return     Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 2.16,
                        letterSpacing: 0.33,
                      ),
                    );
                  }
                  else
                  {
                    return    Text(
                      'Apartment, chalet, villa, farm, caravan, yacht,\ncamp or room. You can host with us and earn\nadditional income',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 2.16,
                        letterSpacing: 0.33,
                      ),
                    );
                  }
                }),





                Container(width: 120,height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.white,
                      elevation: 2.5,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>    const Login("Owner"),//const PlayList( tag: 'Playlists',title:'Podcast'),
                      ),
                    );

                  }, child:

                  FutureBuilder(future: _translationController.getTransaltion("register"), builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return     Text(
                          snapshot.data!,
                          style: TextStyle(
                        fontSize: 15,
                        color: AppColors.appColor,


                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.harmattan().fontFamily,


                      )
                      );
                    }
                    else
                    {
                      return     Text("Register",style: TextStyle(
                        fontSize: 13,
                        color: AppColors.appColor,


                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        letterSpacing: 0.38,


                      )
                      );
                    }
                  }),




                  ),
                )



              ],

            ),


          )



        ],),),
    );
  }


  void _showCityBottomSheet(BuildContext context){

    Get.bottomSheet(
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(left: 10,right: 10),


          child: Column(

            children: [
              Row(
                children: [

                  Container(
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    alignment: Alignment.centerLeft,
                    child: IconButton(onPressed: (){

                      Navigator.pop(context);

                    }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),

                  ),
                  FutureBuilder(future: _translationController.getTransaltion( 'choose_a_property'), builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return   Text(snapshot.data!
                        ,style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.75,
                        ),
                      );



                    }
                    else
                    {
                      return  Text(" Choose Destination"
                        ,style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.75,
                        ),
                      );
                    }
                  }),

                ],

              ),
              /* Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 40,

              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Search ....",
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onEditingComplete: () => {},
                      validator: (String? value) {
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),*/




              Expanded(child:

              ListView.builder(



                itemCount: citiesMaster.length,

                itemBuilder: (BuildContext context, int index) {

                  return Container(
                      margin: const EdgeInsets.only(left: 20,top: 15,right: 20),
                      alignment: Alignment.centerLeft,

                      child:
                      InkWell(

                        onTap: (){
                          cityId = citiesMaster[index].id!;
                          _showDateSheet(context, index);

                        },
                        child:
                        Row(children: [

                          CircleAvatar(
                              radius: 30, // Image radius
                              backgroundImage: CachedNetworkImageProvider(citiesMaster[index].image!,)
                          ),


                          const SizedBox(width: 10,),

                          FutureBuilder(future: _translationController.getTransaltion(citiesMaster[index].name!), builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return      Text(snapshot.data!
                                ,style: TextStyle(
                                  color: const Color(0xFF434343),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            else
                            {
                              return      Text(citiesMaster[index].name!
                                ,style: TextStyle(
                                  color: const Color(0xFF434343),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }),


                          //


                        ],),)
                  );



                },)

              ),



            ],

          ),

        ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }


  void _showApparmentBottomSheet(BuildContext context, int index) {


    Get.bottomSheet(
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(left: 10,right: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15,right: 15),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  FutureBuilder(future:
                  _translationController.getTransaltion( 'choose_a_property'),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return      Text(snapshot.data!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.75,
                              )
                          );
                        }
                        else
                        {
                          return       Text(
                            'Choose Properties',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.75,
                            ),
                          );
                        }
                      }),


                ],
              ),


              Expanded(child:

              ListView.builder(

                itemCount: propertyType.length,

                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.only(left: 20,top: 15,right:20),
                      alignment: Alignment.centerLeft,

                      child: InkWell(
                        onTap: (){
                          propertyId = propertyType[index].id!;
                          _showDateSheet(context, index);
                        },
                        child:  Row(children: [


                          CircleAvatar(
                              radius: 30, // Image radius
                              backgroundImage: CachedNetworkImageProvider(propertyType[index].image!,)
                          ),






                          const SizedBox(width: 10,),

                          FutureBuilder(future: _translationController.getTransaltion(propertyType[index].propertyType!), builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return      Text(snapshot.data!
                                ,style: TextStyle(
                                  color: const Color(0xFF434343),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            else
                            {
                              return      Text(propertyType[index].propertyType!
                                ,style: TextStyle(
                                  color: const Color(0xFF434343),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }),


                        ],),
                      )
                  );



                },)

              ),

            ],
          ),
        ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );


  }

  void _showDateSheet(BuildContext context, int index) {
    Get.bottomSheet(
        Theme(
          data: ThemeData(
            fontFamily: GoogleFonts.harmattan().fontFamily,
          ),
          child: Container(


              margin: const EdgeInsets.only(left: 10,right: 10),


              color: Colors.white,

             // margin: EdgeInsets.only(left: 10,right: 10),
              child:

              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child:

                  Container(child:
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20,20, 20, 0),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                              color:AppColors.appColor,
                              borderRadius: BorderRadius.circular(25.0)
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs:  [

                            Tab(child: Container(
                              padding: const EdgeInsets.all(10),
                              child:  Center(
                                child:
                                FutureBuilder(future: _translationController.getTransaltion( "daily"), builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return   Text(snapshot.data!
                                      ,style: const TextStyle(

                                        fontSize: 14,

                                      ),
                                    );



                                  }
                                  else
                                  {
                                    return    const Text(
                                      "Daily",
                                      style: TextStyle(fontSize: 14),
                                    );
                                  }
                                }),



                              ),
                            ),),
                            Tab(child: Container(
                              padding: EdgeInsets.all(10),
                              child:  Center(
                                child:
                                FutureBuilder(future: _translationController.getTransaltion( "weekly"), builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return   Text(snapshot.data!
                                      ,style: const TextStyle(

                                        fontSize: 14,

                                      ),
                                    );



                                  }
                                  else
                                  {
                                    return    const Text(
                                      "Weekly",
                                      style: TextStyle(fontSize: 14),
                                    );
                                  }
                                }),

                              ),
                            ),),
                            Tab(child: Container(
                              padding: const EdgeInsets.all(10),
                              child:  Center(
                                child:
                                FutureBuilder(future: _translationController.getTransaltion( "monthly"), builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return   Text(snapshot.data!
                                      ,style: const TextStyle(

                                        fontSize: 14,

                                      ),
                                    );



                                  }
                                  else
                                  {
                                    return    const Text(
                                      "Monthly",
                                      style: TextStyle(fontSize: 14),
                                    );
                                  }
                                }),

                              ),
                            ),),

                          ],
                        ),
                      ),


                      Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children:  [
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                child: Column(children: [
                                  SfDateRangePicker(
                                    controller: _controller,
                                 //   locale: const Locale('ku'),
                                    selectionMode: DateRangePickerSelectionMode.range,
                                    onSelectionChanged: _onSelectionChanged,
                                    minDate: DateTime.now(),
                                    startRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                    endRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                    rangeSelectionColor: Colors.blue.withOpacity(0.2),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {


                                      if(startDate.isEmpty || endDate.isEmpty)
                                      {

                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the start date and end date "),backgroundColor: Colors.red));

                                      }



                                    /*  if(startDate == endDate)
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the end date "),backgroundColor: Colors.red));

                                      }*/

                                      else {



                                        print("---------------------");
                                        print("startDate ${startDate}");
                                        print("endDate ${endDate}");
                                        print("cityId ${cityId}");
                                        print("propertyId ${propertyId}");
                                        print("---------------------");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                                context) =>  PropertyList(startDate,endDate,cityId,propertyId), //const PlayList( tag: 'Playlists',title:'Podcast'),
                                          ),
                                        );
                                      }


                                    },
                                    child:

                                    FutureBuilder(future: _translationController.getTransaltion('search'), builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return   Text(snapshot.data!);
                                      }
                                      else
                                      {
                                        return const   Text('search');



                                      }
                                    }),



                                  ),
                                ],),
                              ),
                            ],
                          )
                      ),









                    ],
                  ),
                  )
              )
          ),
        ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }


  Future<ModelDashboard> getDashboard() async {
    try {
      String? token = await PrefManager.getString("token");
      return apiInterface.getDashboard(token??"");

    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
  }

 Future<ModelResort>  getData() async {
     String? token = await PrefManager.getString("token");

     return apiInterface.getResort(token??"");

   }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {


   // logger.d("Check-out Date:selection function $checkOutDate");
    setState(() {
      if (args.value is PickerDateRange) {

        startDate = DateFormat('dd-MM-yyyy').format(args.value.startDate);
        endDate = DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate);



        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';

        DateTime currentDate = DateFormat('dd-MM-yyyy').parse(startDate);
        DateTime selectedDate = DateFormat('dd-MM-yyyy').parse(endDate);


      /*  final DateTime currentDate = DateTime.now();
        final DateTime selectedDate = DateTime(2023, 1, 1); // Replace with your date
*/


        Duration difference = selectedDate.difference(currentDate);

        if (difference.inDays < 7) {
          _tabController.animateTo(0);
          logger.d("==>>>>>_tabcontroller ${_tabController}  0");
// Daily
        } else if (difference.inDays >= 7 && difference.inDays <= 29) {
          _tabController.animateTo(1); // Weekly
        } else {
          logger.d("==>>>>>_tabcontroller ${_tabController} 2 ");

          _tabController.animateTo(2); // Monthly
          logger.d("==>>>>>_tabcontroller ${_tabController} 3");

        }
        logger.d("==>>>>>_tabcontroller ${difference.inDays}");

      }
    });

    logger.d("Check-in Date: _range $_range,   startDate  $startDate , endDate $endDate ");

  }




  _showSearchCityBottomSheet (BuildContext context){

   Get.bottomSheet(

     Container(
     color: Colors.white,
       margin: const EdgeInsets.only(left: 10,right: 10),


     child: Column(

       children: [
         Row(
           children: [

             Container(
               margin: const EdgeInsets.only(left: 15),
               alignment: Alignment.centerLeft,
               child: IconButton(onPressed: (){

                 Navigator.pop(context);

               }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),

             ),
             FutureBuilder(future: _translationController.getTransaltion( 'your_destination?'), builder: (context,snapshot){
               if(snapshot.hasData)
               {
                 return   Text(snapshot.data!
                   ,style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                     fontFamily: GoogleFonts.harmattan().fontFamily,
                     fontWeight: FontWeight.w500,
                     letterSpacing: 0.75,
                   ),
                 );



               }
               else
               {
                 return  Text(" Choose Destination"
                   ,style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,
                     fontFamily: GoogleFonts.harmattan().fontFamily,
                     fontWeight: FontWeight.w500,
                     letterSpacing: 0.75,
                   ),
                 );
               }
             }),




           ],

         ),
         /* Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.only(top: 1,left: 10,right: 10),
              decoration: BoxDecoration(
                color: AppColors.textBoxColor,
                border: Border.all(color: AppColors.textBoxColor),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x21000000),
                    blurRadius: 5.73,
                    offset: Offset(0, 0.97),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                readOnly: false,
                controller: _searchController,
                onChanged: filterList,                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  hintText: "Search by Cities",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),*/




         Expanded(child:

         ListView.builder(

           itemCount: citiesMaster.length,

           itemBuilder: (BuildContext context, int index) {

             return Container(
                 margin: const EdgeInsets.only(left: 20,top: 15,right: 20),
                 alignment: Alignment.centerLeft,

                 child:
                 InkWell(

                   onTap: (){
                     cityId = citiesMaster[index].id!;
                   //  _showDateSheet(context, index);

                     _showApparmentBottomSheet(context, index);

                   },
                   child:
                   Row(children: [

                     CircleAvatar(
                         radius: 30, // Image radius
                         backgroundImage: CachedNetworkImageProvider(citiesMaster[index].image!,)
                     ),


                     const SizedBox(width: 10,),


                     FutureBuilder(future: _translationController.getTransaltion(citiesMaster[index].name!), builder: (context,snapshot){
                       if(snapshot.hasData)
                       {
                         return   Text(snapshot.data!
                           ,style: TextStyle(
                             color: const Color(0xFF434343),
                             fontSize: 15,
                             fontFamily: GoogleFonts.harmattan().fontFamily,
                             fontWeight: FontWeight.w500,
                             height: 1.67,
                           ),
                         );



                       }
                       else
                       {
                         return  Text(citiesMaster[index].name!
                           ,style: TextStyle(
                             color: const Color(0xFF434343),
                             fontSize: 15,
                             fontFamily: GoogleFonts.harmattan().fontFamily,
                             fontWeight: FontWeight.w500,
                             height: 1.67,
                           ),
                         );
                       }
                     }),



                   ],),)
             );



           },)

         ),



       ],

     ),

   ),
     backgroundColor: Colors.white,
     elevation: 0,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),
     ),












   );
  }



  Future<void> showDialogOnDataFetched(String quote) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:           FutureBuilder(future: _translationController
              .getTransaltion("daily_quote"), builder: (context,snapshot){
            if(snapshot.hasData)
            {
              return   Container(
                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text(snapshot.data!,
                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
            else
            {
              return   Container(
                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text("Daily quote",
                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
          }),

          content:
          FutureBuilder(future: _translationController.getTransaltion(quote), builder: (context,snapshot){
            if(snapshot.hasData)
            {
              return   Container(
                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text(snapshot.data!,
                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
            else
            {
              return   Container(
                margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                child: Text(quote,
                  style: TextStyle(fontFamily: GoogleFonts.harmattan().fontFamily
                    , color: const Color(0xFF3C3C3C),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    letterSpacing: 0.75,
                  )
                  ,),


              );
            }
          }),



          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void filterList(String query) {
    setState(() {
      citiesMaster = originalList.where((item) =>
          item.name.toString().toLowerCase().contains(query.toLowerCase())


      ).toList();
    });
  }

}


