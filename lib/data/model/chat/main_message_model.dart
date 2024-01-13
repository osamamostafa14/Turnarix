import 'package:turnarix/data/model/chat_model.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';

class MainMessagePaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<ConversationModel>? _mainMessages;

  MainMessagePaginator(
      {int? totalSize, String? limit, String? offset, List<ConversationModel>? mainMessages}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._mainMessages = mainMessages;
  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<ConversationModel>? get mainMessages => _mainMessages;

  MainMessagePaginator.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['main_messages'] != null) {
      _mainMessages = [];
      json['main_messages'].forEach((v) {
        _mainMessages!.add(ConversationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;

    if (this._mainMessages != null) {
      data['main_messages'] = this._mainMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationModel {
  int? _id;
  int? _senderId;
  int? _receiverId;
  int? _lastMessageId;
  UserInfoModel? _sender;
  UserInfoModel? _receiver;
  ChatModel? _lastMessage;
  String? _createdAt;
  String? _updatedAt;

  ConversationModel({
    int? id,
    int? senderId,
    int? receiverId,
    int? lastMessageId,
    UserInfoModel? sender,
    UserInfoModel? receiver,
    ChatModel? lastMessage,
    String? createdAt,
    String? updatedAt,
  }) {
    this._id = id;
    this._senderId = senderId;
    this._receiverId = receiverId;
    this._lastMessageId = lastMessageId;
    this._sender = sender;
    this._receiver = receiver;
    this._lastMessage = lastMessage;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  int? get senderId => _senderId;
  int? get receiverId => _receiverId;
  int? get lastMessageId => _lastMessageId;
  UserInfoModel? get sender => _sender;
  UserInfoModel? get receiver => _receiver;
  ChatModel? get lastMessage => _lastMessage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ConversationModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _senderId = json['sender_id'];
    _receiverId = json['receiver_id'];
    _lastMessageId = json['last_message_id'];

    _sender = json['sender'] != null
        ? UserInfoModel.fromJson(json['sender'])
        : null;

    _receiver = json['receiver'] != null
        ? UserInfoModel.fromJson(json['receiver'])
        : null;

    _lastMessage = json['last_message'] != null
        ? ChatModel.fromJson(json['last_message'])
        : null;

    _createdAt = json['status'];
    _updatedAt = json['blocked_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['created_at'] = this._createdAt;

    return data;
  }
}