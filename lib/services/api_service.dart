import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DioApi;

import 'api_endpoint.dart';


class ApiService{


  static Future<dynamic> postRequest({
    required endpoint,
    param = const {"": ""},
  }) async {
    try {
      DioApi.Response response;
      var dio = DioApi.Dio();
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
       response = await dio.post(endpoint, data: param);

      printApiDetails(
          payload: param,
          url: ApiEndpoint.hostURL+endpoint,
          response: response
      );

      return response;
    } on DioException catch (err) {
      return null;
    }
  }

  static Future<dynamic> getRequest({endpoint, param = const {"": ""}}) async {
    try {
      DioApi.Response response;
      var dio = DioApi.Dio();
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      response = await dio.get(endpoint, queryParameters: param);

      printApiDetails(
          payload: param,
          url: ApiEndpoint.hostURL+endpoint,
          response: response
      );

      return response;
    } on DioException catch (err) {
      return null;
    }
  }

  // static Future<dynamic> createAccount({data}) async {
  //   var response = await postRequest(endpoint: ApiEndpoint.createAccount,param: data);
  //   return response;
  // }

}
printApiDetails({payload,url,response}){
  print("------------ api call start ------------");
  print("------------ api payload : ${payload}");
  print("------------ api url : ${url}");
  print("------------ api response : ${response}");
  print("------------ api call end ------------");
}