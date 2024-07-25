import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/bookingListModel.dart';
import 'package:gasht/ui/bookings/bookingDetails.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import '../../util/colors.dart';
import 'package:dio/dio.dart';


class UpcomingBookings extends StatefulWidget{
  String userType;
   UpcomingBookings( this.userType, {super.key});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookings ();

}

class _UpcomingBookings extends State<UpcomingBookings> {


  final TranslationController _translationController = Get.put(TranslationController());



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<BookingModel>(future: getUpcomingBooking(), builder: (context,snapshot){

      if(snapshot.hasData)
      {

        var model  = snapshot.data?.upcomingBookings;

        if(model!.isNotEmpty) {
          return ListView.builder(
            itemCount: model.length,

            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.centerLeft,

                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                              context) =>  BookingDetails(model[index].id.toString()), //const PlayList( tag: 'Playlists',title:'Podcast'),
                        ),
                      );
                    },
                    child: Row(children: [

                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child:
                          const Icon(Icons.menu_book_outlined,
                            color: AppColors.appColor,)
                      ),

                      Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child:

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 259,
                                height: 21,
                                child:

                                FutureBuilder(future: _translationController.getTransaltion(
                                   "${ model[index].propertyName} (${ model[index].amountPaid})",
                                ),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,

                                          style:const TextStyle(
                                            color: Color(0xFF747474),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 1.67,
                                          ),
                                        );
                                      }
                                      else
                                      {
                                        return

                                          Text(
                                            "${ model[index].propertyName} (${ model[index].amountPaid})",
                                            style:const TextStyle(
                                              color: Color(0xFF747474),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 1.67,
                                            ),
                                          );


                                      }
                                    }),



                              ),

                              Container(alignment: Alignment.topLeft,
                                child:

                                FutureBuilder(future: _translationController.getTransaltion(
                                  "${model[index].startDate} - ${model[index].endDate} ",
                                ),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Text(
                                          snapshot.data!,

                                          style:const TextStyle(
                                            color: Color(0xFF747474),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 1.67,
                                          ),
                                        );
                                      }
                                      else
                                      {
                                        return

                                          Text(
                                            "${model[index].startDate} - ${model[index].endDate} ",
                                            style:const TextStyle(
                                              color: Color(0xFF747474),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              height: 1.67,
                                            ),
                                          );


                                      }
                                    }),


                               ),

                              FutureBuilder(future: _translationController.getTransaltion( '${tr("booking_id")}- ${model[index].bookingId}'),
                                  builder: (context,snapshot){
                                    if(snapshot.hasData)
                                    {
                                      return       Text(
                                          snapshot.data!,

                                        style:  const TextStyle(
                                          color: Color(0xFF747474),
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 1.67,
                                        ),
                                      );
                                    }
                                    else
                                    {
                                      return

                                        Text(
                                          'Booking ID - ${model[index].bookingId}',
                                          style:  const TextStyle(
                                            color: Color(0xFF747474),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 1.67,
                                          ),
                                        );


                                    }
                                  }),


                            ],
                          )


                      ),


                    ],),)
              );
            },
          );
        }
        else
        {



          return
            FutureBuilder(future: _translationController.getTransaltion( "No Booking Found"),
                builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return            Center(child: Text(snapshot.data!,
                      style: TextStyle(color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 18),),);

                  }
                  else
                  {
                    return

                      Center(child: Text("No Booking Found",style:
                      TextStyle(color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 18),),);

                  }
                });
        }
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.green));
      }
      else if (snapshot.hasError) {
        return Center(
            child: Text("Encountered an error: ${snapshot.error}"));
      }
      else {
        return const Text("No internet connection");
      }

    });
  }



  Future<BookingModel> getUpcomingBooking() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    try {

      String? token  = await PrefManager.getString("token");


      if(widget.userType=="Customer") {
        return apiInterface.getCustomerBookingList(token!);
      } else {
        return apiInterface.getOwnerBookingList(token!);
      }

    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
    // return apiInterface.getJobList("", "", "datePosted", "DESC");
  }


}