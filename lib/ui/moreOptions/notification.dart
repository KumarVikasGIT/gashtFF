import 'package:flutter/material.dart';
import 'package:gasht/data_models/notificationModel.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/colors.dart';

import '../../api/retrofit_interface.dart';
import 'package:dio/dio.dart';

import '../prefManager.dart';

class Notifications extends StatefulWidget{

  String user_type;
   Notifications(this.user_type,{super.key});

  @override
  State<Notifications> createState() => _Notifications ();

}

class _Notifications extends State<Notifications> {



  final TranslationController _translationController = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
        FutureBuilder(future: _translationController.getTransaltion(
          "notifications"),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return
                  Text(
                  snapshot.data!
                  ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.w500,
                    height: 1.67,
                  ),
                )  ;

              }
              else
              {
                return
                  const Text("Notifications",style: TextStyle(color: Colors.white),)
              ;
              }
            }),



      ),

      body:
      FutureBuilder<NotificationModel>(future: getUpcomingBooking(), builder: (context,snapshot){

        if(snapshot.hasData)
        {

          var model  = snapshot.data?.notifications!;

          if(model!.isNotEmpty) {
            return ListView.builder(
              itemCount:model.length,

              itemBuilder: (BuildContext context, int index) {

                return Container(
                    margin: const EdgeInsets.only(left: 0,top: 10),
                    alignment: Alignment.centerLeft,

                    child:InkWell(
                      onTap: (){
                        /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   const BookingDetails(),//const PlayList( tag: 'Playlists',title:'Podcast'),
                  ),
                );*/
                      },
                      child:  Column( children: [
                        Row( children: [

                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 10,right:10,top: 5 ),
                              child:
                              const Icon(Icons.notifications_none_rounded,color: AppColors.appColor,)
                          ),

                          Container(
                              margin: const EdgeInsets.only(left: 10,right:10,top: 5,bottom: 5 ),
                              child:

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  FutureBuilder(future: _translationController.getTransaltion(
                              model[index].title.toString()),
                              builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return            Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: GoogleFonts.poppins.toString(),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );

                                        }
                                        else
                                        {
                                          return
                                            Text(
                                              model[index].title.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: GoogleFonts.poppins.toString(),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            );
                                        }
                                      }),




                                  Container(
                                    width: 300,
                                    margin: const  EdgeInsets.only(right: 10),
                                    alignment: Alignment.topLeft,
                                    child:

                                    FutureBuilder(future: _translationController.getTransaltion(
                                        model[index].description.toString()),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return              Text(
                                              snapshot.data!
                                             ,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: const Color(0xFF747474),
                                                fontSize: 12,
                                                fontFamily: GoogleFonts.inter.toString(),
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            )  ;

                                          }
                                          else
                                          {
                                            return
                                              Text(
                                                model[index].description.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: const Color(0xFF747474),
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts.inter.toString(),
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.67,
                                                ),
                                              )  ;
                                          }
                                        }),


                                 ),
                                ],
                              )



                          ),


                        ],),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xD3E4E4E4),
                              ),
                            ),
                          ),
                        ),

                      ],)



                      ,)
                );



              },
            );
          }
          else
          {
            return Center(child: Text("No Notifications Found",style: TextStyle(color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18),),);
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

      })



    );


  }




  Future<NotificationModel> getUpcomingBooking() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    try {

      String? token  = await PrefManager.getString("token");


      return apiInterface.getNotifications(token!,widget.user_type);

    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
    // return apiInterface.getJobList("", "", "datePosted", "DESC");
  }


  
}