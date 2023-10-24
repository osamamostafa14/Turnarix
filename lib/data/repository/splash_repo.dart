import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepo({ this.sharedPreferences,  this.dioClient});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.CONFIG_URI);

      return ApiResponse.withSuccess(response);
    } catch (e) {

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<bool> removeSharedData() {
    return sharedPreferences!.clear();
  }
}