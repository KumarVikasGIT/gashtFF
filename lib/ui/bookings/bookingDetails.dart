import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/bookingDetailsModel.dart';
import '../prefManager.dart';
import 'package:dio/dio.dart';



class BookingDetails extends StatefulWidget{

 String id;
   BookingDetails(this.id,{super.key});

  @override
  State<BookingDetails> createState() => _BookingDetails ();

}

class _BookingDetails extends State<BookingDetails> {



  final TranslationController _translationController = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder<BookingDetailsModel>(future: getUpcomingBooking(), builder: (context,snapshot){

      if(snapshot.hasData)
      {

        var model  = snapshot.data;

       return  Scaffold(
         appBar: AppBar(
           iconTheme: const IconThemeData(color: Colors.white),

           backgroundColor: AppColors.appColor,
           title: FutureBuilder(future: _translationController.getTransaltion( "booking_Detail"),
               builder: (context,snapshot){
                 if(snapshot.hasData)
                 {
                   return            Text(snapshot.data!,
                     style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,
                         fontSize: 18),);

                 }
                 else
                 {
                   return Center(child: Text("Booking Details",style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18),),);

                 }
               }),
         ),


         //  const Text("My Bookings",style: TextStyle(color: Colors.white),),),

         body:SingleChildScrollView(child: Column(children: [

           Image.network(model!.properties[0].images![0],height: 240,fit: BoxFit.fill,width: double.infinity,),

           //for price and heart
           Row(
             children: [

               Container(
                 margin: const EdgeInsets.only(left: 10,top: 5,right: 10),
                 child:   Text(
                 "AED ${ model.bookingDetails[0].amountPaid}",
                   style: TextStyle(
                     color: const Color(0xFF303030),
                     fontSize: 13,
                     fontFamily:GoogleFonts.inter.toString(),
                     fontWeight: FontWeight.w600,
                     height: 1.54,
                   ),
                 ),
               ),

               const Spacer(),
             /*  Container(
                 margin: const EdgeInsets.only(right: 10,top: 5),
                 child:   IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined)),
               ),
*/
             ],

           ),

         const  SizedBox(height: 10,),

           Row(
             children: [
               const SizedBox(width: 10),
               const Icon(Icons.bed),


               FutureBuilder(future: _translationController.getTransaltion( model.properties[0].bedroom.toString()),
                   builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return            Text(
                         snapshot.data!,
                         style: TextStyle(
                           color: const Color(0xFF3D405B),
                           fontSize: 15,
                           fontFamily: GoogleFonts.inter.toString(),
                           fontWeight: FontWeight.w400,
                         ),
                       );

                     }
                     else
                     {
                       return  Text(
                         model.properties[0].bedroom.toString(),
                         style: TextStyle(
                           color: const Color(0xFF3D405B),
                           fontSize: 15,
                           fontFamily: GoogleFonts.inter.toString(),
                           fontWeight: FontWeight.w400,
                         ),
                       );
                     }
                   }),


               const SizedBox(width: 10),
               const Icon(Icons.crop_square),
               FutureBuilder(future: _translationController.getTransaltion( model.properties[0].area.toString()),
                   builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return            Text(
                         snapshot.data!,
                         style: TextStyle(
                           color: const Color(0xFF3D405B),
                           fontSize: 15,
                           fontFamily: GoogleFonts.inter.toString(),
                           fontWeight: FontWeight.w400,
                         ),
                       );

                     }
                     else
                     {
                       return  Text(
                         model.properties[0].area.toString(),
                         style: TextStyle(
                           color: const Color(0xFF3D405B),
                           fontSize: 15,
                           fontFamily: GoogleFonts.inter.toString(),
                           fontWeight: FontWeight.w400,
                         ),
                       );
                     }
                   }),


             ],


           ),


           Row(
             children: [

               Container(
                 margin: const EdgeInsets.only(left: 10,top: 10,right: 10),
                 child:


                 FutureBuilder(future: _translationController.getTransaltion( model.properties[0].propertyName.toString()),
                     builder: (context,snapshot){
                       if(snapshot.hasData)
                       {
                         return            Text(
                           snapshot.data!,
                           style: TextStyle(
                             color: const Color(0xFF3D405B),
                             fontSize: 15,
                             fontFamily: GoogleFonts.inter().fontFamily,
                             fontWeight: FontWeight.w400,
                           ),
                         );

                       }
                       else
                       {
                         return  Text(
                           model.properties[0].propertyName.toString(),
                           style: TextStyle(
                             color: const Color(0xFF3D405B),
                             fontSize: 15,
                             fontFamily: GoogleFonts.inter().fontFamily,
                             fontWeight: FontWeight.w400,
                           ),
                         );
                       }
                     }),

               ),

               const Spacer(),
               Container(
                 margin: const EdgeInsets.only(right: 10,top: 5,left: 10),
                 child:

                 FutureBuilder(future: _translationController.getTransaltion( '${tr("unit_code")} (${ model.properties[0].id.toString()})'),
                     builder: (context,snapshot){
                       if(snapshot.hasData)
                       {
                         return            Text(
                           snapshot.data!,
                           style: TextStyle(
                             color: const Color(0xFF3D405B),
                             fontSize: 15,
                             fontFamily: GoogleFonts.inter.toString(),
                             fontWeight: FontWeight.w400,
                           ),
                         );

                       }
                       else
                       {
                         return  Text(
                             'Unit Code (${ model.properties[0].id.toString()})',
                           style: TextStyle(
                             color: const Color(0xFF3D405B),
                             fontSize: 15,
                             fontFamily: GoogleFonts.inter.toString(),
                             fontWeight: FontWeight.w400,
                           ),
                         );
                       }
                     }),


               ),

             ],

           ),



           const Divider(
             thickness: 2,

           ),

           const SizedBox(height: 20,),

           //Booking id
           Row(children: [
             const SizedBox(width: 10,),
             FutureBuilder(future: _translationController.getTransaltion( "booking_id"),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return            Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );

                   }
                   else
                   {
                     return  Text(
                       'Booking ID',
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );
                   }
                 }),


