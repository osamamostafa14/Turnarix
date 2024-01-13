import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class VacationRepo {
  final DioClient? dioClient;
  VacationRepo({this.dioClient});

  Future<ApiResponse> getVacations(String offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.VACATIONS_LIST_URI}?offset=$offset&limit=10');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> storeVacation(String name) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_VACATION_URI}?name=$name');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('error: ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateVacation(String name, int vacationId) async {
    try {
      final response = await dioClient!.post('${AppConstants.UPDATE_VACATION_URI}?name=$name&vacation_id=$vacationId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteVacation(int vacationId) async {
    try {
      final response = await dioClient!.post('${AppConstants.REMOVE_VACATION_URI}?vacation_id=$vacationId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}