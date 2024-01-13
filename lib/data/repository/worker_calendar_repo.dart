import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerCalendarRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  WorkerCalendarRepo({ this.sharedPreferences,  this.dioClient});


  Future<ApiResponse> getCalendarShifts(int workerId) async {
    try {
      final response = await dioClient!.get('${AppConstants.WORKER_CALENDAR_SHIFTS_URI}?employee_id=$workerId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShiftIntervals(int employeeId) async {
    try {
      final response = await dioClient!.get('${AppConstants.WORKER_SHIFT_INTERVALS_URI}?employee_id=$employeeId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDayCalendarShift(DateTime date) async {
    try {
      final response = await dioClient!.get('${AppConstants.DAY_CALENDAR_SHIFTS_URI}?selected_date=$date');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}