import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_login.dart';
import 'package:gasht/ui/authentication/otp.dart';
import 'package:gasht/ui/authentication/signupgettersetter.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


import '../../api/retrofit_interface.dart';
import '../../loadingScreen.dart';
import '../controllers/langaugeCotroller.dart';
import '../moreOptions/termsofuse.dart';
import '../prefManager.dart';
import 'login.dart';
class Signup extends StatefulWidget {

 final String userType;
  const Signup(this.userType,{super.key});



  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {



  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;
  static Pattern pattern = "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
  RegExp regExp = RegExp(pattern.toString());
  //late LoginState _loginState;
  late String message;
  RetrofitInterface apiInterface = RetrofitInterface(Dio());
  final TranslationController _translationController = Get.put(TranslationController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: GoogleFonts.harmattan().fontFamily,
      ),
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),

            child:
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(30,45, 30, 0),
                    child: Image.asset("assets/images/login_signup.png"),


                  ),

                  Container( //apply margin and padding using Container Widget.
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child:
                    FutureBuilder(future: _translationController.getTransaltion("create_new_account"),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                                snapshot.data!,
                                style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.harmattan().fontFamily));
                          }
                          else
                          {
                            return
                              Text("Create new account",style:
                              TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.harmattan().fontFamily));
                          }
                        }),

                  ),

                  SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                          children: [
                            const SizedBox(height: 20),
                            //for name field
                            TextFormField(
                                controller: controllerUsername,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: tr("full_Name"),
                                  prefixIcon: const Icon(
                                      Icons.account_circle_rounded),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors
                                        .grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onEditingComplete: () =>
                                    _focusNodePassword.requestFocus(),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter email.";
                                  }
                                  return null;
                                }
                            ),

                            const SizedBox(height: 20),
                            //for email field
                            TextFormField(
                                controller: controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: tr("email"),
                                  prefixIcon: const Icon(Icons.alternate_email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors
                                        .grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onEditingComplete: () =>
                                    _focusNodePassword.requestFocus(),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter email.";
                                  }
                                  return null;
                                }
                            ),
                            const SizedBox(height: 20),
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
                                        : const Icon(
                                        Icons.visibility_off_outlined)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors
                                      .grey),

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors
                                      .grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password.";
                                }

                                return null;
                              },
                            ),

                            //terms and conditions check box
                            const SizedBox(
                              height: 1,
                            ),


                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,


                                  onChanged: (value) {
                                    isChecked = !isChecked;
                                    setState(() {});
                                  },
                                ),
                              /*  FutureBuilder(future: _translationController.getTransaltion( "i_agree_with_terms_and_privacy"),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                         snapshot.data!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily),
                                        );
                                      }
                                      else
                                      {
                                        return Text(
                                            "I agree with ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontFamily: GoogleFonts
                                                    .harmattan()
                                                    .fontFamily),
                                          );
                                      }
                                    }),*/

                            InkWell(

                              onTap: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsAndPolicy(
                                        stringValue:
                                        "Terms of Use"),
                                  ),
                                );

                              },

                             child:   FutureBuilder(future: _translationController.getTransaltion( "i_agree_with_terms_and_privacy"),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue,
                                              fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily),
                                        );
                                      }
                                      else
                                      {
                                        return Text(
                                          "Terms and Privacy",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue,
                                              fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily),
                                        );
                                      }
                                    }),),

                              ],
                            ),

                            //login btn
                            const SizedBox(height: 15),
                            Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.appColor,
                                      elevation: 2.5,
                                      minimumSize: const Size.fromHeight(42),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ), onPressed: () {
                                    loginValidator();
                                  }, child:
                                  FutureBuilder(future: _translationController.getTransaltion( "sign_up"),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return       Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: GoogleFonts
                                                    .harmattan()
                                                    .fontFamily),
                                          );
                                        }
                                        else
                                        {
                                          return
                                            Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontFamily: GoogleFonts
                                                      .harmattan()
                                                      .fontFamily),
                                            );
                                        }
                                      }),


                                  )

                                ]
                            ),


                            // sign with google btn

                            const SizedBox(
                              height: 20,
                            ),



                       /*     SizedBox(
                              width: double.infinity,
                              child: Image.asset("assets/images/dash.png"),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            //google and facebook icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [


                              Container(
                                width: 100,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 0.70, color: Color(0xFFC4C4C4)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                child: Image.asset("assets/images/facebook.png",),

                              ),

                              Container(
                                width: 100,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 0.70, color: Color(0xFFC4C4C4)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                child: Image.asset("assets/images/google.png",)

                              ),
                            ],),
      */


                            // dont have an account

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                FutureBuilder(future: _translationController.
                                getTransaltion( "already_have_an_account"),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: GoogleFonts
                                                  .harmattan()
                                                  .fontFamily),
                                        );
                                      }
                                      else
                                      {
                                        return
                                          Text(
                                              "Already have a account?",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontFamily: GoogleFonts
                                                    .harmattan()
                                                    .fontFamily),
                                          );
                                      }
                                    }),



                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();

                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return  Login(widget.userType);
                                      },
                                      ),
                                    );
                                  },
                                  child:
                                  FutureBuilder(future: _translationController.
                                  getTransaltion( "sign_in"),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return       Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                fontFamily: GoogleFonts
                                                    .harmattan()
                                                    .fontFamily),
                                          );
                                        }
                                        else
                                        {
                                          return
                                            Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                  fontFamily: GoogleFonts
                                                      .harmattan()
                                                      .fontFamily),
                                            );
                                        }
                                      }),

                                ),
                              ],
                            ),


                          ]


                      )


                  ),




                ],


              ),


            )


        ),


      ),
    );
  }


  Future<void> loginValidator() async {
    print("here calling loginValidator...");
    if (controllerUsername.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content:const Text("full_name_is_required").tr(), backgroundColor: Colors.red));
    }

    else if (controllerEmail.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: const Text('email_is_required').tr(), backgroundColor: Colors.red));
    }
    else if (!regExp.hasMatch(controllerEmail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: const Text("email_is_required").tr(),
        backgroundColor: Colors.red,));
    }
    else if (controllerPassword.text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:const Text('password_is_required').tr(), backgroundColor: Colors.red,));
    }
    else if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:const Text("please_accept_the_terms_and_conditions").tr(),
        backgroundColor: Colors.red,));
    }

 /*   else
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const Otp();
      }));

    }*/
    else {

      buildLoading(context);

      print("here calling...");

      sendOtp(
          apiInterface, controllerEmail.text).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP send Successful'),backgroundColor: Colors.green,));

          var user = User(controllerUsername.text,controllerEmail.text,controllerPassword.text,widget.userType);

          user.setName( controllerUsername.text);
          user.setEmail(controllerEmail.text);
          user.setPassword(controllerPassword.text);
          user.setUserType(widget.userType);


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  Otp(controllerEmail.text,"new",user,widget.userType)),
          );
        }
        else {

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
            backgroundColor: Colors.red,));
        }
      });




    }




  }



  Future<bool>sendOtp(RetrofitInterface apiInterface, String text) async {
    print("here calling sendOtp...");
    try {
      Model_Login user = await apiInterface.getForgotPassword(text,"new",widget.userType);

      print("here calling response...${user}");
      if(user.status.toString()=="true")
        {
          return true;

        }
      else{

        message = user.message!;

        return false;
      }

    }
    catch (e) {


      debugPrint(e.toString());
      message = e.toString();

      return false; // Return false indicating login failure
    }


  }

}

/*
  Future<bool> signupUser(RetrofitInterface apiService,String name, String email, String password) async {

    try {
      Model_Login user = await apiService.getRegister(name,email,"","", password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if(user.status=="true"){


        prefs.setString("token", user.token.toString());
        PrefManager.saveString("token", user.token.toString());

        return true;
      }
      else{

        message = user.message!;

        return false;
      }

      //  LoginSignupModel model = user; // Store the UserModel for later use
      // Return true indicating successful login
    } catch (e) {


      debugPrint(e.toString());
      message = e.toString();

      return false; // Return false indicating login failure
    }


  }
*/
