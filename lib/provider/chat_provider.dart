import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/chat/chat_users_model.dart';
import 'package:turnarix/data/model/chat/main_message_model.dart';
import 'package:turnarix/data/model/chat_model.dart';
import 'package:turnarix/data/model/response/base/api_response.dart';
import 'package:turnarix/data/model/response/response_model.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/data/repository/chat_repo.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  final ChatRepo? chatRepo;
  ChatProvider({@required this.chatRepo});

  /////// Home conversations List
  //
  // List<ConversationModel>? _conversationList;
  // List<ConversationModel>? get conversationList => _conversationList;
  //
  // bool _convLoading = false;
  // bool get convLoading => _convLoading;
  //
  // List<String> _convOffsetList = [];
  //
  // bool _bottomConvLoading = false;
  // bool get bottomConvLoading => _bottomConvLoading;
  //
  // int? _totalConvSize;
  // int? get totalConvSize => _totalConvSize;
  //
  // String? _convOffset;
  // String? get convOffset => _convOffset;


  /////// MAIN MESSAGES List

  List<ConversationModel>? _mainMessagesList;
  List<ConversationModel>? get mainMessagesList => _mainMessagesList;

  bool _mainMessagesLoading = false;
  bool get mainMessagesLoading => _mainMessagesLoading;

  List<String> _mainMessagesOffsetList = [];

  bool _bottomMainMessagesLoading = false;
  bool get bottomMainMessagesLoading => _bottomMainMessagesLoading;

  int? _totalMainMessagesSize;
  int? get totalMainMessagesSize => _totalMainMessagesSize;

  String? _mainMessagesOffset;
  String? get mainMessagesOffset => _mainMessagesOffset;

  void getMainMessagesList(BuildContext? context, String offset) async {

    if(offset == '1'){
      _mainMessagesLoading = true;
    }

    if (!_mainMessagesOffsetList.contains(offset)) {
      _mainMessagesOffsetList.add(offset);
      ApiResponse apiResponse = await chatRepo!.getMainMessagesList(offset);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _bottomMainMessagesLoading = false;
        if (offset == '1') {
          _mainMessagesList = [];
        }
        _totalMainMessagesSize = MainMessagePaginator.fromJson(apiResponse.response!.data).totalSize;
        _mainMessagesList!.addAll(MainMessagePaginator.fromJson(apiResponse.response!.data).mainMessages!);
        _mainMessagesOffset = MainMessagePaginator.fromJson(apiResponse.response!.data).offset;
        _mainMessagesLoading = false;
      } else {
        _bottomMainMessagesLoading = false;
        _mainMessagesLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
      }
    } else {
      if(_mainMessagesLoading) {
        _bottomMainMessagesLoading = false;
        _mainMessagesLoading = false;
        //notifyListeners();
      }
    }
    notifyListeners();
  }

  void showBottomMainMessagesLoader() {
    _bottomMainMessagesLoading = true;
    notifyListeners();
  }



  /////// Users List

  List<UserInfoModel>? _usersList;
  List<UserInfoModel>? get usersList => _usersList;

  bool _usersLoading = false;
  bool get usersLoading => _usersLoading;

  List<String> _usersOffsetList = [];

  bool _bottomUsersLoading = false;
  bool get bottomUsersLoading => _bottomUsersLoading;

  int? _totalUsersSize;
  int? get totalUsersSize => _totalUsersSize;

  String? _usersOffset;
  String? get usersOffset => _usersOffset;

  void getUsersList(BuildContext? context, String offset) async {

    if(offset == '1'){
      _usersLoading = true;
    }

    if (!_usersOffsetList.contains(offset)) {
      _usersOffsetList.add(offset);
      ApiResponse apiResponse = await chatRepo!.getUsersList(offset);

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _bottomUsersLoading = false;
        if (offset == '1') {
          _usersList = [];
        }
        _totalUsersSize = ChatUsersPaginator.fromJson(apiResponse.response!.data).totalSize;
        _usersList!.addAll(ChatUsersPaginator.fromJson(apiResponse.response!.data).users!);
        _usersOffset = ChatUsersPaginator.fromJson(apiResponse.response!.data).offset;
        _usersLoading = false;
      } else {
        _bottomUsersLoading = false;
        _usersLoading = false;
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(apiResponse.error.toString())));
      }
    } else {
      if(_usersLoading) {
        _bottomUsersLoading = false;
        _usersLoading = false;
        //notifyListeners();
      }
    }
    notifyListeners();
  }

  void showBottomUsersLoader() {
    _bottomUsersLoading = true;
    notifyListeners();
  }

  void clearOffset() {
    _usersList = [];
    _usersOffsetList = [];
    _mainMessagesList = [];
    _mainMessagesOffsetList = [];
    notifyListeners();
  }

  /// CHAT LIST

  List<ChatModel>? _chatList;
  List<ChatModel>? get chatList => _chatList != null ? _chatList!.reversed.toList() : _chatList;

  File? _imageFile;
  File? get imageFile => _imageFile;

  DateTime _lastDate = DateTime.now();
  DateTime get lastDate => _lastDate;

  List<bool>? _showDate;
  List<bool>? get showDate => _showDate != null ? _showDate!.reversed.toList() : _showDate;

  List<DateTime>? _dateList;

  List<ChatModel> _savedChatList = [];
  List<ChatModel>? get savedChatList =>  _savedChatList.reversed.toList();


  bool _isSendButtonActive = false;
  bool? get isSendButtonActive => _isSendButtonActive;

  void resetChatList(){
    _chatList = [];
    _savedChatList = [];
    notifyListeners();
  }

  Future<void> getChatList(BuildContext? context, int employeeId) async {
    _chatList = null;
    _imageFile = null;
    ApiResponse apiResponse = await chatRepo!.getChatList(employeeId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _lastDate = DateTime.now();

      _chatList = [];
      _showDate = [];
      _dateList = [];
      List<dynamic> _chats = apiResponse.response!.data[0].reversed.toList();
      _chats.forEach((chat) {
        ChatModel chatModel = ChatModel.fromJson(chat);
        DateTime _originalDateTime = DateConverter.isoStringToLocalDate(chatModel.createdAt!);
        DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
        bool _addDate = false;
        if(!_dateList!.contains(_convertedDate)) {
          _addDate = true;
          _dateList!.add(_convertedDate);
        }
        _chatList!.add(chatModel);
        if(_chatList!= null){
          _savedChatList = _chatList!;
        }
        _showDate!.add(_addDate);
      });
      notifyListeners();
    } else {
      // ApiChecker.checkApi(context, apiResponse);
      notifyListeners();
     // ConnectionChecker.checkApi(context, apiResponse);
    }
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }


  /// send
  Future<void> sendMessage(String message, String token, String userID, int employeeId, BuildContext? context) async {
    http.StreamedResponse? response;
    if(_imageFile!=null){
      response = await chatRepo!.sendMessage(message, token,employeeId, _imageFile!);
    }else {
      response = await chatRepo!.sendMessage(message,token, employeeId);
    }

    if (response.statusCode == 200) {
      if(_imageFile != null) {
        getChatList(context, employeeId);
      }else {
        ChatModel _chatModel = ChatModel(
          senderId: int.parse(userID), image: null, message: message, reply: null,
          receiverId: employeeId,
          createdAt: DateTime.now().toUtc().toIso8601String(),
        );
        DateTime _originalDateTime = DateConverter.isoStringToLocalDate(_chatModel.createdAt!);
        DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
        bool _addDate = false;
        if(!_dateList!.contains(_convertedDate)) {
          _addDate = true;
          _dateList!.add(_convertedDate);
        }
        _chatList!.add(_chatModel);
        _showDate!.add(_addDate);
      }
    } else {
      print('${response.statusCode} ${response.reasonPhrase}');
    }
    _imageFile = null;
    _isSendButtonActive = false;
    notifyListeners();
  }

  void setImage(File image){
    _imageFile = image;
    notifyListeners();
  }

  void resetImage(){
    _imageFile = null;
    notifyListeners();
  }


  /// send image
  bool _sendImageLoading = false;
  bool get sendImageLoading => _sendImageLoading;

  Future<ResponseModel> sendImage(BuildContext context, File file, String token, String message,int employeeId) async {
    _sendImageLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    http.StreamedResponse response = await chatRepo!.sendImage(file, token, message, employeeId);
    // _isLoading = false;

    if (response.statusCode == 200) {
      _sendImageLoading = false;
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      _responseModel = ResponseModel(true, message);
      print(message);
      getChatList(context, employeeId);
      notifyListeners();
    } else {
      _sendImageLoading = false;
      _responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}');
      print('${response.statusCode} ${response.reasonPhrase}');
      notifyListeners();
    }
    notifyListeners();
    return _responseModel;
  }
}