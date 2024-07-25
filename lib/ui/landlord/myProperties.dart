import 'package:flutter/material.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:gasht/ui/landlord/editProperty.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/propertyObject.dart';
import '../prefManager.dart';
import 'package:dio/dio.dart';



class MyProperties extends StatefulWidget{
  const MyProperties({super.key});

  @override
  State<MyProperties> createState() => _MyProperties ();

}

class _MyProperties extends State<MyProperties> {
  String imgUrl ="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";
  final TextEditingController _searchController = TextEditingController();
  //String imgUrl = "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80";
  int current = 0;
  List<String> items = [
    "All",
    "House",
    "Villa",
    "Apartment",
    /*  "Farm House",
      "Hotel",*/

  ];



  final TranslationController _translationController = Get.put(TranslationController());




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        title:
        FutureBuilder(
            future: _translationController.getTransaltion(  "my_Properties"   ),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return       Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
              else
              {
                return
                  Text(
                   "My Properties",

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 15,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ;
              }
            }),




        automaticallyImplyLeading: false,),
      body: Column(
        children: [
          const SizedBox(height: 10,),



          FutureBuilder<PropertyObjects>(future: getPropertyList(), builder:  (context,snapshot){
            if (snapshot.hasData) {

              var   propertyList = snapshot.data!.properties!;

              if(propertyList.isEmpty)
                {
                  return   FutureBuilder(future: _translationController.getTransaltion( "Post a property"),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                        {
                          return            Center(child: Text(snapshot.data!,
                            style: TextStyle(color: Colors.black,fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 18),),);

                        }
                        else
                        {
                          return Center(child: Text("Post a property",style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18),),);

                        }
                      });
                }
              else {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                    ),
                    itemCount: propertyList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return IntrinsicHeight(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return EditProperty(propertyList[index]);
                            }));
                          },
                          child:Container(
                            margin: const EdgeInsets.all(6),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          propertyList[index].images![0]
                                              .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),


                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5),
                                  alignment: Alignment.centerLeft,
                                  child:

                                  FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].propertyName.toString()),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData)
                                        {
                                          return            Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: GoogleFonts
                                                  .inter()
                                                  .fontFamily,
                                              fontWeight: FontWeight.w500,
                                              height: 1.67,
                                            ),
                                          );

                                        }
                                        else
                                        {
                                          return
                                            Text(
                                              propertyList[index].propertyName.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );
                                        }
                                      }),



                                ),

                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    const Icon(Icons.bed),
                                    FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].bedroom.toString()),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return            Text(
                                              snapshot.data!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );

                                          }
                                          else
                                          {
                                            return
                                              Text(
                                                propertyList[index].bedroom.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts
                                                      .inter()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.67,
                                                ),
                                              );
                                          }
                                        }),

                                    const SizedBox(width: 1),
                                    const Icon(Icons.crop_square),
                                    FutureBuilder(future: _translationController.getTransaltion(   propertyList[index].area.toString()),
                                        builder: (context,snapshot){
                                          if(snapshot.hasData)
                                          {
                                            return            Text(
                                              snapshot.data!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: GoogleFonts
                                                    .inter()
                                                    .fontFamily,
                                                fontWeight: FontWeight.w500,
                                                height: 1.67,
                                              ),
                                            );

                                          }
                                          else
                                          {
                                            return
                                              Text(
                                                propertyList[index].area.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts
                                                      .inter()
                                                      .fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.67,
                                                ),
                                              );
                                          }
                                        }),


                                  ],


                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'AED ${propertyList[index].price}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: GoogleFonts
                                          .inter()
                                          .fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                                // ... Other widgets ...
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.appColor));
            }
            else if (snapshot.hasError) {
              return Center(
                  child: Text("Encountered an error: ${snapshot.error}"));
            }
            else {
              return const Text("No internet connection");
            }




          })


        ],
      ),
    );

  }

  Future<PropertyObjects> getPropertyList() async {
    RetrofitInterface apiInterface = RetrofitInterface(Dio());
    String ? token  = await PrefManager.getString("token");

    try {
      return apiInterface.getMyPropertyList(token!);
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the FutureBuilder
    }
    // return apiInterface.getJobList("", "", "datePosted", "DESC");
  }
}