/*
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gasht/data_models/bookingListModel.dart';
import 'package:gasht/data_models/paymentStatusModel.dart';
import 'package:gasht/util/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

import '../../api/retrofit_interface.dart';
import '../../data_models/bookpropertyModel.dart';
import '../../loadingScreen.dart';
import '../dashboard/bottomDashboard.dart';
import 'package:dio/dio.dart';


class BookingPayment extends StatelessWidget {
  PropertyBookingModel data;
  BookingPayment(this.data, {super.key});

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text("Payment Page", style: TextStyle(color: Colors.white,fontFamily: GoogleFonts.poppins().fontFamily),),

      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri("${data.url}")),
        onLoadStop: (controller, url) async {
          // The page has finished loading, check the current URL
          logger.d('Current URL == : $url');
          if (url.toString().isCaseInsensitiveContains("zaincash_success")) {

            logger.d('Current URL == : true   ');

            buildLoading(context);
            getData(url.toString()).then((data) {

              if(data.status=="true") {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Payment Successful,Booking Received"),backgroundColor: Colors.red));

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const DashboardBottom();
                    }));
              }
              else
              {
                Navigator.pop(context);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Failed, Try again"),backgroundColor: Colors.red));

              }
            });







          }
       */
/*   else

          if(url.toString() != data.url.toString())
            {
              logger.d('Current URL == : false   ');

              Navigator.pop(context);
            }*//*



        },

      ),

      //WebViewWidget(controller: controller),
    );
  }
  Future<PaymentStatusModel>  getData(String url) async {
    //   String? token = await PrefManager.getString("token");
    RetrofitInterface apiInterface = RetrofitInterface(Dio());

    int tokenIndex = url.indexOf('token=');

    // Extract the substring after 'token='
    String tokenString = tokenIndex != -1 ? url.substring(tokenIndex + 'token='.length) : "";



    return apiInterface.getPayment_status(tokenString);

  }
}
*/
