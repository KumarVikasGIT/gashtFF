import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gasht/data_models/model_dart.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/retrofit_interface.dart';
import '../data_models/model_propertyList.dart';
import '../ui/prefManager.dart';

class TouristController extends GetxController{

  TextEditingController ctrCity = TextEditingController(text: 'All');

  RxList<Cities> listCities =<Cities>[
    // Cities(
    //   id: 99999,
    //   image: '',
    //   name: 'All',
    //   resorts: [],
    //   stateId: 0
    // )
  ].obs;
  List<Cities> allListCities =[];


  RxList<Property> listFilterResorts = <Property>[].obs;

  RetrofitInterface apiInterface = RetrofitInterface(Dio());
  RxBool isLoad = false.obs;

  searchCity(String query){
    listCities.value = allListCities.where((item) => item.name.toString().toLowerCase().contains(query.toLowerCase())).toList();
  }

  getCities() async {
    // isLoad.value = true;
    // String? token = await PrefManager.getString("token");
    // var data = await apiInterface.getResort(token??"");
    // if(data.status == 'true'){
    //   listCities.addAll(data.cities);
    //   List<Property> rList = [];
    //   listCities.forEach((element) {
    //     rList.addAll(element.resorts);
    //   });
    //   listFilterResorts.value = rList;
    // }
    // isLoad.value = false;

    isLoad.value = true;
    String? token = await PrefManager.getString("token");
    var data = await apiInterface.getResort(token??"");
    if(data.status == 'true'){
      allListCities = data.cities;
      listCities.value = data.cities;
    }
    isLoad.value = false;
  }

  filterResorts(id){
    List<Property> rList = [];
    if( id == 99999){
      listCities.forEach((element) {
        rList.addAll(element.resorts);
      });
    }else{
      listCities.forEach((element) {
        if(id == element.id){
          rList.addAll(element.resorts);
        }
      });
    }
    listFilterResorts.value = rList;
  }

  showCity(BuildContext context){
    Get.bottomSheet(
        Wrap(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                  ),
                  child: Text("Select City",style: TextStyle(color: Colors.white,fontSize: 18, fontFamily: GoogleFonts.harmattan().fontFamily,
                    fontWeight: FontWeight.w500,),),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: listCities.length,
                      padding: const EdgeInsets.only(bottom: 20,top: 10),
                      itemBuilder: (itemBuilder,index){
                        return InkWell(
                          onTap: (){
                            ctrCity.text = listCities[index].name.toString();
                            filterResorts(listCities[index].id);
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(tr(listCities[index].name.toString()),style: TextStyle(fontSize: 18,color: Colors.black, fontFamily: GoogleFonts.harmattan().fontFamily,
                              fontWeight: FontWeight.w500,),),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ]),
        backgroundColor: Colors.white,
        isScrollControlled: true
    );
  }

  citiesApiCall() async{
    // List<CityModel> cList = [];
    // var data = await citiesApiCall();
    // if(data != false){
    //   List list = data['cities'];
    //   cList = list.map((e) => CityModel.fromJson(e)).toList();
    //   listCities.value = cList;
    // }


    // try{
    //   DioApi.Response response;
    //   var dio = DioApi.Dio();
    //   dio.options.headers = {
    //     'Accept': 'application/json',
    //     'Content-Type': 'application/json',
    //   };
    //   String? token = await PrefManager.getString("token");
    //   response = await dio.post(ApiEndpoint.hostURL+'cities', data: {'token':token});
    //   if(response.statusCode == 200 &&  response.data['status'] == "true"){
    //     return response.data;
    //   }else{
    //     return false;
    //   }
    // }on DioApi.DioException catch(e){
    //   return false;
    // }
  }
}