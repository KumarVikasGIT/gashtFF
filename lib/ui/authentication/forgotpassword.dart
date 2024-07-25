import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/authentication/signupgettersetter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import 'otp.dart';

class ForgotPassword extends StatefulWidget {
  final String email,userType;
   const ForgotPassword(this.email,this.userType,{Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {

late String message;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    return Scaffold(
      appBar: AppBar(title: const Text("forget_your_password?").tr(),),
      body: SingleChildScrollView(child: 
        Column(children: [

          Image.asset("assets/images/forgotpassword.png"),


          Container(
            margin: const EdgeInsets.only(left: 10,right: 10),
            child: Text(
              'select_which_contact_details_should_we_use_to_reset_your_password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GoogleFonts.lato().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
          ),

          const SizedBox(height: 80,),

         InkWell(
           onTap: (){

             buildLoading(context);
            checkEmail();


           },
           child:  Container(
           margin: const EdgeInsets.only(left: 10,right: 10,),
           height: 95,
           decoration: ShapeDecoration(
             color: Colors.white,
             shape: RoundedRectangleBorder(
               side: const BorderSide(width: 0.70, color: Color(0xFFFBBC05)),
               borderRadius: BorderRadius.circular(30),
             ),
           ),
           child: Row(
             children: [

               const SizedBox(width: 50,),
               Container(
                 width: 55,
                 height: 55,
                 decoration: const ShapeDecoration(
                   color: Color(0x4CFBBC05),
                   shape: OvalBorder(),
                 ),
                 child: const Icon(Icons.mail_outline,color: Color(0xFFFBBC05) ,),
               ),
               const SizedBox(width: 30,),

               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text(
                     'via_Email',
                     style: TextStyle(
                       color: const Color(0xFF5A5A5A),
                       fontSize: 17,
                       fontFamily: GoogleFonts.lato().fontFamily,
                       fontWeight: FontWeight.w400,
                     ),
                   ).tr(),
                   Text(
                     widget.email,
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 15,
                       fontFamily: GoogleFonts.lato().fontFamily,
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                 ],)


             ],
           ),
         ),
         ),


        ],)
        ,),
    );
    
  }


  Future<void>checkEmail()async{

    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    sendOtp(apiInterface, widget.email).then((success){
      if(success){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text('code_has_been_sent_to:').tr(),backgroundColor: Colors.green,));
        var user  = User("name", "email", "password", "user_type");
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return   Otp(widget.email,"old",user,widget.userType);
        }));


      }
      else
        {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(message),backgroundColor: Colors.red,));

        }
    });


  }




  Future<bool>sendOtp(RetrofitInterface apiInterface, String text) async {

    try {
      Model_Login user = await apiInterface.getForgotPassword(text,"old",widget.userType);

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