import 'package:blur_container/blur_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/modelResortAvable.dart';
import 'package:gasht/data_models/model_dart.dart';
import 'package:gasht/data_models/model_propertyList.dart';
import 'package:gasht/ui/prefManager.dart';
import 'package:gasht/ui/property/propertyDetails.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../api/retrofit_interface.dart';
import '../../loadingScreen.dart';
import '../../util/colors.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import '../controllers/langaugeCotroller.dart';

class CityWiseHouseList extends StatefulWidget {

  Cities cities;
   CityWiseHouseList( this.cities,  {Key? key}) : super(key: key);

  @override
  State<CityWiseHouseList> createState() => _CityWiseHouseList();
}

class _CityWiseHouseList extends State<CityWiseHouseList> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TranslationController _translationController = Get.put(TranslationController());

  String startDate = '';
  String endDate = '';
  String _range = '';

  late TabController _tabController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:Column(children: [


          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.cities.image!,),
                fit: BoxFit.fill,
              ),
            ),

            child: Column(
              children: [

                const SizedBox(height: 35,),

                Container(
                  margin: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: IconButton(onPressed: (){

                    Navigator.pop(context);

                  }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),

                ),

                const Spacer(),


                FutureBuilder(future: _translationController.getTransaltion(  widget.cities.name!),
                    builder: (context,snapshot){
                  if(snapshot.hasData)
                  {
                    return        Container(
                      margin: const EdgeInsets.only(left: 20,bottom: 50),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        snapshot.data!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: GoogleFonts.poppins.toString(),
                          fontWeight: FontWeight.w600,

                        ),
                      ),

                    );
                  }
                  else
                  {
                    return       Container(
                      margin: const EdgeInsets.only(left: 20,bottom: 50),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.cities.name!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: GoogleFonts.poppins.toString(),
                          fontWeight: FontWeight.w600,
                          height: 0.83,
                        ),
                      ),

                    );
                  }
                }),







              ],



            )
            ,
          ),


          FutureBuilder(future: _translationController.getTransaltion('discover_book_and_experience_daily_stays_effortlessly'),
              builder: (context,snapshot){
                if(snapshot.hasData)
                {
                  return       Container(
                    margin: const EdgeInsets.only(left: 20,top: 15,right: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                        color: const Color(0xFF3C3C3C),
                        fontSize: 15,
                        fontFamily: GoogleFonts.montserrat.toString(),
                        fontWeight: FontWeight.w600,
                        height: 1.70,
                        letterSpacing: 0.70,
                      ),
                    ),

                  );
                }
                else
                {
                  return       Container(
                    margin: const EdgeInsets.only(left: 20,top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Discover Tranquility and Luxury at Resorts!',
                      style: TextStyle(
                        color: const Color(0xFF3C3C3C),
                        fontSize: 15,
                        fontFamily: GoogleFonts.montserrat.toString(),
                        fontWeight: FontWeight.w600,
                        height: 1.70,
                        letterSpacing: 0.70,
                      ),
                    ),

                  );
                }
              }),







          Expanded(
            child: ListView.builder(
              itemCount: widget.cities.resorts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      child:  Container(
                        margin: const EdgeInsets.only(left: 10,right: 10, bottom: 10),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          image:  DecorationImage(
                            image: CachedNetworkImageProvider(widget.cities.resorts[index].images![0].toString()),
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
                                child:    FutureBuilder(future: _translationController.getTransaltion( widget.cities.resorts[index].propertyName!),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData)
                                      {
                                        return       Container(
                                          margin: const EdgeInsets.only(left: 20,top: 0),
                                          alignment: Alignment.centerLeft,
                                          child:Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: GoogleFonts.poppins.toString(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                        );
                                      }
                                      else
                                      {
                                        return       Container(
                                          margin: const EdgeInsets.only(left: 20,top: 0),
                                          alignment: Alignment.centerLeft,
                                          child:Text(
                                            widget.cities.resorts[index].propertyName!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontFamily: GoogleFonts.poppins.toString(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                        );
                                      }
                                    }),


                              ),
                            ),
                          ),









                        ],)
                        ,
                      ),

                      onTap: (){
                        _showDateSheet(context,widget.cities.resorts[index].id!,index);

                      },

                    )
                  ],
                );
              },
            ),
          ),


        ],)



    );

  }

  //new date

  void _showDateSheet(BuildContext context, int id,int index) {
    Get.bottomSheet(
      Container(


          margin: const EdgeInsets.only(left: 10,right: 10),


          color: Colors.white,

          // margin: EdgeInsets.only(left: 10,right: 10),
          child:

          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child:

              Container(child:
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20,20, 20, 0),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                          color:AppColors.appColor,
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs:  [

                        Tab(child: Container(
                          padding: const EdgeInsets.all(10),
                          child:  Center(
                            child:
                            FutureBuilder(future: _translationController.getTransaltion( "daily"), builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return   Text(snapshot.data!
                                  ,style: const TextStyle(

                                    fontSize: 14,

                                  ),
                                );



                              }
                              else
                              {
                                return    const Text(
                                  "Daily",
                                  style: TextStyle(fontSize: 14),
                                );
                              }
                            }),



                          ),
                        ),),
                        Tab(child: Container(
                          padding: EdgeInsets.all(10),
                          child:  Center(
                            child:
                            FutureBuilder(future: _translationController.getTransaltion( "weekly"), builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return   Text(snapshot.data!
                                  ,style: const TextStyle(

                                    fontSize: 14,

                                  ),
                                );



                              }
                              else
                              {
                                return    const Text(
                                  "Weekly",
                                  style: TextStyle(fontSize: 14),
                                );
                              }
                            }),

                          ),
                        ),),
                        Tab(child: Container(
                          padding: const EdgeInsets.all(10),
                          child:  Center(
                            child:
                            FutureBuilder(future: _translationController.getTransaltion( "monthly"), builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return   Text(snapshot.data!
                                  ,style: const TextStyle(

                                    fontSize: 14,

                                  ),
                                );



                              }
                              else
                              {
                                return    const Text(
                                  "Monthly",
                                  style: TextStyle(fontSize: 14),
                                );
                              }
                            }),

                          ),
                        ),),

                      ],
                    ),
                  ),


                  Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children:  [
                          Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                            child: Column(children: [
                              SfDateRangePicker(
                              //  controller: _controller,
                                selectionMode: DateRangePickerSelectionMode.range,
                                onSelectionChanged: _onSelectionChanged,
                                minDate: DateTime.now(),
                                startRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                endRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                rangeSelectionColor: Colors.blue.withOpacity(0.2),
                              ),
                              ElevatedButton(
                                onPressed: () {

                                  if(startDate.isEmpty || endDate.isEmpty)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the start date and end date "),backgroundColor: Colors.red));

                                  }
                                  if(startDate == endDate)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the end date "),backgroundColor: Colors.red));

                                  }



                                  /*  if(startDate == endDate)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the end date "),backgroundColor: Colors.red));

                                    }*/

                                  else {

                                    buildLoading(context);
                                    getData(id).then((data) {

                                      if(data.status=="true") {
                                        Navigator.pop(context);
                                        //  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${data.propertyDetail?.serviceFee}"),backgroundColor: Colors.red));

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyDetails(data.propertyDetail!,startDate,endDate),
                                          ),
                                        );
                                      }
                                      else
                                      {
                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Property already booked"),backgroundColor: Colors.red));

                                      }
                                    });



                                  }

                                },
                                child:

                                FutureBuilder(future: _translationController.getTransaltion('search'), builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return   Text(snapshot.data!);
                                  }
                                  else
                                  {
                                    return const   Text('search');



                                  }
                                }),



                              ),
                            ],),
                          )
                        ],
                      )
                  ),









                ],
              ),
              )
          )
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }



 /* //old sheet

  void showDateSheet(BuildContext context, int id,int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(



            color: Colors.white,



            child:

            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child:

                Container(child:
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20,20, 20, 0),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                            color:AppColors.appColor,
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: const [

                          Tab(text: 'DAILY',),
                          Tab(text: 'WEEKLY',),
                          Tab(text: 'MONTHLY',),

                        ],
                      ),
                    ),


                    Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children:  [
                            Container(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                              child: Column(children: [
                                SfDateRangePicker(
                                  selectionMode: DateRangePickerSelectionMode.range,
                                  onSelectionChanged: _onSelectionChanged,

                                  startRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                  endRangeSelectionColor: Colors.blue.withOpacity(0.6),
                                  rangeSelectionColor: Colors.blue.withOpacity(0.2),
                                ),
                                ElevatedButton(
                                  onPressed: () {


                                    if(startDate.isEmpty || endDate.isEmpty)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the start date and end date "),backgroundColor: Colors.red));

                                    }
                                    if(startDate == endDate)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select the end date "),backgroundColor: Colors.red));

                                    }

                                    else {

                                      buildLoading(context);
                                      getData(id).then((data) {

                                       if(data.status=="true") {
                                         Navigator.pop(context);
                                       //  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${data.propertyDetail?.serviceFee}"),backgroundColor: Colors.red));

                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) =>
                                                 PropertyDetails(data.propertyDetail!,startDate,endDate),
                                           ),
                                         );
                                       }
                                      else
                                        {
                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Property already booked"),backgroundColor: Colors.red));

                                        }
                                      });



                                    }


                                  },
                                  child: const Text('Submit'),
                                ),
                              ],),
                            )
                          ],
                        )
                    ),









                  ],
                ),
                )
            )
        );
      },
    );
  }

 */


  Future<ModelResortAvailable>  getData(int id) async {
 //   String? token = await PrefManager.getString("token");
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    String ? token = await PrefManager.getString("token");

    return apiInterface.getResortAvailablility(token??"",startDate,endDate,id.toString());

  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {


    // logger.d("Check-out Date:selection function $checkOutDate");
    setState(() {
      if (args.value is PickerDateRange) {

        startDate = DateFormat('dd-MM-yyyy').format(args.value.startDate);
        endDate = DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate);



        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });

  //  logger.d("Check-in Date: _range $_range,   startDate  $startDate , endDate $endDate ");



  }




}