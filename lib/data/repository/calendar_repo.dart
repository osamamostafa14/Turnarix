import 'package:flutter/material.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class CalendarRepo {
  final DioClient? dioClient;
  CalendarRepo({@required this.dioClient});

  Future<ApiResponse> getCalendarShifts() async {
    try {
      final response = await dioClient!.get(AppConstants.CALENDAR_SHIFTS_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShiftIntervals() async {
    try {
      final response = await dioClient!.get(AppConstants.SHIFT_INTERVALS_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addShiftIntervalToCalendar(int intervalId, String date) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_TO_CALENDAR_URI}?selected_date=$date&interval_id=$intervalId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addVacationToCalendar(int vacationId, String date) async {
    try {
      final response = await dioClient!.post('${AppConstants.ADD_VACATION_TO_CALENDAR_URI}?selected_date=$date&vacation_id=$vacationId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeShiftFromCalendar(int calendarShiftId) async {
    try {
      final response = await dioClient!.post('${AppConstants.REMOVE_SHIFT_FROM_CALENDAR_URI}?calendar_shift_id=$calendarShiftId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeVacationFromCalendar(int calendarVacationId) async {
    try {
      final response = await dioClient!.post('${AppConstants.REMOVE_VACATION_FROM_CALENDAR_URI}?calendar_vacation_id=$calendarVacationId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}