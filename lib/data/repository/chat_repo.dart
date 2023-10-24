import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:turnarix/data/datasource/remote/dio/dio_client.dart';
import 'package:turnarix/data/datasource/remote/exception/api_error_handler.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/utill/app_constants.dart';

class ChatRepo {
  final DioClient? dioClient;
  ChatRepo({@required this.dioClient});

  Future<ApiResponse> getChatList() async {
    try {
      final response = await dioClient!.get('${AppConstants.MESSAGE_URI}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getChatHistoryList(String offset) async {
    try {
      print('success 2 --');
      final response = await dioClient!.get('${AppConstants.MESSAGE_HISTORY_URI}?offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('fail 2 -- ${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> sendMessage(String message, String token, [File? file]) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SEND_MESSAGE_URI}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'message': message
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> sendImage(File file, String token, String message,serviceId, String imageId) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SEND_IMAGE_URI}?message=$message&image_id=$imageId&service_id=$serviceId'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${token}'});
    if(file != null) {
      print('----------------${file.readAsBytes().asStream()}/${file.lengthSync()}/${file.path.split('/').last}');
      request.files.add(http.MultipartFile('image', new http.ByteStream(DelegatingStream.typed(file.openRead())), file.lengthSync(), filename: file.path.split('/').last));
    }

    Map<String, String> _fields = Map();
    {
      _fields.addAll(<String, String>{
        '_method': 'post',
      });
    }
    request.fields.addAll(_fields);

    http.StreamedResponse response = await request.send();
    print("Test responce");
    //
    print(response);
    return response;

  }
}

