// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_interface.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RetrofitInterface implements RetrofitInterface {
  _RetrofitInterface(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://gasht.co/public/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Model_Login> getLogin(
    String email,
    String password,
    String user_type,
    String device_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'user_type': user_type,
      'device_id': device_id,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> getRegister(
    String name,
    String email,
    String phone,
    String user_type,
    String password,
    String device_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'email': email,
      'phone': phone,
      'user_type': user_type,
      'password': password,
      'device_id': device_id,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'signup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> getForgotPassword(
    String email,
    String type,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'type': type,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'forget_password',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Profile> getProfile(
    String token,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Profile>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'getprofile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Profile.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> setprofile(
    String token,
    String name,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'name': name,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'setprofile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> getVerifyOTP(
    String email,
    String otp,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'otp': otp,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'verifyOTP',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> setChangePassword(
    String email,
    String password,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'changePassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Privacy> getTermsofuse() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Privacy>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'termsofuse',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Privacy.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Faq> getfaq() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Faq>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'faq',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Faq.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DailyQuoteModel> getDailyQuote() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DailyQuoteModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'dailyQuote',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DailyQuoteModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PropertyObjects> getPropertyList(
    String token,
    int city,
    String startDate,
    String endDate,
    int propertyType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'city': city,
      'startDate': startDate,
      'endDate': endDate,
      'propertyType': propertyType,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PropertyObjects>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'propertyList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PropertyObjects.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingModel> getCustomerBookingList(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BookingModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'customerBookingList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingModel> getOwnerBookingList(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BookingModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'ownerBookingList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BookingDetailsModel> getBookingDetail(
    String token,
    String booking_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'booking_id': booking_id,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BookingDetailsModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'bookingDetail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BookingDetailsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ModelDashboard> getDashboard(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelDashboard>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'dashboard',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ModelDashboard.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ModelResort> getResort(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResort>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'resort',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ModelResort.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PropertyBookingModel> setBooking(
    String token,
    String property_id,
    String amount,
    String service_fee,
    String property_amount,
    String full_amount,
    String start_date,
    String end_date,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'property_id': property_id,
      'amount': amount,
      'service_fee': service_fee,
      'property_amount': property_amount,
      'full_amount': full_amount,
      'start_date': start_date,
      'end_date': end_date,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PropertyBookingModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'book_property',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PropertyBookingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ModelResortAvailable> getResortAvailablility(
    String token,
    String startDate,
    String endDate,
    String property_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'startDate': startDate,
      'endDate': endDate,
      'property_id': property_id,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResortAvailable>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'resortAvailability',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ModelResortAvailable.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ModelLandlordDashboard> getLandlordDashboard(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelLandlordDashboard>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'landlordDashboard',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ModelLandlordDashboard.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentStatusModel> getPayment_status(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PaymentStatusModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'payment_status',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaymentStatusModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NotificationModel> getNotifications(
    String token,
    String user_type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'user_type': user_type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<NotificationModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'notifications',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = NotificationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> getAddDeleteWish(
    String token,
    String property_id,
    String add,
    String delete,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'property_id': property_id,
      'add': add,
      'delete': delete,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'addDeleteWish',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PropertyObjects> geWishlist(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PropertyObjects>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'wishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PropertyObjects.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> setReview(
    String token,
    String property_id,
    String rating,
    String comment,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'property_id': property_id,
      'rating': rating,
      'comment': comment,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'addReview',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PropertyObjects> getMyPropertyList(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PropertyObjects>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'myPropertyList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PropertyObjects.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> getQuick_contact(
    String name,
    String email,
    String message,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'email': email,
      'message': message,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'quick_contact',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Model_Login> setUnavailability(
    String token,
    int property_id,
    String start_date,
    String end_date,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'property_id': property_id,
      'start_date': start_date,
      'end_date': end_date,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Model_Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'setUnavailability',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Model_Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OwnerTermsModel> getOwnerTerms() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OwnerTermsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'termsCancellation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OwnerTermsModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }

  @override
  String? deviceToken;
}
