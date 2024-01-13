
class ChatPaginator {
  int? _totalSize;
  String? _limit;
  String? _offset;
  List<ChatModel>? _conversations;

  ChatPaginator(
      {int? totalSize, String? limit, String? offset, List<ChatModel>? conversations}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._conversations = conversations;

  }

  int? get totalSize => _totalSize;
  String? get limit => _limit;
  String? get offset => _offset;
  List<ChatModel>? get conversations => _conversations;


  ChatPaginator.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'].toString();
    _offset = json['offset'];

    if (json['conversations'] != null) {
      _conversations = [];
      json['conversations'].forEach((v) {
        _conversations!.add(ChatModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;

    if (this._conversations != null) {
      data['conversations'] = this._conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ChatModel {
  int? _id;
  int? _senderId;
  int? _receiverId;
  String? _message;
  String? _reply;
  String? _createdAt;
  String? _updatedAt;
  String? _image;

  ChatModel(
      {int? id,
        int? senderId,
        int? receiverId,
        String? message,
        String? reply,
        String? createdAt,
        String? updatedAt,
        String? checked,
        String? image}) {
    this._id = id;
    this._senderId = senderId;
    this._receiverId = receiverId;
    this._message = message;
    this._reply = reply;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._image = image;
  }

  int? get id => _id;
  int? get senderId => _senderId;
  int? get receiverId => _receiverId;
  String? get message => _message;
  String? get reply => _reply;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get image => _image;

  ChatModel.fromJson(Map<String?, dynamic> json) {
    _id = json['id'];
    _senderId = json['sender_id'];
    _receiverId = json['receiver_id'];
    _message = json['message'];
    _reply = json['reply'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _image = json['image'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this._id;
    data['sender_id'] = this._senderId;
    data['receiver_id'] = this._receiverId;
    data['message'] = this._message;
    data['reply'] = this._reply;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['image'] = this._image;
    return data;
  }
}