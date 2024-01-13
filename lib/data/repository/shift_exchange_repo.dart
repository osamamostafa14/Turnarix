import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class ShiftExchangeRepo {
  final DioClient? dioClient;
  ShiftExchangeRepo({this.dioClient});

  Future<ApiResponse> requestShiftExchange(int employeeId, int userCalendarShiftId, int employeeCalendarShiftId) async {
    try {
      final response = await dioClient!.post('${AppConstants.SHIFT_EXCHANGE_URI}?employee_id=$employeeId&user_calendar_shift_id=$userCalendarShiftId&employee_calendar_shift_id=$employeeCalendarShiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getExchangeRequests(String offset, String status, String type) async {
    try {
      final response = await dioClient!.get('${AppConstants.EXCHANGE_REQUESTS_URI}?offset=$offset&limit=10&status=$status&user_type=$type');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> exchangeRequestStatus(int requestId, String status) async {
    try {
      final response = await dioClient!.post('${AppConstants.EXCHANGE_REQUEST_STATUS_URI}?request_id=$requestId&status=$status');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}