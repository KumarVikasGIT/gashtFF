import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CustomInterceptor extends Interceptor {



  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    debugPrint("Response send to server :  === $options");

    debugPrint("Response send to server :  === ${options.data}");


  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Perform tasks on response, e.g., logging
    debugPrint("Response received:  === ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Perform error handling tasks
    debugPrint("Error occurred:==  ${err.response?.statusCode} - ${err.message}");
    super.onError(err, handler);
  }
}
