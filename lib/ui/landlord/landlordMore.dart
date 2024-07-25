import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/bookings/bookings.dart';
import 'package:gasht/ui/moreOptions/changeLanguage.dart';
import 'package:gasht/ui/moreOptions/faq.dart';
import 'package:gasht/ui/moreOptions/helpCenter.dart';
import 'package:gasht/ui/moreOptions/notification.dart';
import 'package:gasht/ui/moreOptions/termsofuse.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/langaugeCotroller.dart';
import '../dashboard/bottomDashboard.dart';
import '../moreOptions/profile.dart';
import '../prefManager.dart';


class LandloardMore extends StatefulWidget{
  const LandloardMore({super.key});




  @override
  State<LandloardMore> createState() => _More ();




}

class _More extends State<LandloardMore> {


  final TranslationController _translationController = Get.put(TranslationController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:
    SingleChildScrollView(
      child: Column(
        children: [

          const SizedBox(height: 40,),

         Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 10),
            child:  Text(
             tr("settings"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF121212),
                fontSize: 18,
                fontFamily: GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w500,
              ),
            ),

          ),


          /*const SizedBox(height: 10,),

          Row(children: [
            const SizedBox(width: 20,),

            Text(
              'Reservations',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF555555),
                fontSize: 15,
                fontFamily: GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75,
              ),
            ),

            const Spacer(),
            Text(
              '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GoogleFonts.poppins.toString(),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75,
              ),
            ),

            const SizedBox(width: 20,),


          ],),*/
          





          const SizedBox(height: 20,),


          //profile
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    Profile("Owner"),//const PlayList( tag: 'Playlists',title:'Podcast'),
                ),
              );

            },

            child:

            Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.account_circle_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "profile"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return
                          Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ),
          ),

          const SizedBox(height: 20,),


          //bookings
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    Bookings("Owner"),//const PlayList( tag: 'Playlists',title:'Podcast'),
                )

                ,
              );

            },

            child:  Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.calendar_month_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "booking"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Booking',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),

              ],
            ),
          ),

          const SizedBox(height: 20,),


          //payment
       /*   Row(
            children: [
              const SizedBox(width: 20,),

              const    Icon(Icons.payment,color: Color(0xFF555555),),
              const   SizedBox(width: 20,),
              Text(
                'Payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF323232),
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins.toString(),
                  fontWeight: FontWeight.w400,
                ),
              ),

            ],
          ),


          const SizedBox(height: 20,),*/


          //Notification

          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    Notifications("Owner"),//const PlayList( tag: 'Playlists',title:'Podcast'),
                ),
              );

            },

            child:   Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.notifications_none_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "notifications"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Notification',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ),
          ),



          const SizedBox(height: 20,),


//chnage langauge
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   const ChangeLanguage(),//const PlayList( tag: 'Playlists',title:'Podcast'),
                ),
              );

            },
            child:  Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.language,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "change_language"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'change_language',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ),
          ),
          //Change Language



          const SizedBox(height: 20,),

          //faq

          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>    const FAQ(),//const PlayList( tag: 'Playlists',title:'Podcast'),
                ),
              );

            },
            child:

            Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.question_answer_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "fAQ"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'FAQ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            )
            ,),
          const SizedBox(height: 20,),


          //terms

          InkWell(onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>    const TermsAndPolicy(stringValue:"terms_of_use"),//const PlayList( tag: 'Playlists',title:'Podcast'),
            ),
          );},
            child: Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.lock_person_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "terms_of_use"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Terms of use',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ),
          ),





          const SizedBox(height: 20,),

//privacy
          InkWell(onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>    const TermsAndPolicy(stringValue:"privacy_policy"),//const PlayList( tag: 'Playlists',title:'Podcast'),
            ),
          );},
            child:  Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.privacy_tip_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.
                getTransaltion( "privacy_policy"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Privacy Policy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ),
          ),



          const SizedBox(height: 20,),


//contact us
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   const HelpCenter(),//const PlayList( tag: 'Playlists',title:'Podcast'),
                ),
              );
            },

            child:Row(
              children: [
                const SizedBox(width: 20,),

                const    Icon(Icons.contact_phone_outlined,color: Color(0xFF555555),),
                const   SizedBox(width: 20,),
                FutureBuilder(future: _translationController.getTransaltion( "contact_us"),
                    builder: (context,snapshot){
                      if(snapshot.hasData)
                      {
                        return       Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: const Color(0xFF323232),
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins.toString(),
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }
                      else
                      {
                        return
                          Text(
                            'Contact Us',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF323232),
                              fontSize: 14,
                              fontFamily: GoogleFonts.poppins.toString(),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ;
                      }
                    }),


              ],
            ) ,
          ),
          // contact us



          const SizedBox(height: 20,),

          //logout
          Row(
            children: [
              const SizedBox(width: 20,),

              const    Icon(Icons.logout,color: Color(0xFF555555),),
              const   SizedBox(width: 20,),
             InkWell(
               onTap: (){

                 PrefManager.clearPref();
                 PrefManager.clearPref();
                 PrefManager.clearPref();

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                   return const DashboardBottom();
                 }));
               },
               child:
               FutureBuilder(future: _translationController.getTransaltion( "logout"),
                   builder: (context,snapshot){
                     if(snapshot.hasData)
                     {
                       return       Text(
                         snapshot.data!,
                         textAlign: TextAlign.center,

                         style: TextStyle(
                           color: const Color(0xFF323232),
                           fontSize: 14,
                           fontFamily: GoogleFonts.poppins.toString(),
                           fontWeight: FontWeight.w400,
                         ),
                       );
                     }
                     else
                     {
                       return
                         Text(
                           'Logout',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             color: const Color(0xFF323232),
                             fontSize: 14,
                             fontFamily: GoogleFonts.poppins.toString(),
                             fontWeight: FontWeight.w400,
                           ),
                         )
                       ;
                     }
                   }),

             )

            ],
          ),


        ],
      ),
    )

      ,);
  }

}