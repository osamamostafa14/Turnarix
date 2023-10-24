import 'package:flutter/material.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class MessagesRepo {
  final DioClient? dioClient;
  MessagesRepo({@required this.dioClient});


  Future<ApiResponse> getMessagesList(String offset) async {
    try {
      print('success 2 --');
      final response = await dioClient!.get('${AppConstants.MESSAGES_URI}?offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('fail 2 -- ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}

