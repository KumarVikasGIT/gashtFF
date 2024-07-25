import 'package:gasht/ui/prefManager.dart';
import 'package:get/get.dart';

import '../../../api/retrofit_interface.dart';
import '../../../data_models/model_propertyList.dart';
import 'package:dio/dio.dart';


class PropertyController extends GetxController {
  RxList<Property> properties = <Property>[].obs;
  RxList<Property> filteredProperties = <Property>[].obs;
  RxBool isLoading = true.obs;
  RetrofitInterface apiService = RetrofitInterface(Dio());

  @override
  void onInit() {
    // Fetch properties from API when the controller is initialized

    super.onInit();
  }

  // Fetch properties from API
  Future<void> fetchProperties(int city,String startDate,String endDate, int propertyType) async {
    isLoading.value = true; // Show loading screen

    // Simulate fetching data from the API
    // Replace this with your actual API call

    String? token = await PrefManager.getString("token");

    var response = await apiService.getPropertyList(
      token??"",
        city, startDate, endDate, propertyType);

    // Sample data

    if (response.properties!.isEmpty) {
      properties.value = [];
    }
    else{
    properties.value = response.properties!;
  }


    // Initially, set filteredProperties to be the same as properties
    filteredProperties.assignAll(properties);
    isLoading.value = false; // Hide loading screen

  }

  // Filter properties based on price range and property type
  void filterProperties(double minPrice, double maxPrice, String propertyType) {
    filteredProperties.assignAll(properties.where((property) {
      try {
        final price = int.parse(property.price!);
        final meetsPriceCriteria = price >= minPrice && price <= maxPrice;
        final meetsTypeCriteria = propertyType.isEmpty || property.propertyType!.toLowerCase() == propertyType.toLowerCase();
        return meetsPriceCriteria && meetsTypeCriteria;
      } catch (e) {
        // Handle parsing error, for example, by skipping the property
        return false;
      }
    }).toList());
  }


  // Search properties based on property name
  void searchProperties(String query) {
    filteredProperties.assignAll(properties.where((property) {
      final lowerCaseQuery = query.toLowerCase();
      return property.propertyName!.toLowerCase().contains(lowerCaseQuery) ||
          property.propertyType!.toLowerCase().contains(lowerCaseQuery) ||
          property.city!.toLowerCase().contains(lowerCaseQuery);
    }).toList());
  }






  void resetFilter()
  {
    print("properties list length ==== ${properties.length}");

    filteredProperties = properties;

  }


  void ratingFilter()
  {
    filteredProperties.sort((a,b)=> int.parse(b.avgRating!).compareTo(int.parse(a.avgRating!)));
   // ratingList.sort((a, b) => b.rating.compareTo(a.rating));

  }
  RxSet<String> selectedIds = <String>{}.obs;

  void toggleSelection(String id) {
    print("Selected property types ==>>$id");

    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

     filteredProperties.assignAll(properties.where((property) => selectedIds.contains(property.propertyType)).toList());




  }

  void offerFilter() {

   filteredProperties.assignAll(
     properties.where((discount) => discount.discount != "0%") // Filter out "0%" discounts
        .toList()
      ..sort((a, b) => b.discount!.compareTo(a.discount!))); // Sort in descending order



  }


}
