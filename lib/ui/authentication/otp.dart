import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/authentication/signupgettersetter.dart';
import 'package:gasht/ui/dashboard/bottomDashboard.dart';
import 'package:gasht/ui/landlord/bottomLandlord.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:dio/dio.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import '../../main.dart';
import '../landlord/landDashboard.dart';
import '../prefManager.dart';
import 'createpassword.dart';

class Otp extends StatefulWidget {

 final String email;
 final String type;
 final User user;
 final String userType;
   const Otp( this.email, this.type,  this.user,this.userType,{Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _Otp();
}

class _Otp extends State<Otp> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final logger = Logger();
  late String message;
  RetrofitInterface apiInterface = RetrofitInterface(Dio());
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
 // StreamController<ErrorAnimationType>? errorController;
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final logger = Logger();

   /* final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );*/

    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      appBar: AppBar(title: const Text("oTP_verification").tr(),),
      body: SingleChildScrollView(
        child: Column(children: [


          const SizedBox(height: 200,),

          Container(
            margin: const EdgeInsets.only(left: 10,right: 10),
            child: Text(
              "${tr("code_has_been_sent_to:")} ${widget.email}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily:GoogleFonts.harmattan().fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 50,),



        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 4,

            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 3) {
                return "Enter proper OTP";
              } else {
               // otpVerify(v);
                return null;
              }
            },

            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) {
              otpVerify( int.parse(v));

              debugPrint("Completed");
            },
            // onTap: () {
            //   print("Pressed");
            // },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
               // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
        ),


        /*  DPin(
            buttonColor: AppColors.appColor,
            buttonText:tr( "verify"),
            number: 4,
            underline: false,
            fieldBorderColor: AppColors.appColor,
            withButton: true,
            onValueChanged: (v) {
              setState(() {
                var value = v;
                debugPrint('Dpin: $v');




                otpVerify(value);


              *//*  Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const CreatePassword();

                }));*//*

              });
            },
          ),
          */

          const SizedBox(height: 20,),


          InkWell(
              onTap:(){ sendOtp();},
              child: Text("resend",style: TextStyle(color:Colors.blue,fontSize: 20,
                  fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily))
          .tr()
          ),

        ],),
      )
      ,);
  }



  Future<void>sendOtp() async {

    String old ='';
    if(widget.type == "new")
      {
        old  = "new";
      }
    else
      {
        old = "old";
      }


    try {
      Model_Login user = await apiInterface.getForgotPassword(widget.email,old,widget.userType);

      if(user.status.toString()=="true")
      {

        Get.snackbar(tr("oTP_sent_successfully"),"",colorText: Colors.white,backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

      }
      else{

        message = user.message!;
        Get.snackbar(message,"",colorText: Colors.white,backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

      }

    }
    catch (e) {


      debugPrint(e.toString());
      message = e.toString();




     // Return false indicating login failure
    }


  }



  void otpVerify(int value) {



    String firstFourDigits =value.toString();// Extract the first 4 digits

    String otp = firstFourDigits.substring(0, 4);




    logger.d("dpin otp value user input ===>>> $value");
    logger.d("otp value user input ===>>> $otp");


    if(otp.length<4)
       {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('4 digit OTP is required'),backgroundColor: Colors.red,));


      }
    else {
      buildLoading(context);

      if (widget.type == "new") {


        apiOtpVerify(apiInterface,widget.email,otp).then((success){
          if(success){
            signupUser(apiInterface).then((success) {
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup Successful'),backgroundColor: Colors.green,));

                if (widget.userType == "Customer") {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardBottom()),
                  );
                }
                else {

                  PrefManager.saveString("owner", widget.userType);
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
          else
            {

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
                backgroundColor: Colors.red,));
            }
        });






      }
      else {
        apiOtpVerify(apiInterface,widget.email,otp).then((success) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('otp_verified').tr(),backgroundColor: Colors.green,));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  CreatePassword(widget.email,widget.userType)),
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

  }
  Future<bool> signupUser(RetrofitInterface apiService) async {
  //  var value  = SingupDataGetterSetter();
    var value = widget.user;
  //  logger.d("otp getter setter data ====${value.name},${value.password}, ${value.email}, ${value.user_type}, ");

    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FirebaseMessaging ${token}");
      Model_Login user = await apiService.getRegister(value.getName(),value.getEmail(),"1234567890",value.getUserType(), value.getPassword(),token!);

      if(user.status=="true"){

        uid = user.user_id.toString();
        uName  = user.name.toString();

        PrefManager.saveString("token", user.token.toString());
        PrefManager.saveString("userId", user.user_id.toString());
        PrefManager.saveString("owner", widget.userType);
        PrefManager.saveString("name", user.name.toString());

        if(value.user_type=="Owner") {
          PrefManager.saveString("owner", "owner");

          //  PrefManager.saveString("token", user.token.toString());
        }
        else
          {
            PrefManager.saveString("owner", "customer");

          }
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

  Future<bool>   apiOtpVerify(RetrofitInterface apiInterface, String email, String otp) async {



    Model_Login user = await apiInterface.getVerifyOTP(email,otp,widget.userType);

    if(user.status.toString() == "true")
      {
        return true;
      }
    else
      {
        message = user.message.toString();
        return false;
      }

  }





}