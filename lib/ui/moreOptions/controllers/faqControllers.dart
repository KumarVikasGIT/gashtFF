import 'package:gasht/ui/prefManager.dart';
import 'package:get/get.dart';

import '../../../api/retrofit_interface.dart';
import '../../../data_models/model_faq.dart';
import '../../../data_models/model_propertyList.dart';
import 'package:dio/dio.dart';


class FAQCOontroller extends GetxController {
  RxList<Faq> properties = <Faq>[].obs;
  RxList<Faq> filteredProperties = <Faq>[].obs;
  //late Future<Model_Faq> _faqFuture; // Store the FAQ data in a future

  RxBool isLoading = true.obs;
  RetrofitInterface apiService = RetrofitInterface(Dio());

  @override
  void onInit() {
    // Fetch properties from API when the controller is initialized

    super.onInit();
  }

  // Fetch properties from API
  Future<void> fetchProperties() async {
    isLoading.value = true; // Show loading screen

    // Simulate fetching data from the API
    // Replace this with your actual API call


      RetrofitInterface apiInterface = RetrofitInterface(Dio());
      var response = await apiInterface.getfaq();
    if (response.faqs!.isEmpty) {

    }
    else{
  properties.value = response.faqs!;
   // properties.value = !;
    }


    // Initially, set filteredProperties to be the same as properties
    filteredProperties.assignAll(properties);
    isLoading.value = false; // Hide loading screen

  }

  // Filter properties based on price range and property type


  // Search properties based on property name
  void searchProperties(String query) {
    filteredProperties.assignAll(properties.where((property) {
      final lowerCaseQuery = query.toLowerCase();
      return property.title!.toLowerCase().contains(lowerCaseQuery) ||
          property.description!.toLowerCase().contains(lowerCaseQuery);
    }).toList());
  }
}
