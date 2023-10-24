class ImageModel {
  int? _id;
  String? _uid;
  String? _fileFolder;
  String? _fileExtension;


  ImageModel(
      {int? id,
        String? uid,
        String? fileFolder,
        String? fileExtension,
      }) {
    this._id = id;
    this._uid = uid;
    this._fileFolder = fileFolder;
    this._fileExtension = fileExtension;
  }

  int? get id => _id;
  String? get uid => _uid;
  String? get fileFolder => _fileFolder;
  String? get fileExtension => _fileExtension;

  ImageModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _fileFolder = json['file_folder'];
    _fileExtension = json['file_extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['file_folder'] = this._fileFolder;
    data['file_extension'] = this._fileExtension;

    return data;
  }
}


class Attachment {
  int? _id;
  String? _uid;
  String? _name;
  int? _messageId;
  String? _fileFolder;
  String? _createdAt;
  String? _updatedAt;

  Attachment(
      {int? id,
        String? uid,
        String? name,
        int? messageId,
        String? fileFolder,
        String? createdAt,
        String? updatedAt,
      }) {
    this._id = id;
    this._uid = uid;
    this._name = name;
    this._messageId = messageId;
    this._fileFolder = fileFolder;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  int? get messageId => _messageId;
  String? get fileFolder => _fileFolder;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Attachment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _name = json['name'];
    _messageId = json['message_id'];
    _fileFolder = json['file_folder'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['name'] = this._name;
    data['message_id'] = this._messageId;
    data['file_folder'] = this._fileFolder;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;

    return data;
  }
}