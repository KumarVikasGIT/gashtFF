import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/property/description.dart';
import 'package:gasht/ui/property/maps.dart';
import 'package:gasht/ui/property/precheckout.dart';
import 'package:gasht/ui/property/propertyImages.dart';
import 'package:gasht/ui/property/review.dart';
import 'package:gasht/ui/property/terms.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:mj_image_slider/mj_options.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../authentication/signup.dart';
import '../controllers/langaugeCotroller.dart';
import '../prefManager.dart';
import 'package:dio/dio.dart';



class PropertyDetails extends StatefulWidget {
  final Property propertyList;
  String startDate;
  String endDate;
   PropertyDetails( this.propertyList,  this.startDate, this.endDate, {Key? key}) : super(key: key);

  @override
  State<PropertyDetails> createState() => _PropertyDetails();
}

class _PropertyDetails extends State<PropertyDetails> {
  int current = 0;
  List<String> items = [
    tr( "description"),
    tr("new_reviews"),
    tr(  "map"),
    tr("property_terms"),

  ];
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  late String message;

   List<Widget> widgetOptions(Property propertyList) {
    return [
      Description(propertyList,widget.startDate,widget.endDate),
      Review(propertyList),
      MapsProperty(propertyList),
      Terms(propertyList),
    ];
  }

  final TranslationController _translationController = Get.put(TranslationController());



/*
  static List<Widget> widgetOptions(Property propertyList) = <Widget>[



    Description(propertyList),
    Review(propertyList),
    MapsProperty(propertyList),
    Terms(propertyList),
    //  Asana()


  ];
*/






  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        floatingActionButton:  Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(top: 10, left: 10),
          height: 40,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
      
