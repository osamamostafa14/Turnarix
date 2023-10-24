import 'package:flutter/foundation.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class ProfileRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getUserInfo() async {
    try {
      final response = await dioClient!.get(AppConstants.CUSTOMER_INFO_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}