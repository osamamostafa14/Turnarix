import 'dart:convert';

import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/shifts/intervals_model.dart';
import 'package:turnarix/utill/app_constants.dart';
class ShiftsRepo {
  final DioClient? dioClient;
  ShiftsRepo({this.dioClient});

  Future<ApiResponse> addNewShift(String name) async {
    try {
      final response = await dioClient!.post('${AppConstants.NEW_SHIFT_URI}?name=$name');
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

  Future<ApiResponse> getShiftsIntervals(int shiftId) async {
    try {
      final response = await dioClient!.get('${AppConstants.GET_INTERVALS_URI}?shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeShiftIntervalInfo(int shiftId, IntervalModel interval) async {
    try {
     // final response = await dioClient!.post(AppConstants.STORE_SHIFT_URI, data: shiftModel.toJson());
     final response = await dioClient!.post('${AppConstants.STORE_INTERVAL_INFO_URI}?interval=${jsonEncode(interval)}&shift_id=$shiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error: ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeNewShiftIntervalInfo(IntervalModel interval) async {
    try {
      // final response = await dioClient!.post(AppConstants.STORE_SHIFT_URI, data: shiftModel.toJson());
      final response = await dioClient!.post('${AppConstants.STORE_NEW_INTERVAL_INFO_URI}?interval=${jsonEncode(interval)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error: ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShiftslist() async {
    try {
      final response = await dioClient!.get('${AppConstants.SHIFTS_LIST_URI}?limit=10');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addShiftToCalendar(int shiftId, String date) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_TO_CALENDAR_URI}?selected_date=$date&shift_id=$shiftId');
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

  Future<ApiResponse> addShiftVacation(String startTime, String endTime, String name, int intervalId) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_VACATION_URI}?name=$name&start_date=$startTime&end_date=$endTime&interval_id=$intervalId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateVacation(String startTime, String endTime, int vacationId) async {
    try {
      final response = await dioClient!.post('${AppConstants.UPDATE_VACATION_URI}?start_date=$startTime&end_date=$endTime&vacation_id=$vacationId)');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeVacation(int vacationId) async {
    try {
      final response = await dioClient!.post('${AppConstants.REMOVE_VACATION_URI}?vacation_id=$vacationId)');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}