             const Spacer(),
             Text(
               model.bookingDetails[0].bookingId.toString(),

               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontFamily: GoogleFonts.poppins.toString(),
                 fontWeight: FontWeight.w500,
                 letterSpacing: 0.75,
               ),
             ),

             const SizedBox(width: 10,),


           ],),


           const SizedBox(height: 20,),
           //booking date
           Row(children: [
             const SizedBox(width: 10,),

             FutureBuilder(future: _translationController.getTransaltion( "booking_Date"),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return            Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );

                   }
                   else
                   {
                     return  Text(
                       'Booking Date',
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );
                   }
                 }),



             const Spacer(),
             Text(
                 model.bookingDetails[0].bookingDate.toString(),

               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontFamily: GoogleFonts.poppins.toString(),
                 fontWeight: FontWeight.w500,
                 letterSpacing: 0.75,
               ),
             ),

             const SizedBox(width: 10,),


           ],),

           const SizedBox(height: 20,),

           //Check in date
           Row(children: [
             const SizedBox(width: 10,),

             FutureBuilder(future: _translationController.getTransaltion( "check_in_date"),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return            Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );

                   }
                   else
                   {
                     return  Text(
                       'Booking Date',
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );
                   }
                 }),


             const Spacer(),
             Text(
               model.bookingDetails[0].startDate.toString(),

               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontFamily: GoogleFonts.poppins.toString(),
                 fontWeight: FontWeight.w500,
                 letterSpacing: 0.75,
               ),
             ),

             const SizedBox(width: 10,),


           ],),


           const SizedBox(height: 20,),

           //check out date
           Row(children: [
             const SizedBox(width: 10,),

             FutureBuilder(future: _translationController.getTransaltion( "check_out_date"),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return            Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );

                   }
                   else
                   {
                     return  Text(
                       'Booking Date',
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );
                   }
                 }),


             const Spacer(),
             Text(
               model.bookingDetails[0].endDate.toString(),

               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontFamily: GoogleFonts.poppins.toString(),
                 fontWeight: FontWeight.w500,
                 letterSpacing: 0.75,
               ),
             ),

             const SizedBox(width: 10,),


           ],),


           const SizedBox(height: 20,),
           //Amount paid
           Row(children: [
             const SizedBox(width: 10,),


             FutureBuilder(future: _translationController.getTransaltion( "amount_Paid"),
                 builder: (context,snapshot){
                   if(snapshot.hasData)
                   {
                     return            Text(
                       snapshot.data!,
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );

                   }
                   else
                   {
                     return  Text(
                       'Amount Paid',
                       style: TextStyle(
                         color: const Color(0xFF3D405B),
                         fontSize: 15,
                         fontFamily: GoogleFonts.inter().fontFamily,
                         fontWeight: FontWeight.w400,
                       ),
                     );
                   }
                 }),





             const Spacer(),
             Text(
                 " AED ${model.bookingDetails[0].amountPaid}",

               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 15,
                 fontFamily: GoogleFonts.poppins.toString(),
                 fontWeight: FontWeight.w500,
                 letterSpacing: 0.75,
               ),
             ),

             const SizedBox(width: 10,),


           ],),


         ],),
         ) ,
       );
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



  Future<BookingDetailsModel> getUpcomingBooking() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    try {

      String? token  = await PrefManager.getString("token");

      return apiInterface.getBookingDetail(token!,widget.id);
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
    // return apiInterface.getJobList("", "", "datePosted", "DESC");
  }



}