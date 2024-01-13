import 'package:flutter/material.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';

class MessagesRepo {
  final DioClient? dioClient;
  MessagesRepo({@required this.dioClient});


  // Future<ApiResponse> getMessagesList(String offset) async {
  //   try {
  //     print('success 2 --');
  //     final response = await dioClient!.get('${AppConstants.MESSAGES_URI}?offset=$offset');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     print('fail 2 -- ${e}');
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

}

