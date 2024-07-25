import 'package:flutter/material.dart';
import 'package:gasht/data_models/landlordDashboardModel.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/dashboard/bottomDashboard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:dio/dio.dart';
import '../../api/retrofit_interface.dart';
import '../../util/colors.dart';
import '../bookings/bookings.dart';
import '../moreOptions/profile.dart';
import '../prefManager.dart';
import 'addProperty.dart';
import 'myProperties.dart';

class LandDashboard extends StatefulWidget {
  const LandDashboard({Key? key}) : super(key: key);

  @override
  State<LandDashboard> createState() => _LandDashboardState();
}

class _LandDashboardState extends State<LandDashboard> {
  final List<Map> myProducts = List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();


  final TranslationController _translationController = Get.put(TranslationController());
  RetrofitInterface apiInterface = RetrofitInterface(Dio());

  List<QudsPopupMenuBase> getMenuItems(BuildContext context) {
    return [
      QudsPopupMenuItem(
          leading: const Icon(Icons.account_circle),
          title:                   FutureBuilder(future: _translationController.getTransaltion( "profile"),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return       Text(
                    snapshot.data!,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: const Color(0xFF323232),
                      fontSize: 14,
                      fontFamily: GoogleFonts.poppins.toString(),
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }
                else
                {
                  return
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF323232),
                        fontSize: 14,
                        fontFamily: GoogleFonts.poppins.toString(),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ;
                }
              }),

          onPressed: () {


            Navigator.push(context, MaterialPageRoute(builder: (context){
              return  Profile("Owner");
            }));


          }),
      QudsPopupMenuItem(
          leading: const Icon(Icons.logout),
          title:                  FutureBuilder(future: _translationController.getTransaltion( "logout"),
    builder: (context,snapshot){
    if(snapshot.hasData)
    {
    return       Text(
    snapshot.data!,
    textAlign: TextAlign.center,

    style: TextStyle(
    color: const Color(0xFF323232),
    fontSize: 14,
    fontFamily: GoogleFonts.poppins.toString(),
    fontWeight: FontWeight.w400,
    ),
    );
    }
    else
    {
    return
    Text(
    'Logout',
    textAlign: TextAlign.center,
    style: TextStyle(
    color: const Color(0xFF323232),
    fontSize: 14,
    fontFamily: GoogleFonts.poppins.toString(),
    fontWeight: FontWeight.w400,
    ),
    )
    ;
    }
    }),

          onPressed: () {
            PrefManager.clearPref();
            PrefManager.clearPref();
            PrefManager.clearPref();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const DashboardBottom();
            }));


          }),
    ];
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        automaticallyImplyLeading: false,
        title:                  FutureBuilder(future: _translationController.getTransaltion( "hello_Landlord"),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
              else
              {
                return
                  Text(
                    'Hello Landlord',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ;
              }
            }),

        actions: [
        Row(children: [
          IconButton(onPressed: (){




          }, icon: const Icon(Icons.notifications_none_rounded,color: Colors.white,)),




          QudsPopupButton(
            // backgroundColor: Colors.red,
              tooltip: 'T',
              items: getMenuItems(context),
              child:  ClipOval(
            child: Image.asset(
              'assets/images/profileImg.png', // Replace with your image URL
              width: 30, // Set your desired width
              height:30, // Set your desired height
              fit: BoxFit.cover, // Adjust the BoxFit property as needed
            ),
          ),
        ),
          const SizedBox(width: 10,)

        ],)

      ],),

      body:
      FutureBuilder(future: getDashboard(), builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Colors.green));
        }
        else if (snapshot.hasData){

          var model = snapshot.data!;

          return   Column(children: [

            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


            InkWell  (

              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return   const MyProperties();
                }));

              },
              child: Container(
                  width: 160,
                  height: 120,

                  margin:const EdgeInsets.only(left: 10,right: 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [

                      Image.asset("assets/icons/bunglw.png",height: 50,width: 50,),
                      const SizedBox(height: 5,),
                      FutureBuilder(future: _translationController.getTransaltion( "posted_Properties"),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: const Color(0xFF323232),
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                            else
                            {
                              return
                                Text(
                                  'Property Posted',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF323232),
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ;
                            }
                          }),

                      const SizedBox(height: 5,),
                       Text(model.propertyPosted.toString()),
                    ],

                  ),

                ),),



           InkWell(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>
                       Bookings("Owner"), //const PlayList( tag: 'Playlists',title:'Podcast'),
                 ),
               );
             },

             child: Container(
                    width: 160,
                    height: 120,

                    margin:const EdgeInsets.only(left: 10,right: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        Image.asset("assets/icons/booking.png",height: 50,width: 50,),
                        const SizedBox(height: 5,),
                        FutureBuilder(future: _translationController.getTransaltion( "total_bookings"),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: const Color(0xFF323232),
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                              else
                              {
                                return
                                  Text(
                                    'Total  Bookings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF323232),
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ;
                              }
                            }),

                        const SizedBox(height: 5,),
                        Text(model.totalBooking.toString()),
                      ],

                    ),

                  ),
           ),



              ],
            ),

            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                Container(
                  width: 160,
                  height: 120,

                  margin:const EdgeInsets.only(left: 10,right: 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [

                      Image.asset("assets/icons/pricePot.png",height: 50,width: 50,),
                      const SizedBox(height: 5,),
                      FutureBuilder(future: _translationController.getTransaltion( "total_earning"),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                            else
                            {
                              return
                                Text(
                                  'Total Earning',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ;
                            }
                          }),

                      const SizedBox(height: 5,),
                      Text(model.totalEarning.toString()),
                    ],

                  ),

                ),
                Container(
                  width: 160,
                  height: 120,
                  margin:const EdgeInsets.only(left: 10,right: 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [

                      Image.asset("assets/icons/customer_reviews.png",height: 50,width: 50,),
                      const SizedBox(height: 5,),
                      FutureBuilder(future: _translationController.getTransaltion( "average_rating"),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                            else
                            {
                              return
                                Text(
                                  'Average Rating',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ;
                            }
                          }),

                      const SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.avgRating.toString()),

                          Image.asset("assets/icons/start.png",height: 12,width: 10,),

                        ],)

                      //const Text("4.5*"),
                    ],

                  ),

                ),



              ],
            ),

