import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});




  @override
  State<HomePage> createState() => _HomePage ();




}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        title: Text('welcome'.tr),),
      body:Column(
        children: [

        Container(

          decoration: const ShapeDecoration(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              )
          ),

          height: 200,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 45,),
              Row(children: [
               Container(

                 margin: const EdgeInsets.only(left: 10),
                 child:  Column(

                   children: [
                     Text(

                       'Location',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 12,
                         fontFamily: GoogleFonts.inter.toString(),
                         fontWeight: FontWeight.w400,
                       ),
                     ),
                     Text(
                       'Dubai',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                         fontFamily: GoogleFonts.inter.toString(),
                         fontWeight: FontWeight.w500,
                       ),
                     )
                   ],
                 ),
               ),

                IconButton(onPressed: (){

                }, icon: const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.white,)),
                const Spacer(),

                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined,color: Colors.white,)),
                    ),
                Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const ShapeDecoration(
                  image: DecorationImage(
                  fit: BoxFit.cover,

                  image: AssetImage("assets/images/profileImg.png"),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all( Radius.circular(20))
                      )
                  ),

                )

              ],
              ),



              Row(
                children: [

                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(right: 80,left: 10),
                    height: 32,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),


                  ),

                ],

              ),


            ],
          )

          ,

        ),

        ],
      ),
    ) ;
  }

}