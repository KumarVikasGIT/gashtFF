import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/bookings/pastBooking.dart';
import 'package:gasht/ui/bookings/upcomingBooking.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/colors.dart';


class Bookings extends StatefulWidget{

  String userType;
   Bookings(this.userType,{super.key});

  @override
  State<Bookings> createState() => _Bookings ();

}

class _Bookings extends State<Bookings> {
  int current = 0;
  List<String> items = [
    tr("upcoming"),
    tr("past"),

  ];

     late List<Widget> widgetOptions ;


     final TranslationController _translationController = Get.put(TranslationController());


     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetOptions   = <Widget>[


       UpcomingBookings(widget.userType),
       PastBookings(widget.userType),



       ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.appColor,
        title:
        FutureBuilder(future: _translationController.getTransaltion( "booking"),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                    snapshot.data!,

                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts
                            .lato()
                            .fontFamily,
                        color: Colors.white)
                );
              }
              else
              {
                return

                  const Text("My Bookings",style: TextStyle(color: Colors.white),)

                ;
              }
            }),



      ),
      body: Column(children: [

       const SizedBox(height: 20,),
        SizedBox(
          width: double.infinity,
          height: 40,
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
                      child: Container(

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

                            FutureBuilder(future: _translationController.getTransaltion( items[index]),
                                builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return       Text(
                                        snapshot.data!,

                                        style: TextStyle(fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts
                                                .lato()
                                                .fontFamily,
                                            color: Colors.black));
                                  }
                                  else
                                  {
                                    return

                                      Text(
                                        items[index],
                                        style: TextStyle(fontSize: 20.0),
                                      )
                                    ;
                                  }
                                }),


                          ),
                        ),
                        /*Text(
                          items[index],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: current == index ? Colors.black : Colors.grey,
                            decoration: current == index ? TextDecoration.underline : TextDecoration.none,
                            decorationColor: current == index ? AppColors.appColor : null,
                            decorationThickness: current == index ? 2.0 : 0.0,

                          ),
                        ),
                      */
                      ),


                    ),
                  ],
                );
              }),
        ),
        Expanded(

          child:  widgetOptions.elementAt(current),


        )

      ],),
    );
  }
}