/*

          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                      //  _showApparmentBottomSheet(context, index);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 170,
                        height: 160,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/cityimg.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    Text(
                      'Riyadh',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: GoogleFonts.poppins.toString(),
                        fontWeight: FontWeight.w500,
                        height: 1.67,
                      ),
                    )
                  ],
                );
              },
            ),
          ),



          Container(

            margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
            alignment: Alignment.centerLeft,
            child:   Text(
              'Turning Your Space into a WelcomingHaven',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF3C3C3C),
                fontSize: 15,
                fontFamily: GoogleFonts.montserrat.toString(),
                fontWeight: FontWeight.w600,
                height: 1.59,
                letterSpacing: 0.75,
              ),
            ),
          ),

          Container(

            margin: const EdgeInsets.only(left: 15,top: 5,right: 15),
            alignment: Alignment.centerLeft,
            child:  Text(
              'Wherever your destination is in Saudi, Your home is ready to host you',
              style: TextStyle(
                color: const Color(0xFF777777),
                fontSize: 13,
                fontFamily:GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w400,
                height: 1.83,
                letterSpacing: 0.39,
              ),
            ),
          ),

          SizedBox(
            height: 200,
            child:   ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: ()
                  {
                  //  _showCityBottomSheet(context, index);

                  },

                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        width:170,
                        height: 160,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/cityimg.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Text(
                        'Apartment & Rooms',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins.toString(),
                          fontWeight: FontWeight.w500,
                          height: 1.67,
                        ),
                      )

                    ],


                  ),
                );
              },
            ),

          ),

*/

            const Spacer(),

            Container(
              width: double.infinity,
              height: 173,
              decoration: ShapeDecoration(
                color: AppColors.appColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Column(
                children: [


                  Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 10),

                    child:
                    FutureBuilder(future: _translationController.getTransaltion( "begin_Your_Hosting_Journey"),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                          else
                          {
                            return
                              Text(
                                'Host with us',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 15,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ;
                          }
                        }),


                  ),

                  FutureBuilder(future: _translationController.
                  getTransaltion(  'Begin_Your_Hosting_Journey_Do',
                  ),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Apartment, chalet, villa, farm, caravan, yacht,\ncamp or room. You can host with us and earn\nadditional income',

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 12,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ;
                        }
                      }),




                  Container(

                    width: 180,height: 40,
                    margin: const EdgeInsets.only(top: 10),
                    child:    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.white,
                        elevation: 2.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>   const AddProperty()));  //const PlayList( tag: 'Playlists',title:'Podcast'),),);

                    }, child:


                    FutureBuilder(future: _translationController.getTransaltion(  "post_Property"  ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: AppColors.appColor,
                                fontSize: 14,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                          else
                          {
                            return
                              Text(
                                'Post Property',

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:AppColors.appColor,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ;
                          }
                        }),

                    ),
                  )



                ],

              ),


            )



          ],);

        }
        else {
          return const Text("No internet connection");
        }

      }),





    );
  }
  Future<ModelLandlordDashboard> getDashboard() async {
    try {
      String? token = await PrefManager.getString("token");
      return apiInterface.getLandlordDashboard(token!);

    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
  }

}
