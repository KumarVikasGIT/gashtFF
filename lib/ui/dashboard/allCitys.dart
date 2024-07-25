import 'package:blur_container/blur_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_dart.dart';
import 'package:gasht/ui/dashboard/cityWiseHouseList.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/colors.dart';
import '../controllers/langaugeCotroller.dart';

class AllCitys extends StatefulWidget {
  ModelResort data;
   AllCitys({Key? key, required  this.data}) : super(key: key);

  @override
  State<AllCitys> createState() => _AllCitys();
}

class _AllCitys extends State<AllCitys> {

  final TranslationController _translationController = Get.put(TranslationController());

  final TextEditingController _searchController = TextEditingController();
  final FocusNode focusNode = FocusNode(canRequestFocus: true);
  bool isSearchBoxOpened = false;

  late List<Cities> originalList = [];
  late List<Cities> model = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    originalList =widget.data.cities;

    model = originalList;

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Column(children: [

        const SizedBox(height: 40,),

        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: IconButton(onPressed: (){

                Navigator.pop(context);

              }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),

            ),


            FutureBuilder(future: _translationController.getTransaltion("travel_to_cities"), builder: (context,snapshot){
              if(snapshot.hasData)
              {
                return   Container(
                  alignment: Alignment.centerLeft,

                  margin: const EdgeInsets.only(left: 15,top: 0,right: 15),
                  child: Text(snapshot.data!,

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: GoogleFonts.poppins.toString(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                );
              }
              else
              {
                return   Container(
                  margin: const EdgeInsets.only(left: 15,top: 10,right: 15),
                  child: Text('Travel to cities',
                    style: TextStyle(fontFamily: GoogleFonts.montserrat.toString()
                      , color: const Color(0xFF3C3C3C),

                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                      letterSpacing: 0.75,
                    )
                    ,),


                );
              }
            }),



          ],

        ),

        Container(
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.only(top: 1,left: 10,right: 10),
          decoration: BoxDecoration(
            color: AppColors.textBoxColor,
            border: Border.all(color: AppColors.textBoxColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x21000000),
                blurRadius: 5.73,
                offset: Offset(0, 0.97),
                spreadRadius: 0,
              )
            ],
          ),
          child: TextField(
            readOnly: false,
            autofocus: isSearchBoxOpened,
            controller: _searchController,
            onChanged: filterList,
            focusNode: focusNode,
            decoration:  InputDecoration(
              prefixIcon:const Icon(Icons.search, color: Colors.black),
              border: InputBorder.none,
              hintText: tr("search_by_Cities"),
              hintStyle:const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ),


        Expanded(
          child: ListView.builder(
            itemCount: model.length,
            itemBuilder: (BuildContext context, int index) {
              return  InkWell(
                child:  Container(
                  margin: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image:  DecorationImage(
                      image: CachedNetworkImageProvider(widget.data.cities[index].image!),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(children: [
                   const Spacer(),

                    Center(
                      child: BlurContainerWidget(
                        height: 50,
                        borderRadius: BorderRadius.circular(10),
                        child:  Center(
                          child:  FutureBuilder(future: _translationController.getTransaltion( model[index].name!), builder: (context,snapshot){
                            if(snapshot.hasData)
                            {
                              return      Text(snapshot.data!
                                , style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              );
                            }
                            else
                            {
                              return       Text(
                                model[index].name!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: GoogleFonts.harmattan().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              );
                            }
                          }),


                        ),
                      ),
                    ),


                  ],)
                ),

                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>    CityWiseHouseList(model[index],
                      ),//const PlayList( tag: 'Playlists',title:'Podcast'),
                    ),
                  );

                },

              );
            },
          ),
        ),


      ],)



    );

  }

  void filterList(String query) {
    setState(() {
      model = originalList.where((item) => item.name.toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

}