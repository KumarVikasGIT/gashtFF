import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/data_models/propertyObject.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data_models/dashboardModel.dart';
import '../../../data_models/model_propertyList.dart';
import '../../prefManager.dart';

class PropertyTypeController extends GetxController {

  RxList<PropertyType> wishlist = <PropertyType>[].obs;
  RxList<City> cityList = <City>[].obs;
  RxList<PropertyType> propertyType = <PropertyType>[].obs;
  RxList<String>terms = <String>[].obs;
  RxList<String>cancalltion = <String>[].obs;


  String ? token;
  RetrofitInterface apiService = RetrofitInterface(Dio());
  RxBool isLoading = true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWishlist();
    fetchCityList();
  }


  // Fetch wishlist properties from API
  Future<void> fetchWishlist() async {
    try {
      token  = await PrefManager.getString("token");

      // Call your API to fetch wishlist properties


      ModelDashboard fetchedWishlist = await apiService.getDashboard(token??"");
      wishlist.assignAll(fetchedWishlist.propertyTypes);
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }


  Future<void> fetchCityList()
  async {

    isLoading.value = true; // Show loading screen

  var model = await  apiService.getDashboard("");
  var model2 = await apiService.getOwnerTerms();


  if(model.status=="true")
    {
      cityList.assignAll(model.cities);
      propertyType.assignAll(model.propertyTypes);
      isLoading.value = false; // Show loading screen

    }
  if(model2.status=="true")
    {
      terms.assignAll(model2.terms!);
      cancalltion.assignAll(model2.cancellationPolicy!);
      isLoading.value = false;

    }
  }



}
