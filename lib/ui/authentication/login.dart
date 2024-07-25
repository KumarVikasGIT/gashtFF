import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_login.dart';
import 'package:gasht/ui/authentication/forgotpassword.dart';
import 'package:gasht/ui/authentication/signup.dart';
import 'package:gasht/ui/dashboard/bottomDashboard.dart';
import 'package:gasht/ui/landlord/landDashboard.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:gasht/main.dart';
import '../../api/retrofit_interface.dart';
import '../../loadingScreen.dart';
import 'package:dio/dio.dart';

import '../controllers/langaugeCotroller.dart';
import '../dashboard/moreOptions.dart';
import '../landlord/bottomLandlord.dart';
import '../prefManager.dart';


class Login extends StatefulWidget {
  final String userType;
  const Login(this.userType,{super.key});


  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  // final GlobalKey<FormState> _formKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TranslationController _translationController = Get.put(TranslationController());

  bool _obscurePassword = true;
  bool isChecked = false;
  late String message;

  static String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

 // static Pattern pattern ="^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  RegExp regExp = RegExp(pattern.toString());


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
                    margin:  const EdgeInsets.fromLTRB(30,50,30,0),
                    child:  Image.asset("assets/images/login_signup.png"),


                  ),

                  Container( //apply margin and padding using Container Widget.
                    margin:  const EdgeInsets.fromLTRB(0,50,0,0),
                    child:

                    FutureBuilder(future: _translationController.getTransaltion("login_to_your_account"),
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
                              Text("Login to Your Account",style:
                              TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.harmattan().fontFamily));
                          }
                        }),


                  ),

                  SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20,10,20,0),
                      child: Column(
                          children: [
                            const SizedBox(height: 20),
                            //for email field
                            TextFormField(
                                controller: controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (value) {},
                                decoration: InputDecoration(
                                  labelText: tr('email'),
                                  prefixIcon: const Icon(Icons.mail_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onEditingComplete: () => _focusNodePassword.requestFocus(),
                                validator: (value) {
                                  if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                    return 'Enter a valid email!';
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
                              height: 10,
                            ),




                            InkWell(
                              onTap: (){

                                if(controllerEmail.text.trim().isEmpty){

                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text('email_is_required').tr(),backgroundColor: Colors.red));

                                }
                                else if(!regExp.hasMatch(controllerEmail.text.trim()))
                                {

                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valid email is required'),backgroundColor: Colors.red));

                                }
                                else {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ForgotPassword(controllerEmail.text,widget.userType);
                                    },),);
                                }
                              },
                              child:

                              FutureBuilder(future: _translationController.
                              getTransaltion('forget_your_password?',),
                                  builder: (context,snapshot){
                                    if(snapshot.hasData)
                                    {
                                      return       Text(
                                          snapshot.data!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF2080D8),
                                          fontSize: 16,
                                          fontFamily: GoogleFonts.harmattan().fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );    }
                                    else
                                    {
                                      return
                                        Text(
                                          'Forgot your password?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF2080D8),
                                            fontSize: 16,
                                            fontFamily: GoogleFonts.harmattan().fontFamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ); }
                                  }),



                            ),





                            //login btn
                            const SizedBox(height: 15),
                            Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("#07B464"),
                                      elevation: 2.5,
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ), onPressed: () {

                                    loginValidator();
                                   /* Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const BottomLandlord()),
                                    );*/

                                  }, child:

                                  FutureBuilder(future: _translationController.getTransaltion("sign_in"),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return   Text(snapshot.data!,
                                          style: TextStyle(color: Colors.white,fontSize: 20,
                                        fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily));
                                        }



                                        else
                                        {
                                          return
                                            Text("Log In",
                                                style: TextStyle(color: Colors.white,fontSize: 20,
                                                    fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)); }
                                      }),


                                  )

                                ]
                            ),



                            // sign with google btn

                            const SizedBox(
                              height: 10,
                            ),


                            // dont have an account

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                FutureBuilder(future: _translationController.
                                getTransaltion("do_not_have_an_account?"),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return   Text(snapshot.data!,
                                            style: TextStyle(color: Colors.black,fontSize: 15,
                                                fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily));
                                      }



                                      else
                                      {
                                        return
                                          Text("Don't have an account?",
                                              style: TextStyle(color: Colors.black,fontSize: 15,
                                                  fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)); }
                                    }),



                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return  Signup(widget.userType);
                                    },
                                    ),
                                    );
                                  },
                                  child:
                                  FutureBuilder(future: _translationController.getTransaltion("sign_up"),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return   Text(snapshot.data!,
                                              style: TextStyle(color: Colors.blue,fontSize: 15,
                                                  fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily));
                                        }



                                        else
                                        {
                                          return
                                            Text("Signup",
                                                style: TextStyle(color: Colors.blue,fontSize: 15,
                                                    fontWeight: FontWeight.bold,fontFamily: GoogleFonts.harmattan().fontFamily)); }
                                      }),


                                //  const Text("Signup",style: TextStyle(color: Colors.blue),),
                                ),
                              ],
                            ),


                          ]



                      )




                  ),







                ],


              ) ,


            )





        ),


      ),
    );
  }




  Future<void> loginValidator() async {
    if(controllerEmail.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("email_is_required_(when_entering_wrong_email_errors)").tr(),backgroundColor: Colors.red));

    }
    else if(!regExp.hasMatch(controllerEmail.text.trim()))
    {

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("email_is_required_(when_entering_wrong_email_errors)").tr(),backgroundColor: Colors.red));

    }
    else
    if(controllerPassword.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("wrong_password(when_entering_wrong_password_errors)").tr(),backgroundColor: Colors.red,));

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

      loginUser(
          apiInterface,controllerEmail.text,
          controllerPassword.text).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: const Text('login_Successful').tr(),
            backgroundColor: Colors.green,));


          if (widget.userType == "Customer") {

            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardBottom()),
            );

          }
          else {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomLandlord()),
            );
          }
        }
        else {

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
            backgroundColor: Colors.red,));
        }
      });


    }



  }


  Future<bool> loginUser(RetrofitInterface apiService, String email, String password) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {

      String? token = await FirebaseMessaging.instance.getToken();
      print("token");

      Model_Login user = await apiService.getLogin(email, password,widget.userType,token!);
      if(user.status=="true"){



        uid = user.user_id.toString();
        uName  = user.name.toString();

        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("userId", user.user_id.toString());
        PrefManager.saveString("owner", widget.userType);
        PrefManager.saveString("name", user.name.toString());


       final logger  = Logger();
        logger.d("owner dashboard  ${widget.userType}");

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

  Future<void>  forgotPassword() async {
    if(controllerEmail.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("email_is_required_(when_entering_wrong_email_errors)").tr(),backgroundColor: Colors.red));

    }
    else if(!regExp.hasMatch(controllerEmail.text.trim()))
    {

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text("email_is_required_(when_entering_wrong_email_errors)").tr(),backgroundColor: Colors.red));

    }
    else
    {
      buildLoading(context);
      RetrofitInterface apiInterface = RetrofitInterface(Dio());

      apiPassword(
          apiInterface,controllerEmail.text).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(message),backgroundColor: Colors.green,));

          Navigator.of(context).pop();
        }
        else {

          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(message),backgroundColor: Colors.red,));
          Navigator.of(context).pop();

        }
      });


    }

  }



  Future<bool> apiPassword(RetrofitInterface apiService,String email)async {
    try {
      Model_Login user = await apiService.getForgotPassword(email,"old",widget.userType);
      if(user.status=="true"){

        message = user.message!;

        return true;
      }
      else{

        message = user.message!;
        debugPrint("error message in login == $message");

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