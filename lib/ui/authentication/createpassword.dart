import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/retrofit_interface.dart';
import '../../data_models/model_login.dart';
import '../../loadingScreen.dart';
import 'package:dio/dio.dart';
import '../dashboard/bottomDashboard.dart';
import 'login.dart';


class CreatePassword extends StatefulWidget {
  String email,userType;
   CreatePassword(this.email,this.userType,{Key? key}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePassword();
}

class _CreatePassword extends State<CreatePassword> {
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodePassword1 = FocusNode();

  final TextEditingController controllerCnfPassword = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureCnfPassword = true;

  late String message;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: const Text("Create_Password").tr(),),
      body: SingleChildScrollView(child:
      Column(children: [
        const SizedBox(height: 40,),

        Image.asset("assets/images/createpassowrd.png"),


        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Text(
            'Create_your_new_password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
        ),

       const SizedBox(height: 20,),

       Container(
         margin: const EdgeInsets.only(left: 10,right: 10),
         child:  TextFormField(
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
       ),
        const SizedBox(height: 20,),

        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child:  TextFormField(
            controller: controllerCnfPassword,
            focusNode: _focusNodePassword1,
            obscureText: _obscureCnfPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: tr("Confirm_Password"),
              prefixIcon: const Icon(Icons.lock_person_rounded),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureCnfPassword = !_obscureCnfPassword;
                    });
                  },
                  icon: _obscureCnfPassword
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
        ),
        const SizedBox(height: 40,),

        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child:    ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColor,
              elevation: 2.5,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ), onPressed: () {

            // loginValidator();


            changePassword();

            /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const Login();

            }));*/


          }, child: Text("Create_Password",style: TextStyle(
              color:Colors.white,fontSize: 20,
              fontWeight: FontWeight.bold,fontFamily: GoogleFonts.athiti().fontFamily)).tr(),),
        )


      ],)
        ,),
    );

  }

  void changePassword() {
    if(controllerPassword.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text('password_is_required').tr(),backgroundColor: Colors.red));

    }
    else  if(controllerPassword.text.trim().length<6){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text('Password_length_short').tr(),backgroundColor: Colors.red));

    }
    else   if(controllerCnfPassword.text.trim().isEmpty){

      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: const Text('Confirm_Password_is_required').tr(),backgroundColor: Colors.red));

    }

    else if (controllerCnfPassword.text != controllerPassword.text)
      {
        ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: const Text('both_Passwords_are_different').tr(),backgroundColor: Colors.red));

      }
    else
      {
        buildLoading(context);
        RetrofitInterface apiInterface = RetrofitInterface(Dio());

        passowrd(
            apiInterface,controllerCnfPassword.text).then((success) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content:const Text('password_Changed_Successfully').tr(),
              backgroundColor: Colors.green,));
            if(widget.userType=="Owner") {


              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login(widget.userType)),
              );
            }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardBottom()),
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

  Future<bool>  passowrd(RetrofitInterface apiInterface, String text,)async {


    print("password and email ===$text ==== ${widget.email}");
    Model_Login user = await apiInterface.setChangePassword(widget.email,text,widget.userType);
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


  }