                String? token = await PrefManager.getString("token");
                if (token != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreCheckout(widget
                          .propertyList,widget.startDate,widget.endDate), //const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );
                } else {
                  showLogginScreen(context);
      
                }
      
      
      
              },
              child:
      
              FutureBuilder(future: _translationController.getTransaltion("book_Now"),
                  builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return     Text(snapshot.data!,
                    style:  TextStyle(fontSize: 15.0,color: Colors.white,fontFamily: GoogleFonts.harmattan().fontFamily),
                  );
                }
                else
                {
                  return
                     Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily:GoogleFonts.harmattan().fontFamily),
                    );
                }
              }),
      
      ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body:Container(
          color: Colors.black,
          child: Column(
      
            children:[
      
      
              Stack(children: [
      
                Positioned(child:
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   PropertyImages(widget.propertyList.images!),//const PlayList( tag: 'Playlists',title:'Podcast'),
                      ),
                    );
                  },
                  child:
      
                 /* Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 250,
                    child:  MJImageSlider(
                      options: MjOptions(
                        width: double.infinity,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        autoPlayInterval: const Duration(hours: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 80000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      widgets: [...widget.propertyList.images!.map((e) => Image(image: NetworkImage(e),fit: BoxFit.fill,)).toList()],
                    ),
      
                  ),
      
                  */
      
                  ImageSlideshow(
      
                    /// Width of the [ImageSlideshow].
                    width: double.infinity,
      
                    /// Height of the [ImageSlideshow].
                    height: 400,
      
                    /// The page to show when first creating the [ImageSlideshow].
                    initialPage: 0,
      
                    /// The color to paint the indicator.
                    indicatorColor: Colors.blue,
      
                    /// The color to paint behind th indicator.
                    indicatorBackgroundColor: Colors.grey,
      
      
                    /// Called whenever the page in the center of the viewport changes.
                    onPageChanged: (value) {
                      print('Page changed: $value');
                    },
      
                    /// Auto scroll interval.
                    /// Do not auto scroll with null or 0.
                    autoPlayInterval: 300000,
      
                    /// Loops back to first slide.
                    isLoop: true,
      
                    /// The widgets to display in the [ImageSlideshow].
                    /// Add the sample image file into the images folder
                    children:  [...widget.propertyList.images!.map((e) => Image(image: NetworkImage(e),fit: BoxFit.fill,)).toList()],
                  ),
      
      
      
                ),
      
      
                ),
      
                Positioned(
      
                    top: 20,
                    left: 10,
                    child:
      
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                          ),
      
                          child: Image.asset("assets/images/arrowBack.png",)),
                    )
      
      
                ),
      
      
      
      
      
      
              ],
      
      
              ),
      
      
      
      
      
      
      
      
      
      
              Container(
                width: double.infinity,
      
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final itemWidth = MediaQuery.of(context).size.width / items.length;
      
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
      
                                });
                              },
                        child:
                       Container(
      
                        width: MediaQuery.of(context).size.width / items.length,
                        alignment: Alignment.center,
                        child:
                        Center(
                        child: DecoratedBox(
                        decoration: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: current == index ? AppColors.appColor : Colors.white),
                        //insets: EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        child:
      
                        FutureBuilder(future: _translationController.getTransaltion(items[index]), builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            log("==>> snapshot Data===${snapshot.data}");
      
                            return     Text(snapshot.data!,
                              style:  TextStyle(fontSize: 15.0,fontFamily:  GoogleFonts.harmattan().fontFamily),
                            );
                          }
                          else
                          {
                            return  Text(items[index],
                              style:  TextStyle(fontSize: 15.0,fontFamily: GoogleFonts.harmattan().fontFamily),
                            );
                          }
                        }),
      
      
      
      
                        ),
                        ),
      
                        ),
      
      
      
                        /*  Container(
                        width: MediaQuery.of(context).size.width / items.length,
                        alignment: Alignment.center,
                      //  margin:EdgeInserts.
                        child: Text(
                        items[index],
                        style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: current == index ? Colors.black : Colors.grey,
                          decoration: current == index ? TextDecoration.underline : TextDecoration.none,
                          decorationColor: current == index ? AppColors.appColor : null,
                          decorationThickness: current == index ? 2.0 : 0.0,
      
                        ),
                        ),
                        ),*/
      
      
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Expanded(
      
                child:  widgetOptions(widget.propertyList).elementAt(current),
      
      
              )
      
            ]
          ),
        )
      
      
      
      
      
      ),
    );
  }

  void showLogginScreen(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 750,
              //  color: Colors.white,
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Text(
                        "login_to_your_account",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 18),
                      ).tr(),
                    ),

                    const Divider(
                      thickness: 2,
                      color: AppColors.appColor,
                    ),

                    const SizedBox(height: 20),
                    //for email field

                    TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          labelText: tr("email"),
                          prefixIcon: const Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onEditingComplete: () =>
                            _focusNodePassword.requestFocus(),
                        validator: (value) {
                          if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        }
                        ),

                    const SizedBox(height: 30),
                    // for password field
                    TextFormField(
                      controller: controllerPassword,
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: tr("password"),
                        prefixIcon: const Icon(Icons.lock_person_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        return null;
                      },
                    ),

                    //terms and conditions check box
                    const SizedBox(
                      height: 40,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#07B464"),
                        elevation: 2.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        loginValidator();
                      },
                      child: Text("sign_in",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.athiti().fontFamily)).tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        FutureBuilder(future: _translationController
                            .getTransaltion("do_not_have_an_account?"),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return   Text(snapshot.data!,
                                    style: TextStyle(color: Colors.black,fontSize: 20,
                                        fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily));
                              }



                              else
                              {
                                return
                                  Text("Don't have an account?",
                                      style: TextStyle(color: Colors.black,fontSize: 15,
                                          fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily)); }
                            }),



                        TextButton(
                          onPressed: () {
                            //_formKey.currentState?.reset();

                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return  Signup("Customer");
                            },
                            ),
                            );
                          },
                          child:
                          FutureBuilder(future: _translationController.
                          getTransaltion("sign_up"),
                              builder: (context,snapshot){
                                if(snapshot.hasData)
                                {
                                  return   Text(snapshot.data!,
                                      style: TextStyle(color: Colors.blue,fontSize: 15,
                                          fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily));
                                }



                                else
                                {
                                  return
                                    Text("Signup",
                                        style: TextStyle(color: Colors.blue,fontSize: 15,
                                            fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily)); }
                              }),


                          //  const Text("Signup",style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),



                  ],
                ),
              ));
        });
  }

  Future<void> loginValidator() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    // static Pattern pattern ="^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regExp = RegExp(pattern.toString());
    if (controllerEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('emalid_email_is_required').tr(), backgroundColor: Colors.red));
    } else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('emalid_email_is_required').tr(),
          backgroundColor: Colors.red));
    } else if (controllerPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text('wrong_password(when_entering_wrong_password_errors)').tr(),
        backgroundColor: Colors.red,
      ));
    }

    /*else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const LandDashboard();
        }));

      };;*/

    else {
      buildLoading(context);

      RetrofitInterface apiInterface = RetrofitInterface(Dio());

      loginUser(apiInterface, controllerEmail.text, controllerPassword.text)
          .then((success) {
        if (success) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: const Text('login_Successful').tr(),
            backgroundColor: Colors.green,
          ));
        } else {
          Navigator.of(context).pop();


          Get.snackbar(message,"",colorText: Colors.white,backgroundColor: Colors.red,snackPosition: SnackPosition.BOTTOM);



          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }

  Future<bool> loginUser(
      RetrofitInterface apiService, String email, String password) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


      String? deviceId = await _firebaseMessaging.getToken();
      Model_Login user = await apiService.getLogin(email, password, "Customer",deviceId!);
      if (user.status == "true") {
        uid = user.user_id.toString();
        uName  = user.name.toString();

        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("owner", "Customer");
        PrefManager.saveString("userId", user.user_id.toString());
        PrefManager.saveString("name", user.name.toString());

        setState(() {
          //  logged = true;
          PrefManager.saveString("token", user.token.toString());
          PrefManager.saveString("owner", "Customer");
        });

        final logger = Logger();

        return true;
      } else {
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

}