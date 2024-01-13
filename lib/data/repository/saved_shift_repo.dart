import 'dart:convert';

import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/utill/app_constants.dart';

class SavedShiftsRepo {
  final DioClient? dioClient;
  SavedShiftsRepo({this.dioClient});

  Future<ApiResponse> updateShiftName(String name, int shiftId) async {
    try {
      final response = await dioClient!.post('${AppConstants.UPDATE_SHIFT_NAME_URI}?name=$name&shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeSavedInterval(int shiftId) async {
    try {
      final response = await dioClient!.post('${AppConstants.REMOVE_INTERVAL_URI}?&interval_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addShiftIntervals(List<IntervalModel> intervals, int shiftId) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_INTERVALS_URI}?intervals=${jsonEncode(intervals)}&shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error: ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getIntervalList(int shiftId) async {
    try {
      final response = await dioClient!.get('${AppConstants.GET_INTERVALS_URI}?shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeShiftIntervalInfo(int shiftId, IntervalModel interval) async {
    try {
      final response = await dioClient!.post('${AppConstants.STORE_INTERVAL_INFO_URI}?interval=${jsonEncode(interval)}&shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error: ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}