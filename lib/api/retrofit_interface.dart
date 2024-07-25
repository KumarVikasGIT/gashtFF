import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gasht/data_models/dailyQuoteModel.dart';
import 'package:gasht/data_models/landlordDashboardModel.dart';
import 'package:gasht/data_models/model_faq.dart';
import 'package:gasht/data_models/notificationModel.dart';
import 'package:gasht/data_models/ownerTermsModel.dart';
import 'package:gasht/data_models/paymentStatusModel.dart';
import 'package:retrofit/http.dart';
import '../data_models/bookingDetailsModel.dart';
import '../data_models/bookingListModel.dart';
import '../data_models/bookpropertyModel.dart';
import '../data_models/dashboardModel.dart';
import '../data_models/modelResortAvable.dart';
import '../data_models/model_dart.dart';
import '../data_models/model_login.dart';
import '../data_models/model_privacy.dart';
import '../data_models/model_profile.dart';
import '../data_models/propertyObject.dart';
import 'customInterceptor.dart';
part 'retrofit_interface.g.dart';




@RestApi(baseUrl:"https://gasht.co/public/api/" )

//"https://dazzingshadow.com/property_app/public/api/")
abstract class RetrofitInterface {
  //factory ApiInterface(Dio dio,{String baseUrl})= _ApiInterface;


 late String ? deviceToken;

  factory RetrofitInterface(Dio dio, {String? baseUrl})  {
    dio.interceptors.add(CustomInterceptor()); // Add your custom interceptor

   // deviceToken = (await (  FirebaseMessaging.instance.getToken())!)!;



    return _RetrofitInterface(dio, baseUrl: baseUrl);
  }

  @POST("login")
  Future<Model_Login> getLogin(@Field() String email, @Field() String password,
      @Field() String user_type, @Field()String device_id);

  @POST("signup")
  Future<Model_Login> getRegister(@Field() String name,
      @Field() String email,
      @Field() String phone,
      @Field() String user_type,
      @Field() String password,
      @Field()String device_id
      );

  @POST("forget_password")
  Future<Model_Login> getForgotPassword(@Field() String email,
      @Field() String type, @Field() String user_type);

  @POST("getprofile")
  Future<Model_Profile> getProfile(@Field() String token,
      @Field() String user_type);

  @POST("setprofile")
  Future<Model_Login> setprofile(@Field() String token, @Field() String name,
      @Field() String user_type);

  @POST("verifyOTP")
  Future<Model_Login> getVerifyOTP(@Field() String email, @Field() String otp,
      @Field() String user_type);

  @POST("changePassword")
  Future<Model_Login> setChangePassword(@Field() String email,
      @Field() String password,
      @Field() String user_type,);

  @GET("termsofuse")
  Future<Model_Privacy> getTermsofuse();

  @GET("faq")
  Future<Model_Faq> getfaq();

  @GET("dailyQuote")
  Future<DailyQuoteModel> getDailyQuote();

  @POST("propertyList")
  Future<PropertyObjects> getPropertyList(
      @Field() String token,
      @Field() int city,
      @Field() String startDate,
      @Field() String endDate,
      @Field() int propertyType,);

  @POST("customerBookingList")
  Future<BookingModel> getCustomerBookingList(@Field() String token);

  @POST("ownerBookingList")
  Future<BookingModel> getOwnerBookingList(@Field() String token);

  @POST("bookingDetail")
  Future<BookingDetailsModel> getBookingDetail(@Field() String token,
      @Field() String booking_id);

  @POST("dashboard")
  Future<ModelDashboard> getDashboard(@Field() String token,);

  @POST("resort")
  Future<ModelResort> getResort(@Field() String token);

  @POST("book_property")
  Future<PropertyBookingModel> setBooking(@Field() String token,
      @Field() String property_id,
      @Field() String amount,
      @Field() String service_fee,
      @Field() String property_amount,
      @Field() String full_amount,
      @Field() String start_date,
      @Field() String end_date);

  @POST("resortAvailability")
  Future<ModelResortAvailable> getResortAvailablility(
      @Field() String token,
      @Field() String startDate,
      @Field() String endDate,
      @Field() String property_id
      );

  @POST("landlordDashboard")
  Future<ModelLandlordDashboard> getLandlordDashboard(@Field() String token);


  @POST("payment_status")
  Future<PaymentStatusModel> getPayment_status(@Field() String token);


  @POST("notifications")
  Future<NotificationModel> getNotifications(@Field() String token,@Field() String user_type);

  @POST("addDeleteWish")
  Future<Model_Login> getAddDeleteWish(
      @Field() String token,
      @Field() String property_id,
      @Field() String add,
      @Field() String delete
      );

  @POST("wishlist")
  Future<PropertyObjects> geWishlist(@Field() String token);

  @POST("addReview")
  Future<Model_Login> setReview(

      @Field() String token,
      @Field() String property_id,
      @Field() String rating,
      @Field() String comment
      );


  @POST("myPropertyList")
  Future<PropertyObjects> getMyPropertyList(@Field() String token);


  @POST("quick_contact")
  Future<Model_Login> getQuick_contact(
      @Field() String name,
      @Field() String email,
      @Field() String message,
      );


  @POST("setUnavailability")
  Future<Model_Login> setUnavailability(
      @Field() String token,
      @Field() int property_id,
      @Field() String start_date,
      @Field() String end_date,
      );



  @GET("termsCancellation")
 Future<OwnerTermsModel> getOwnerTerms();


}
/*
{
    "token":"bmrznjxgtlphrsbtybbssldxaoxirvnyhaqfreioznfmrpigml",
    "property_id":5,
    "start_date":"2024-05-01",
    "end_date":"2024-05-31"
}

*/

