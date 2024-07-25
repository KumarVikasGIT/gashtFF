import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../../util/colors.dart';
import 'package:dio/dio.dart';

import '../controllers/langaugeCotroller.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class Review extends StatefulWidget {
  final Property propertyList;

  const Review(this.propertyList, {Key? key}) : super(key: key);

  @override
  State<Review> createState() => _Review();
}

class _Review extends State<Review> {

  String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";

  TextEditingController controllerDishDes = TextEditingController();



  final TranslationController _translationController = Get.put(TranslationController());
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  late String message;

  double ratingId = 0;

  late bool enabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.propertyList.reviewed!)
      {
        enabled = false;
      }
    else
      {
        enabled = true;
      }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Theme(
  data: ThemeData(
    fontFamily: GoogleFonts.harmattan().fontFamily,
  ),
  child: Scaffold(
    body: SingleChildScrollView(child:
      Column(
        children: [

      /*  Row(children: [

          const    SizedBox(width: 10,),
          Text(
            '9.7 Cleanliness',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF262626),
              fontSize: 13,
              fontFamily: GoogleFonts.harmattan().fontFamily,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.60,
            ),
          ),

        ]),
          const    SizedBox(height: 10,),

          Row(children: [

            const    SizedBox(width: 10,),
            Text(
              '9.7 Refurbished',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 13,
                fontFamily: GoogleFonts.harmattan().fontFamily,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.60,
              ),
            ),

          ]),
          const    SizedBox(height: 10,),

          Row(children: [

            const    SizedBox(width: 10,),
            Text(
              '9.7 Services',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 13,
                fontFamily: GoogleFonts.harmattan().fontFamily,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.60,
              ),
            ),

          ]),
          const    SizedBox(height: 10,),

          Row(children: [

            const    SizedBox(width: 10,),
            Text(
              '8.6 Accuracy of the information declared by the host',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF262626),
                fontSize: 13,
                fontFamily: GoogleFonts.harmattan().fontFamily,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.60,
              ),
            ),

          ]),*/

          const    SizedBox(height: 15,),


          FutureBuilder(future: _translationController
              .getTransaltion('what_did_property_guests_say'),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return      Text(
                    snapshot.data!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.harmattan().fontFamily,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.11,
                    ),
                  );
                }
                else
                {
                  return
                    Text(
                      'What did property guest say??',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.11,
                      ),
                    );
                }
              }),






          const SizedBox(height: 10,),


          /* Container(
            margin: const EdgeInsets.only(left: 10,right: 10),
            height: 115,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.70, color: Color(0xFFE2E2E2)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Column(children: [

              const    SizedBox(height: 10,),


              //review name
              Row(children: [

                const    SizedBox(width: 8,),
                Text(
                  'Akash Rawat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 15,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.60,
                  ),
                ),

                const Spacer(),
                Text(
                  '9.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 15,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.60,
                  ),
                ),
                const    SizedBox(width: 8,),

              ]),
              const    SizedBox(height: 5,),

              Row(children: [

                const    SizedBox(width: 8,),
                Text(
                  '10 July 2023',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 13,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),

                const Spacer(),
                Text(
                  'Amazing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 13,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),
                const    SizedBox(width: 8,),

              ]),

              const    SizedBox(height: 15,),

              Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                child:   Text(
                  'The apartment is the best i have seen in my life and worth it',
                  textAlign: TextAlign.start,
                  style: TextStyle(

                    color:Colors.black,
                    fontSize: 13,
                    fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),
              )


            ],),
          ),*/



          SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: widget.propertyList.reviews!.length,
                itemBuilder: (BuildContext context, int index){

                  var name  =  widget.propertyList.reviews![index].userName;
                  var userRating  =  widget.propertyList.reviews![index].rating;
                  var comment  =  widget.propertyList.reviews![index].comment;


                  return  Container(
                    margin: const EdgeInsets.only(left: 10,right: 10,top: 10),

                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.70, color: Color(0xFFE2E2E2)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Column(children: [

                      const    SizedBox(height: 10,),


                      //review name
                      Row(children: [

                        const    SizedBox(width: 8,),
                        Text(
                          name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),

                        const Spacer(),
                        Text(
                          userRating!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),
                        const    SizedBox(width: 8,),

                      ]),
                      const    SizedBox(height: 5,),

                /*      Row(children: [

                        const    SizedBox(width: 8,),
                        Text(
                          '10 July 2023',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),

                        const Spacer(),
                        Text(
                          'Amazing',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                        const    SizedBox(width: 8,),

                      ]),*/



                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child:   Text(
                          comment!,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(

                            color:Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                      )


                    ],),
                  );


                }),
          ),




         /* Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imgUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Text(
                      'Text below Image $index',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),*/


          const SizedBox(height: 20,),


          Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child:

            FutureBuilder(future: _translationController
                .getTransaltion( 'write_Review'),
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return       Text(
                     snapshot.data!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 15,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    );
                  }
                  else
                  {
                    return
                      Text(
                        'Write Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.60,
                        ),
                      );
                  }
                }),



          ),
          const SizedBox(height: 15,),

      Container(
        margin: const EdgeInsets.only(left: 10,right: 10),

        alignment: Alignment.topLeft,
        child: RatingBar.builder(
          wrapAlignment: WrapAlignment.start,
          initialRating: ratingId,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingId = rating;

            print(rating);
          },
        ),
      ),


          const SizedBox(height: 10,),


          Container(
            margin: const EdgeInsets.only(left: 10,right: 10),
            height: 150,
            child: Center(child: TextField(
              maxLines: 6,
              enabled: enabled,
              controller: controllerDishDes,
              maxLength: 350,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText:tr("describe_Your_Experience"),
                hintStyle:TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.harmattan().fontFamily,

                  color: Colors.black,
                ) ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),),
          ),

          Container(

            alignment: Alignment.centerLeft,
            height: 40,
            margin: const EdgeInsets.only(top: 10,bottom: 20,right: 25+0,left: 20),
            child:    ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                elevation: 2.5,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), onPressed: () async {
              String? token = await PrefManager.getString("token");
              if (token != null) {
                _reviewSubmit();
              } else {


                showLogginScreen(context);


              }



            }, child:

            FutureBuilder(future: _translationController.getTransaltion( 'post'),
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return       Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 18,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  else
                  {
                    return
                      Text("Post",style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.harmattan().fontFamily,



                      )
                      );
                  }
                }),



            ),
          ),
          const SizedBox(height: 20,)

      ],)

      ,),
  ),
);
  }

  _reviewSubmit()
  async {
    if(controllerDishDes.text.isEmpty)
      {
        Get.snackbar(tr("describe_Your_Experience"),"",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
      }

    else if(ratingId==0)
      {
        Get.snackbar(tr("rate_this_Property"),"",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);

      }
    else
      {

        String ? token = await PrefManager.getString("token");

        if(token!=null) {
          RetrofitInterface retrofitInterface = RetrofitInterface(Dio());
          var model = await retrofitInterface.setReview(
              token, widget.propertyList.id.toString(), ratingId.toString(), controllerDishDes.text);


          if(model.status=="true")
            {

              setState(() {
                enabled = false;
              });
              controllerDishDes.clear();

              Get.snackbar("Review submitted successfully","",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.green,colorText: Colors.white);

            }
          else
            {
              enabled = true;
              Get.snackbar(tr(model.message.toString()),"",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);

            }

        }



      }

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
                        "Login for access",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontSize: 18),
                      ),
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
                          labelText: "Email",
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
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        }),

                    const SizedBox(height: 30),
                    // for password field
                    TextFormField(
                      controller: controllerPassword,
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                      child: Text("Log In",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.athiti().fontFamily)),
                    ),
                    const SizedBox(
                      height: 10,
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email is required'), backgroundColor: Colors.red));
    } else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Valid email is required'),
          backgroundColor: Colors.red));
    } else if (controllerPassword.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password is required'),
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

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Successful'),
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

