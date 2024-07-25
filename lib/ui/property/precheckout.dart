import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/moreOptions/profile.dart';
import 'package:gasht/ui/notification.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/bookingListModel.dart';
import '../../data_models/bookpropertyModel.dart';
import '../../loadingScreen.dart';
import '../../util/colors.dart';
import '../dashboard/bottomDashboard.dart';
import '../payment/payment.dart';
import '../prefManager.dart';
import 'package:dio/dio.dart';

class PreCheckout extends StatefulWidget {
  Property propertyList;
  String startDate;
  String endDate;
  PreCheckout(this.propertyList, this.startDate,this.endDate,{super.key});

  @override
  State<PreCheckout> createState() => _PreCheckout();
}

class _PreCheckout extends State<PreCheckout> {
  bool cash = false;
  bool card = true;
  bool wallet = false;

  var totalAmount = 0.0;
  var serviceFee = 0.0;




  final TranslationController _translationController = Get.put(TranslationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceFee = double.parse(widget.propertyList.serviceFee.toString());
    totalAmount =
        (double.parse(widget.propertyList.totalDiscountedPrice.toString()) +
            double.parse(widget.propertyList.serviceFee.toString()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
        FutureBuilder(future: _translationController
            .getTransaltion( "checkout"),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                    snapshot.data!,

                  style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.harmattan().fontFamily),
                );
              }
              else
              {
                return

                  Text("Checkout", style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.harmattan().fontFamily),)
                ;
              }
            }),



      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 110,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.50, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 90,
                    height: 85,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.propertyList.images![0]),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child:
                        FutureBuilder(future: _translationController.getTransaltion(widget.propertyList.propertyName.toString(),
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                  snapshot.data!,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              else
                              {
                                return

                                  Text(
                                    widget.propertyList.propertyName.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )                                ;
                              }
                            }),



                      ),
                      Row(children: [
                        const Icon(Icons.star_border),
                        const SizedBox(
                          width: 5,
                        ),
                        FutureBuilder(future: _translationController.getTransaltion(widget.propertyList.avgRating.toString(),
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                  snapshot.data!,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              else
                              {
                                return

                                  Text(
                                    widget.propertyList.avgRating.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )                                ;
                              }
                            }),

                      ]),
                      Row(children: [
                        const Icon(Icons.location_on_sharp),
                        const SizedBox(
                          width: 5,
                        ),
                        FutureBuilder(future: _translationController.getTransaltion(widget.propertyList.city.toString(),
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                  snapshot.data!,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              else
                              {
                                return

                                  Text(
                                    widget.propertyList.city.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )                                ;
                              }
                            }),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 280,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.50, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(future: _translationController
                      .getTransaltion(
                    'reservation_Details',
                  ),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return       Text(
                            snapshot.data!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          );
                        }
                        else
                        {
                          return
                            Text(
                              'Reservation Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                              ),
                            );                            ;
                        }
                      }),



                  const SizedBox(
                    height: 20,
                  ),
                  //check in date
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(future: _translationController.
                      getTransaltion(  'check_in_date',
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  color: const Color(0xFF3C3C3C),
                            fontSize: 15,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                            ));
                            }
                            else
                            {
                              return
                                Text(
                                  'Check-In date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),



                      const Spacer(),


                      FutureBuilder(future: _translationController
                          .getTransaltion(   widget.startDate,
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                    widget.startDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),


                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //check out date
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(future: _translationController
                          .getTransaltion(  "check_out_date",
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                 "Check-out date",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const Spacer(),
                      FutureBuilder(future: _translationController
                          .getTransaltion( widget.endDate,
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                 widget.endDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //two nights
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(future: _translationController
                          .getTransaltion("sub_Total",
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                  widget.endDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const Spacer(),
                      FutureBuilder(future: _translationController
                          .getTransaltion( widget.propertyList.totalDiscountedPrice.toString(),
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                  widget.propertyList.totalDiscountedPrice.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // service fee
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(future: _translationController
                          .getTransaltion("service_Fee",
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                  "Service Fee",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const Spacer(),
                      FutureBuilder(future: _translationController
                          .getTransaltion(
                        widget.propertyList.serviceFee.toString(),
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                  widget.propertyList.serviceFee.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.75,
                                  ),
                                );
                            }
                          }),

                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(future: _translationController
                          .getTransaltion( "total",
                      ),
                          builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return       Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 18,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.75,
                                  ));
                            }
                            else
                            {
                              return
                                Text(
                                  "Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF3C3C3C),
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.harmattan().fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                            }
                          }),

                      const Spacer(),
                      Text(
                        'IQD ${widget.propertyList.totalDiscountedPrice}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //payment mehtod
            Visibility(
              visible: card,
              child: Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.50, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    FutureBuilder(future: _translationController
                        .getTransaltion( 'payment_method',
                    ),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return       Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF3C3C3C),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ));
                          }
                          else
                          {
                            return
                              Text(
                                'Payment Method',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF3C3C3C),
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                          }
                        }),


                    Row(
                      children: [
                        Checkbox(
                          value: true,

                          onChanged: (value) {
                            setState(() {
                             /* cash = value!;
                              card = false;
                              wallet = false;*/
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FutureBuilder(future: _translationController
                            .getTransaltion( "cash",
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF3C3C3C),
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.75,
                                    ));
                              }
                              else
                              {
                                return
                                  Text(
                                    'Cash',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF3C3C3C),
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.75,
                                    ),
                                  );
                              }
                            }),

                      ],
                    ),
            
                  ],
                ),
              ),
            ),

            Visibility(
              visible: !card,
              child:

              Column(
                children: [

                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(left: 10, right: 10,top: 20),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1.50, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 1,
                        ),
                        FutureBuilder(future: _translationController
                            .getTransaltion( 'reservation_Details',
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ));
                              }
                              else
                              {

                                return

                                  Text(
                                    "Reservation Details",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                              }
                            }),

                        Container(
                            alignment: Alignment.centerLeft,

                            margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                          child:  Text(
                              "service_fee_wallet",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,

                                fontFamily: GoogleFonts.harmattan().fontFamily,
                                fontWeight: FontWeight.w500,
                              )).tr()
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                child:  Text(
                                    "service_Fee",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,

                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    )).tr()
                            ),

                          const  Spacer(),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                child:  Text(
                                    "${widget.propertyList.serviceFee} IQD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,

                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    )).tr()
                            ),

                          ],
                        ),



                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(left: 10, right: 10,top: 10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1.50, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 1,
                        ),
                        FutureBuilder(future: _translationController.
                        getTransaltion( 'wallets',
                        ),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return       Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ));
                              }
                              else
                              {

                                return

                                  Text(
                                    "Wallets",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                              }
                            }),

                        Container(
                            alignment: Alignment.centerLeft,

                            margin: const EdgeInsets.only(left: 0,right: 10,top: 5),
                            child:

                            Row(
                              children: [


                                Checkbox(value: true, onChanged: (vlaue){
                                  setState(() {
                                  //  wallet = vlaue!;
                                  });


                                }),


                               Image.asset("assets/images/walletImg.png",height: 50,)
                              ],
                            )
                        ),


                     /*   Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                child:  Text(
                                    "Service fee ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,

                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    )).tr()
                            ),

                            const  Spacer(),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                child:  Text(
                                    "${widget.propertyList.serviceFee} IQD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,

                                      fontFamily: GoogleFonts.harmattan().fontFamily,
                                      fontWeight: FontWeight.w500,
                                    )).tr()
                            ),

                          ],
                        ),*/



                      ],
                    ),
                  ),


                ],
              ),
            ),


          const  SizedBox(height: 20,),

            Container(

              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 15,bottom: 15),
              width: 150,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor,
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {


                    if(card)
                      {
                        setState(() {
                          card = false;
                        });
                      }
                    else {
                      _showBottomSheet();
                    }



                    //to hit for payment url
                     /* buildLoading(context);


                      getData().then((data) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPayment(data),
                          ),
                        );
                      });
*/


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: GoogleFonts.harmattan().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showDateSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: const Column(
            children: [],
          ),
        );
      },
    );
  }

  Future<PropertyBookingModel> getData() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    String? token = await PrefManager.getString("token");
    return apiInterface.setBooking(
        token!,
        widget.propertyList.id.toString(),
        cash ? serviceFee.toString() : totalAmount.toString(),
        serviceFee.toString(),
        widget.propertyList.totalDiscountedPrice.toString(),
        cash ? "true" : "false",
        widget.startDate,
        widget.endDate
    );
  }





  _showBottomSheet(){

      Get.bottomSheet(
        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
               Center(
                child:
                FutureBuilder(future: _translationController
                    .getTransaltion( "payment_Procedure",
                ),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18,color: Colors.red,fontFamily: GoogleFonts.harmattan().fontFamily),
                        );
                      }
                      else
                      {
                        return

                          Text(
                            'Note : ',
                            style: TextStyle(fontSize: 18,color: Colors.red,fontFamily: GoogleFonts.harmattan().fontFamily),
                          );
                      }
                    }),


              ),
              const SizedBox(height: 20),


              FutureBuilder(future: _translationController.getTransaltion(
               "kindly_transfer_the_service_fee_to_one_of_the_below_numbers_through_the_provide_wallets_for_swift_booking_approval"
              ),
                  builder: (context,snapshot){
                    if(snapshot.hasData)
                    {
                      return       Text(
                        snapshot.data!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                      );
                    }
                    else
                    {
                      return

                        Text(
                          " Kindly transfer the service fee to one of the below numbers through the provided wallets for swift booking approval.",

                          style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                        );
                    }
                  }),



             const SizedBox(height: 10,),
              InkWell(
                onTap: (){

                  _copyToClipboard("0750 378 4042 \n0776 554 4599", context);

                },
                child: SelectableText(
                  "07503784042 \n07765544599",
                  style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: GoogleFonts.harmattan().fontFamily),
                ),
              ),

              const SizedBox(height: 10,),

              Image.asset("assets/images/walletImg.png",height: 80,),


              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50,left: 50,right: 50),
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {




                      //to hit for payment url
                       buildLoading(context);


                      getData().then((data) {


                        if(data.status=="true")
                          {
                            NotificationHandler().showNotification(tr("booking_sent_for_approval_successfully"),"");

                            log("booked property");

                            Navigator.pop(context);
                            Navigator.pop(context);
                            Get.snackbar(tr("booking_Done"),tr("booking_sent_for_approval_successfully"),backgroundColor: Colors.green,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);

                            Navigator.pushReplacement(
                              context,
                             MaterialPageRoute(
                              builder: (context) => const DashboardBottom(), //const PlayList( tag: 'Playlists',title:'Podcast'),
                          ),
                          );
                          }
                        else
                          {
                            NotificationHandler().showNotification("Booking Failed",
                                "Update your Id proof in profile for bookings");

                            Navigator.pop(context);
                            Get.snackbar(data.message.toString(), "",backgroundColor: Colors.red,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);


                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Profile("Customer");
                            }));



                          }


                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'book_Property',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: GoogleFonts.harmattan().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                      ],
                    )),
              ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  }
  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    const snackBar = SnackBar(content: Text('Numbers copied to clipboard'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}


