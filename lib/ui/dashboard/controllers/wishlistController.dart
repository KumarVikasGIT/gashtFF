import 'package:gasht/api/retrofit_interface.dart';
import 'package:gasht/data_models/propertyObject.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data_models/model_propertyList.dart';
import '../../prefManager.dart';

class WishlistController extends GetxController {
  RxList<Property> wishlist = <Property>[].obs;
  String ? token;
  RetrofitInterface apiService = RetrofitInterface(Dio());

  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchWishlist();
  }
  

  // Fetch wishlist properties from API
  Future<void> fetchWishlist() async {
    try {
      token  = await PrefManager.getString("token");

      // Call your API to fetch wishlist properties


     PropertyObjects fetchedWishlist = await apiService.geWishlist(token!);
      wishlist.assignAll(fetchedWishlist.properties!);
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }

  // Add property to wishlist
  Future<void> addToWishlist(Property property) async {
    try {
      // Call your API to add property to wishlist
      await apiService.getAddDeleteWish(token!,property.id.toString(),"true","false");


      wishlist.add(property);
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  // Remove property from wishlist
  Future<void> removeFromWishlist(Property property) async {
    try {
      // Call your API to remove property from wishlist
      await apiService.getAddDeleteWish(token!,property.id.toString(),"false","true");
      wishlist.remove(property);
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }
  bool isInWishlist(Property property) {
    return wishlist.any((wishlistProperty) => wishlistProperty.id == property.id);
  }

  // Update property in wishlist
/*
  Future<void> updateWishlist(Property property) async {
    try {
      // Call your API to update property in wishlist
      await apiService.updateWishlist(property);
      int index = wishlist.indexWhere((p) => p.id == property.id);
      if (index != -1) {
        wishlist[index] = property;
      }
    } catch (e) {
      print('Error updating wishlist: $e');
    }
  }
*/
}
