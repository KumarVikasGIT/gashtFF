
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/loadingScreen.dart';
import 'package:gasht/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatefulWidget{
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenter ();

}

class _HelpCenter extends State<HelpCenter> {


  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController messageCont = TextEditingController();


  _onChangeText(value) => debugPrint("_onChangeText: $value");
  _onSubmittedText(value) => debugPrint("_onSubmittedText: $value");

  static Pattern pattern = "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+";
  RegExp regExp = RegExp(pattern.toString());




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("contact_us",style: TextStyle(color: Colors.white),).tr(),),
    body: SingleChildScrollView(
      child: Column(children: [

        Container(
          margin: const EdgeInsets.only(left:5,right: 5,top: 5 ),
          child: Image.asset("assets/images/contactUs.png"),
        ),


        const SizedBox(height: 20,),




        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [





            InkWell(


              onTap: () async {


                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: "info@gasht.co",
                  queryParameters: {
                    'subject': "",
                    'body': "",
                  },

                );

                final Uri email = Uri( path: 'mailto:test@example.org?subject=Greetings&body=Hello%20World');

                await launchUrl(email);


                if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
                } else {

                throw 'Could not launch email';

                }


              },
              child:  Container(
              width: 84,
              height: 84,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const ShapeDecoration(
                      color: Color(0x2DFBBC05),
                      shape: OvalBorder(),
                    ),
                    child: const Icon(Icons.mail, color: Color(0xFFFBBC05),),

                  ),

                  Text(
                    tr("email_us"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFBBC05),
                      fontSize: 12,
                      fontFamily: GoogleFonts.harmattan().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],),
            ),),


            //whats app
            InkWell(


              onTap: () async {
                const phoneNumber = '+9647705544599'; // Replace with the desired phone number
                const url = 'whatsapp://send?phone=$phoneNumber';

                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  // Handle error
                  print('Could not launch WhatsApp.');
                }



              },
              child:  Container(
                width: 84,
                height: 84,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const ShapeDecoration(
                        color: Color(0x2D553791),
                        shape: OvalBorder(),
                      ),
                      child: const Icon(Icons.chat_outlined, color: AppColors.appColor,),

                    ),

                    Text(
                      tr('chat'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.appColor,
                        fontSize: 12,
                        fontFamily: GoogleFonts.harmattan().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],),
              ),),


        ],),

        const SizedBox(height: 30,),

        Text(
          "quick_contact",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: GoogleFonts.harmattan().fontFamily,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.70,
          ),
        ).tr(),

        const SizedBox(height: 10,),

        Container(
          margin: const EdgeInsets.only(left: 20),
         alignment: Alignment.centerLeft,
          child:   Text(
            'full_Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: GoogleFonts.harmattan().fontFamily,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.70,
            ),
          ).tr(),

        ),

        Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            child:
            Opacity(
              opacity: 0.50,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 5,right: 5),
                height: 47,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFFDADADA)),
                    borderRadius: BorderRadius.circular(7),
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
                child:    TextField(
                  controller: nameCont,
                  onChanged: _onChangeText,
                  onSubmitted: _onSubmittedText,
                  autocorrect: true,
                  decoration:  InputDecoration(
                    hintText:tr( 'full_Name'),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),


        ),


        const SizedBox(height: 10,),

        Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child:         Text(
            'email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: GoogleFonts.harmattan().fontFamily,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.70,
            ),
          ).tr(),

        ),

        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child:
          Opacity(
            opacity: 0.50,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 5,right: 5),
              height: 47,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(7),
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
              child:    TextField(
                controller: emailCont,
                onChanged: _onChangeText,
                onSubmitted: _onSubmittedText,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  hintText: tr('email'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),


        ),


        const SizedBox(height: 10,),

        Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child:         Text(
            'messages',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: GoogleFonts.harmattan().fontFamily,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.70,
            ),
          ).tr(),

        ),

        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child:
          Opacity(
            opacity: 0.50,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 5,right: 5),
              height: 110,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFFDADADA)),
                  borderRadius: BorderRadius.circular(7),
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
              child:    TextField(
                onChanged: _onChangeText,
                controller: messageCont,
                onSubmitted: _onSubmittedText,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                  hintText: tr("enter_your_message_here"),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),


        ),
        const SizedBox(height: 20,),

        InkWell(
          onTap: () async {

            if(nameCont.text.isEmpty)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Name is required'),
                  backgroundColor: Colors.red,));

              }
            else if(emailCont.text.isEmpty)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Email is required'),
                  backgroundColor: Colors.red,));

              }
            else if (!regExp.hasMatch(emailCont.text.trim())) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Valid email is required'),
                backgroundColor: Colors.red,));
            }
            else
              if(messageCont.text.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Message is required'),
                    backgroundColor: Colors.red,));

                }
              else
                {
                  buildLoading(context);
                  RetrofitInterface retrofit = RetrofitInterface(Dio());

                  var model = await retrofit.getQuick_contact(nameCont.text, emailCont.text, messageCont.text);

                  if(model.status=="true")
                    {
                      Navigator.pop(context);
                      messageCont.clear();
                      nameCont.clear();
                      emailCont.clear();
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(tr("query_sent_successfully")),
                        backgroundColor: Colors.green,));
                    }
                  else
                    {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Query  was not send successfully'),
                        backgroundColor: Colors.red,));
                    }


                }

          },
          child: Container(
          width: 94,
          height: 35,
          decoration: ShapeDecoration(
            color: const Color(0xFF553791),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            Text(
           tr('send'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: GoogleFonts.inter.toString(),
                fontWeight: FontWeight.w500,
              ),
            ),

            const Icon(Icons.arrow_forward_sharp,color: Colors.white,)
            
          ],),
          
          

        ),
        ),

        const SizedBox(height: 20,),


      ],),

    ),
    );
  }


}