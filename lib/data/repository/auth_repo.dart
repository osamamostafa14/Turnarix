import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:turnarix/utill/app_constants.dart';

class AuthRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  AuthRepo({this.dioClient, this.sharedPreferences});

  var box = Hive.box('myBox');
  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences!.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences!.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> getEmployeeRoles() async {
    try {
      final response = await dioClient!.get(AppConstants.EMPLOYEE_ROLES_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  String getUserNumber() {
    String? userNumber = sharedPreferences?.getString(AppConstants.USER_NUMBER) ?? "";
    return userNumber;
  }

  String getUserPassword() {
    String? userPassword = sharedPreferences?.getString(AppConstants.USER_PASSWORD) ?? "";
    return userPassword;
  }

  String getUserToken()  {
    print('------------------------------------------------------------------');
   // print(sharedPreferences!.getString(AppConstants.TOKEN));
     box.get(AppConstants.TOKEN);
    print('------------------------------------------------------------------');
    return box.get(AppConstants.TOKEN) ?? "";
  }


  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences!.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences!.remove(AppConstants.USER_NUMBER);
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient!.token = token;
    dioClient!.dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
     await box.put(AppConstants.TOKEN, token);
     await box.put(AppConstants.USER_TYPE, 'customer');
    //  await sharedPreferences!.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  Future<String> _saveDeviceToken() async {
    String? _deviceToken = await FirebaseMessaging.instance.getToken();
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken!;
  }

  Future<ApiResponse> updateToken() async {
    try {
      String? _deviceToken;
      if (!Platform.isAndroid) {
        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true, announcement: false, badge: true, carPlay: false,
          criticalAlert: false, provisional: false, sound: true,
        );
        if(settings.authorizationStatus == AuthorizationStatus.authorized) {
          _deviceToken = await _saveDeviceToken();
        }
      }else {
        _deviceToken = await _saveDeviceToken();
      }

      Response response = await dioClient!.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login({String? email, String? password}) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.LOGIN_URI,
        data: {"email": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<bool> clearSharedData() async {
    box.delete(AppConstants.TOKEN);
   // await sharedPreferences!.remove(AppConstants.TOKEN);
    return true;
  }

Future<ApiResponse> socialLogin({String? email, String? fullname,String? providerName, String? providerId}) async {
    try {
      Response response = await dioClient!.post(
        '${AppConstants.SOCIAL_LOGIN_URI}?email=$email&full_name=$fullname&provider_name=$providerName&provider_id=$providerId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error here $e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> registration(SignUpModel signUpModel) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.REGISTER_URI,
        data: signUpModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> checkEmail(String email, String fromUpdatePassword) async {
    try {
      Response response = await dioClient!.post(AppConstants.CHECK_EMAIL_URI, data: {"email": email, "update_password": fromUpdatePassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyToken(String email, String token) async {
    try {
      Response response = await dioClient!.post(AppConstants.VERIFY_TOKEN_URI, data: {"email": email, "reset_token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPasswordToken(String email, String token) async {
    try {
      Response response = await dioClient!.post(AppConstants.VERIFY_PASSWORD_TOKEN_URI, data: {"email": email, "reset_token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for forgot password
  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dioClient!.post(AppConstants.FORGET_PASSWORD_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String email, String password, String confirmPassword) async {
    try {
      Response response = await dioClient!.post(
        '${AppConstants.RESET_PASSWORD_URI}?email=$email&password=$password&confirm_password=$confirmPassword',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token) async {
    try {
      Response response = await dioClient!.post(AppConstants.VERIFY_EMAIL_URI, data: {"email": email, "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}