import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/authentication/login.dart';
import 'package:gasht/ui/authentication/signup.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../data_models/propertyObject.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../authentication/forgotpassword.dart';
import '../prefManager.dart';
import 'package:dio/dio.dart';

import '../property/propertyDetails.dart';
import '../property/propertyList.dart';



  class WishList extends StatefulWidget{
    const WishList({super.key});

    @override
    State<WishList> createState() => _WishList ();

  }

  class _WishList extends State<WishList>  with TickerProviderStateMixin{
    final DateRangePickerController _controller = DateRangePickerController();

    late TabController _tabController;
    String startDate = '';
    String endDate = '';
    String _range = '';
    int propertyId = 0;
    int cityId = 0;
    final FocusNode _focusNodePassword = FocusNode();
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();
    bool _obscurePassword = true;
    bool isChecked = false;
    late String message;

    static String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    // static Pattern pattern ="^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regExp = RegExp(pattern.toString());


    String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";
    final TextEditingController _searchController = TextEditingController();
    //String imgUrl = "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";
    int current = 0;
    bool logged= false;
    final logger = Logger();

    List<String> items = [
      "All",
      "House",
      "Villa",
      "Apartment",
    /*  "Farm House",
      "Hotel",*/

    ];

    
    
    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _initializeScreen();

  }

    Future<void> _initializeScreen() async {
      String? token = await PrefManager.getString("token");

      setState(() {

      if(token!=null)
      {
        logged= true;
      }
      else
      {
        logged= false;
      }

      logger.d("============>>>>>>>>>>>>> token in wishlist ====>> $token");

      });


    }





    final TranslationController _translationController = Get.put(TranslationController());



    @override
    Widget build(BuildContext context) {
      // TODO: implement build

     if(logged) {
       return Scaffold(
         appBar: AppBar(
           backgroundColor: AppColors.appColor,
           iconTheme: const IconThemeData(color: Colors.white),
           title:
           FutureBuilder(future: _translationController.getTransaltion( "favourites"),
               builder: (context,snapshot){
                 if(snapshot.hasData)
                 {
                   return            Text(snapshot.data!,
                     style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,
                         fontSize: 18),);

                 }
                 else
                 {
                   return    Text("Favourites",
                     style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,
                         fontSize: 18),);



                 }
               }),
         ),


         body: Column(
           children: [
             const SizedBox(height: 10,),





             FutureBuilder<PropertyObjects>(future: getPropertyList(), builder:  (context,snapshot){
               if (snapshot.hasData) {

              var   propertyList = snapshot.data!.properties!;

              if(propertyList.isEmpty)
                {
                  return
                    FutureBuilder(future: _translationController.getTransaltion( "No property added to wishlist"),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return            Center(child: Text(snapshot.data!,
                              style: TextStyle(color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 18),),);

                          }
                          else
                          {
                            return

                              Center(child: Text("No property added to wishlist",style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18),),);

                          }
                        });




                }

              else {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                    ),
                    itemCount: propertyList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return IntrinsicHeight(
                        child: InkWell(
                          onTap: () {
                            /*Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const PropertyDetails();
                        }));*/
                            _showDateSheet(context, propertyList[index].id);

                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          propertyList[index].images![0]
                                              .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),


                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5),
                                  alignment: Alignment.centerLeft,
                                  child:

                                  FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].propertyName.toString()),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return            Text(
                                          snapshot.data!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: GoogleFonts
                                                  .inter()
                                                  .fontFamily,
                                              fontWeight: FontWeight.w500,
                                              height: 1.67,
                                            ),
                                          );

                                        }
                                        else
                                        {
                                          return
                                            Text(
                                              propertyList[index].propertyName.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );
                                        }
                                      }),



                                ),

                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    const Icon(Icons.bed),
                                    FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].bedroom.toString()),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return            Text(
                                              snapshot.data!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );

                                          }
                                          else
                                          {
                                            return
                                              Text(
                                                propertyList[index].bedroom.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts
                                                      .inter()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.67,
                                                ),
                                              );
                                          }
                                        }),

                                    const SizedBox(width: 1),
                                    const Icon(Icons.crop_square),
                                    FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].area.toString()),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return            Text(
                                              snapshot.data!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );

                                          }
                                          else
                                          {
                                            return
                                              Text(
                                                propertyList[index].area.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts
                                                      .inter()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.67,
                                                ),
                                              );
                                          }
                                        }),


                                  ],


                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'AED ${propertyList[index].price}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: GoogleFonts
                                          .inter()
                                          .fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                                // ... Other widgets ...
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
               }
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(
                     child: CircularProgressIndicator(color: AppColors.appColor));
               }
               else if (snapshot.hasError) {
                 return Center(
                     child: Text("Encountered an error: ${snapshot.error}"));
               }
               else {
                 return const Text("No internet connection");
               }




             })





           ],
         ),
       );
     }
     else
       {

       return const Login("Customer");


       }

    }

    void _showDateSheet(BuildContext context, int? id) {
      Get.bottomSheet(
        Container(



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
                            child: const Center(
                              child: Text(
                                "Daily",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),),
                          Tab(child: Container(
                            padding: EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                "Weekly",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),),
                          Tab(child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                "Monthly",
                                style: TextStyle(fontSize: 14),
                              ),
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
                                  selectionMode: DateRangePickerSelectionMode.range,
                                  onSelectionChanged: _onSelectionChanged,
                                  minDate: DateTime.now(),
                                  startRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                  endRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                  rangeSelectionColor: Colors.blue.withOpacity(0.2),
                                ),
                                ElevatedButton(
                                  onPressed: () async {


                                    if(startDate.isEmpty || endDate.isEmpty)
                                    {

                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the start date and end date "),backgroundColor: Colors.red));

                                    }
                                    if(startDate == endDate)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the end date "),backgroundColor: Colors.red));

                                    }

                                    else {
                                      buildLoading(context);

                                      RetrofitInterface apiInterface = RetrofitInterface(Dio());

                                      String ? token = await PrefManager.getString("token");

                                      var resposne = await apiInterface.getResortAvailablility(token??"",startDate,endDate,id.toString());

                                    /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (
                                              context) =>  PropertyList(startDate,endDate,cityId,propertyId), //const PlayList( tag: 'Playlists',title:'Podcast'),
                                        ),
                                      );*/
                                      
                                      
                                      if(resposne.status=="true")
                                        {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>    PropertyDetails(resposne.propertyDetail!,startDate,endDate),//const PlayList( tag: 'Playlists',title:'Podcast'),
                                            ),
                                          );
                                        }
                                      else
                                        {

                                          Navigator.pop(context);

                                          Get.snackbar(resposne.message!, "",colorText: Colors.white,backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);
                                          
                                        }
                                      
                                    /* */
                                    }


                                  },
                                  child:

                                  FutureBuilder(future: _translationController.getTransaltion('Submit'), builder: (context,snapshot){
                                    if(snapshot.hasData)
                                    {
                                      return   Text(snapshot.data!);
                                    }
                                    else
                                    {
                                      return const   Text('Submit');



                                    }
                                  }),



                                ),
                              ],),
                            )
                          ],
                        )
                    ),









                  ],
                ),
                )
            )
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }


    Future<void> loginValidator() async {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      // static Pattern pattern ="^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

      RegExp regExp = RegExp(pattern.toString());
      if(controllerEmail.text.trim().isEmpty){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email is required'),backgroundColor: Colors.red));

      }
      else if(!regExp.hasMatch(controllerEmail.text.trim()))
      {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valid email is required'),backgroundColor: Colors.red));

      }
      else
      if(controllerPassword.text.trim().isEmpty){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password is required'),backgroundColor: Colors.red,));

      }


      else {

        buildLoading(context);

        RetrofitInterface apiInterface = RetrofitInterface(Dio());



        loginUser(
            apiInterface,controllerEmail.text,
            controllerPassword.text).then((success) {
          if (success) {

            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login Successful'), backgroundColor: Colors.green,));



          }
          else {

            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
              backgroundColor: Colors.red,));
          }
        });


      }



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



    Future<bool> loginUser(RetrofitInterface apiService, String email, String password) async {
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {

        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


        String? deviceId = await _firebaseMessaging.getToken();
        Model_Login user = await apiService.getLogin(email, password,"Customer",deviceId!);
        if(user.status=="true"){
          uid  = user.user_id.toString();
          uName  = user.name.toString();

          PrefManager.saveString("token", user.token.toString());
          PrefManager.saveString("owner", "Customer");
          PrefManager.saveString("userId", user.user_id.toString());
          PrefManager.saveString("name", user.name.toString());


          setState(() {

            logged = true;
            PrefManager.saveString("token", user.token.toString());
            PrefManager.saveString("owner", "Customer");

          });

          final logger  = Logger();

          return true;
        }
        else{

          message = user.message!;
          debugPrint("error message in login == $message");

          return false;
        }



      } catch (e) {


        debugPrint(e.toString());
        message = e.toString();

        return false; // Return false indicating login failure
      }


    }


    Future<PropertyObjects> getPropertyList() async {
      RetrofitInterface apiInterface = RetrofitInterface(Dio());
      String ? token  = await PrefManager.getString("token");

      print("getPropertyList token ${token}");
      try {
        return apiInterface.geWishlist(token!);
      } catch (e) {
        rethrow; // Rethrow the exception to be handled by the FutureBuilder
      }
      // return apiInterface.getJobList("", "", "datePosted", "DESC");
    }



  }